/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2017-18 Mandelbulber Team     §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * Full kernel for rendering opencl with missing effects
 */

//defined to force recompilation of kernels on NVidia cards with new releases
#define MANDELBULBER_VERSION 2.16

int GetInteger(int byte, __global char *array)
{
	__global int *intPointer = (__global int *)&array[byte];
	return *intPointer;
}

//------------------ MAIN RENDER FUNCTION --------------------
kernel void fractal3D(__global sClPixel *out, __global char *inBuff, __global char *inTextureBuff,
	__constant sClInConstants *consts, image2d_t image2dBackground, int initRandomSeed)
{
	// get actual pixel
	const int imageX = get_global_id(0);
	const int imageY = get_global_id(1);
	const int cl_offsetX = get_global_offset(0);
	const int cl_offsetY = get_global_offset(1);
	const int buffIndex = (imageX - cl_offsetX) + (imageY - cl_offsetY) * get_global_size(0);

	// randomizing random seed
	int randomSeed = imageX + imageY * consts->params.imageWidth + initRandomSeed;
	for (int i = 0; i < 10; i++)
	{
		randomSeed = RandomInt(&randomSeed);
	}

	float2 screenPoint = (float2){convert_float(imageX), convert_float(imageY)};
	float width = convert_float(consts->params.imageWidth);
	float height = convert_float(consts->params.imageHeight);
	float resolution = 1.0f / height;

	//-------- decode main data file ----------------
	// main offset for materials
	int materialsMainOffset = GetInteger(0, inBuff);
	int AOVectorsMainOffset = GetInteger(1 * sizeof(int), inBuff);
	int lightsMainOffset = GetInteger(2 * sizeof(int), inBuff);
	int primitivesMainOffset = GetInteger(3 * sizeof(int), inBuff);
	int objectsMainOffset = GetInteger(4 * sizeof(int), inBuff);

	//--- materials
	__global sMaterialCl *materials[MAT_ARRAY_SIZE];
	__global float4 *palettes[MAT_ARRAY_SIZE];
	int paletteLengths[MAT_ARRAY_SIZE];

	// number of materials
	int numberOfMaterials = GetInteger(materialsMainOffset, inBuff);

	for (int i = 0; i < MAT_ARRAY_SIZE; i++)
	{
		// material offset:
		const int materialAddressOffset = materialsMainOffset + (i + 1) * sizeof(int);
		int materialOffset = GetInteger(materialAddressOffset, inBuff);

		// material header
		int materialClOffset = GetInteger(materialOffset, inBuff);
		int paletteItemsOffset = GetInteger(materialOffset + sizeof(int), inBuff);
		int paletteSize = GetInteger(materialOffset + sizeof(int) * 2, inBuff);
		int paletteLengthTemp = GetInteger(materialOffset + sizeof(int) * 3, inBuff);
		paletteLengths[i] = paletteLengthTemp;

		// material data
		__global sMaterialCl *materialTemp = (__global sMaterialCl *)&inBuff[materialClOffset];
		materials[i] = materialTemp;

		// palette data
		__global float4 *paletteTemp = (__global float4 *)&inBuff[paletteItemsOffset];
		palettes[i] = paletteTemp;
	}

	//--- AO vectors

	// AO vectors count
	int AOVectorsCount = GetInteger(AOVectorsMainOffset, inBuff);
	int AOVectorsOffset = GetInteger(AOVectorsMainOffset + 1 * sizeof(int), inBuff);

	__global sVectorsAroundCl *__attribute__((aligned(16))) AOVectors =
		(__global sVectorsAroundCl *)&inBuff[AOVectorsOffset];

	//--- Lights

	// AO vectors count
	int numberOfLights = GetInteger(lightsMainOffset, inBuff);
	int lightssOffset = GetInteger(lightsMainOffset + 1 * sizeof(int), inBuff);

	__global sLightCl *__attribute__((aligned(16))) lights =
		(__global sLightCl *)&inBuff[lightssOffset];

	//--- Primitives

	// primitives count
	int numberOfPrimitives = GetInteger(primitivesMainOffset, inBuff);
	int primitivesGlobalPositionOffset = GetInteger(primitivesMainOffset + 1 * sizeof(int), inBuff);
	int primitivesOffset = GetInteger(primitivesMainOffset + 2 * sizeof(int), inBuff);

	// global position of primitives
	__global sPrimitiveGlobalPositionCl *primitivesGlobalPosition =
		(__global sPrimitiveGlobalPositionCl *)&inBuff[primitivesGlobalPositionOffset];

	// data for primitives
	__global sPrimitiveCl *__attribute__((aligned(16))) primitives =
		(__global sPrimitiveCl *)&inBuff[primitivesOffset];

	//--- Objects

	int numberOfObjects = GetInteger(objectsMainOffset, inBuff);
	int objectsOffset = GetInteger(objectsMainOffset + 1 * sizeof(int), inBuff);

	__global sObjectDataCl *__attribute__((aligned(16))) objectsData =
		(__global sObjectDataCl *)&inBuff[objectsOffset];

//--------- end of data file ----------------------------------

//------------------ decode texture data -----------
#ifdef USE_TEXTURES
	__global char4 *textures[NUMBER_OF_TEXTURES];
	int2 textureSizes[NUMBER_OF_TEXTURES];

	for (int i = 0; i < NUMBER_OF_TEXTURES; i++)
	{
		int textureMainOffset = GetInteger(i * sizeof(int), inTextureBuff);
		int textureDataOffset = GetInteger(textureMainOffset + 0 * sizeof(int), inTextureBuff);
		int textureWidth = GetInteger(textureMainOffset + 1 * sizeof(int), inTextureBuff);
		int textureHeight = GetInteger(textureMainOffset + 2 * sizeof(int), inTextureBuff);
		textureSizes[i] = (int2){textureWidth, textureHeight};

		__global uchar4 *texture = (__global uchar4 *)&inTextureBuff[textureDataOffset];
		textures[i] = texture;
	}
#endif
	//------------------ end of texture data -----------

	// auxiliary vectors
	const float3 one = (float3){1.0f, 0.0f, 0.0f};
	const float3 ones = 1.0f;

	// main rotation matrix
	matrix33 rot;
	rot.m1 = (float3){1.0f, 0.0f, 0.0f};
	rot.m2 = (float3){0.0f, 1.0f, 0.0f};
	rot.m3 = (float3){0.0f, 0.0f, 1.0f};

	rot = RotateZ(rot, consts->params.viewAngle.x);
	rot = RotateX(rot, consts->params.viewAngle.y);
	rot = RotateY(rot, consts->params.viewAngle.z);

	// main light vector
	float lightAlpha = consts->params.mainLightAlpha / 180.0f * M_PI_F;
	float lightBeta = consts->params.mainLightBeta / 180.0f * M_PI_F;
	float3 lightVector = (float3){cos(lightAlpha - 0.5f * M_PI_F) * cos(lightBeta),
		sin(lightAlpha - 0.5f * M_PI_F) * cos(lightBeta), sin(lightBeta)};
	if (consts->params.mainLightPositionAsRelative) lightVector = Matrix33MulFloat3(rot, lightVector);

	// sweet spot rotation
	rot = RotateZ(rot, -consts->params.sweetSpotHAngle);
	rot = RotateX(rot, consts->params.sweetSpotVAngle);

	matrix33 rotInv = TransposeMatrix(rot);

	// starting point for ray-marching
	float3 start = consts->params.camera;

// view vector
#ifdef PERSP_EQUIRECTANGULAR
	float aspectRatio = 2.0f;
#else
	float aspectRatio = width / height;
#endif
	float2 normalizedScreenPoint;
	normalizedScreenPoint.x = (screenPoint.x / width - 0.5f) * aspectRatio;
	normalizedScreenPoint.y = -(screenPoint.y / height - 0.5f);
	if (consts->params.legacyCoordinateSystem) normalizedScreenPoint.y *= -1.0f;

#ifdef MONTE_CARLO_ANTI_ALIASING
	normalizedScreenPoint.x += (Random(1000.0f, &randomSeed) / 1000.0f - 0.5f) / width * aspectRatio;
	normalizedScreenPoint.y += (Random(1000.0f, &randomSeed) / 1000.0f - 0.5f) / height;
#endif

	float3 viewVectorNotRotated = CalculateViewVector(normalizedScreenPoint, consts->params.fov);
	float3 viewVector = Matrix33MulFloat3(rot, viewVectorNotRotated);

#ifdef MONTE_CARLO_DOF
	MonteCarloDOF(&start, &viewVector, consts, rot, &randomSeed);
#endif

#ifdef CHROMATIC_ABERRATION
	float hue = Random(3600, &randomSeed) / 10.0f;
	float3 rgbFromHsv = Hsv2rgb(fmod(360.0f + hue - 60.0f, 360.0f), 1.0f, 1.0f) * 2.0f;
	float3 randVector =
		(float3){0.0f, hue / 20000.0f * consts->params.DOFMonteCarloCACameraDispersion, 0.0f};
	float3 randVectorRot = Matrix33MulFloat3(rot, randVector);
	viewVector -= randVectorRot;
	viewVector = normalize(viewVector);
#endif

#ifdef PERSP_FISH_EYE_CUT
	bool hemisphereCut = false;
	if (length(normalizedScreenPoint) > 0.5f / consts->params.fov) hemisphereCut = true;
#endif

	float4 color4 = 0.0f;
	float opacityOut;
	float3 surfaceColor = 0.0f;

	float3 point;
	float depth = 0.0f;

	int reflectionsMax = consts->params.reflectionsMax;
	if (!consts->params.raytracedReflections) reflectionsMax = 0;

	sRenderData renderData;
	renderData.lightVector = lightVector;
	renderData.viewVectorNotRotated = viewVectorNotRotated;
	renderData.materials = materials;
	renderData.palettes = palettes;
	renderData.AOVectors = AOVectors;
	renderData.lights = lights;
	renderData.paletteLengths = paletteLengths;
	renderData.numberOfLights = numberOfLights;
	renderData.AOVectorsCount = AOVectorsCount;
	renderData.reflectionsMax = reflectionsMax;
	renderData.primitives = primitives;
	renderData.numberOfPrimitives = numberOfPrimitives;
	renderData.primitivesGlobalPosition = primitivesGlobalPosition;
	renderData.objectsData = objectsData;
	renderData.mRot = rot;
	renderData.mRotInv = rotInv;
#ifdef USE_TEXTURES
	renderData.textures = textures;
	renderData.textureSizes = textureSizes;
#endif
#ifdef CHROMATIC_ABERRATION
	renderData.hue = hue;
#endif

	float4 resultShader = 0.0f;
	float3 objectColour = 0.0f;
	float3 normal;
	float opacity = 0.0f;

#ifdef PERSP_FISH_EYE_CUT
	if (!hemisphereCut)
	{
#endif // PERSP_FISH_EYE_CUT

		sRayRecursionIn recursionIn;

		sRayMarchingIn rayMarchingIn;
		rayMarchingIn.binaryEnable = true;
		rayMarchingIn.direction = normalize(viewVector);
		rayMarchingIn.maxScan = consts->params.viewDistanceMax;
		rayMarchingIn.minScan = 0.0f;
		rayMarchingIn.start = start;
		rayMarchingIn.invertMode = false;
		recursionIn.rayMarchingIn = rayMarchingIn;
		recursionIn.calcInside = false;
		recursionIn.resultShader = resultShader;
		recursionIn.objectColour = objectColour;
		recursionIn.rayBranch = rayBranchReflection;

		sRayRecursionOut recursionOut =
			RayRecursion(recursionIn, &renderData, consts, image2dBackground, &randomSeed);
		resultShader = recursionOut.resultShader;
		objectColour = recursionOut.objectColour;
		depth = recursionOut.rayMarchingOut.depth;
		if (!recursionOut.found) depth = 1e20f;
		opacity = recursionOut.fogOpacity;
		normal = recursionOut.normal;

#ifdef PERSP_FISH_EYE_CUT
	}
#endif // PERSP_FISH_EYE_CUT

	sClPixel pixel;

#ifdef CHROMATIC_ABERRATION
	pixel.R = resultShader.s0 * rgbFromHsv.s0;
	pixel.G = resultShader.s1 * rgbFromHsv.s1;
	pixel.B = resultShader.s2 * rgbFromHsv.s2;
#else
	pixel.R = resultShader.s0;
	pixel.G = resultShader.s1;
	pixel.B = resultShader.s2;
#endif

	pixel.zBuffer = depth;
	pixel.colR = objectColour.s0 * 256.0f;
	pixel.colG = objectColour.s1 * 256.0f;
	pixel.colB = objectColour.s2 * 256.0f;
	pixel.opacity = opacity * 65535;
	pixel.alpha = resultShader.s3 * 65535;

	out[buffIndex] = pixel;
}
