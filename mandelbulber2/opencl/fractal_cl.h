/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2014-17 Mandelbulber Team     §R-==%w["'~5]m%=L.=~5N
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
 * sFractalCl struct - container for fractal formula parameters
 *       ____                   ________
 *      / __ \____  ___  ____  / ____/ /
 *     / / / / __ \/ _ \/ __ \/ /   / /
 *    / /_/ / /_/ /  __/ / / / /___/ /___
 *    \____/ .___/\___/_/ /_/\____/_____/
 *        /_/
 *
 * This file has been autogenerated by tools/populateOpenCL.php
 * from the file src/fractal.h
 * D O    N O T    E D I T    T H I S    F I L E !
 */

#ifndef MANDELBULBER2_OPENCL_FRACTAL_CL_H_
#define MANDELBULBER2_OPENCL_FRACTAL_CL_H_

#ifndef OPENCL_KERNEL_CODE
#include "../src/fractal_enums.h"
#include "../opencl/opencl_algebra.h"
#include "../opencl/common_params_cl.hpp"
#include "../opencl/image_adjustments_cl.h"
#include "../src/common_params.hpp"
#include "../src/image_adjustments.h"
#include "../src/fractparams.hpp"
#include "../src/fractal.h"
#endif /* OPENCL_KERNEL_CODE */

#define IFS_VECTOR_COUNTCl 9
#define HYBRID_COUNTCl 5
#define MANDELBOX_FOLDSCl 2

typedef struct
{
	cl_int i;
	cl_float r_dz;
	cl_float r;
	cl_float DE;
	cl_float color;
	cl_float actualScale;
	cl_float pseudoKleinianDE;
	cl_float linearDE;
	cl_float cw;
	cl_float foldFactor;
	cl_float minRFactor;
	cl_float scaleFactor;
	cl_float4 c;
	cl_float4 const_c;
} sExtendedAuxCl;

typedef struct
{
	cl_float3 factor;
	cl_float4 factor4D;
	cl_float factorR;
	cl_float factorSp1;
	cl_float factorSp2;
	cl_float colorMin;
	cl_float compFold0;
	cl_float compFold;
	cl_float compMinR;
	cl_float compScale;
} sFoldColorCl;

typedef struct
{

	cl_float3 Nv_tet[4];
	cl_float3 Nv_cube[6];
	cl_float3 Nv_oct[8];
	cl_float3 Nv_oct_cube[14];
	cl_float3 Nv_dodeca[12];
	cl_float3 Nv_icosa[20];
	cl_float3 Nv_box6[8];
	cl_float3 Nv_box5[7];
	cl_int sides_tet;
	cl_int sides_cube;
	cl_int sides_oct;
	cl_int sides_oct_cube;
	cl_int sides_dodeca;
	cl_int sides_icosa;
	cl_int sides_box6;
	cl_int sides_box5;
} sFractalGeneralizedFoldBoxCl;

typedef struct
{
	cl_int absX;
	cl_int absY;
	cl_int absZ;
	cl_int enabled[IFS_VECTOR_COUNTCl];
	cl_int mengerSpongeMode;
	cl_int rotationEnabled;
	cl_int edgeEnabled;
	matrix33 mainRot;
	matrix33 rot[IFS_VECTOR_COUNTCl];
	cl_float4 direction[IFS_VECTOR_COUNTCl];
	cl_float3 edge;
	cl_float4 offset;
	cl_float3 rotations[IFS_VECTOR_COUNTCl];
	cl_float distance[IFS_VECTOR_COUNTCl];
	cl_float intensity[IFS_VECTOR_COUNTCl];
	cl_float3 rotation;
	cl_float scale;
} sFractalIFSCl;

typedef struct
{
	cl_float fold;
	cl_float minR;
	cl_float scaleVary;
	cl_float wadd;
	cl_float rPower;
} sFractalMandelboxVary4DCl;

typedef struct
{
	cl_float3 rotationMain;
	cl_float3 rotation[MANDELBOX_FOLDSCl][3];
	sFoldColorCl color;
	cl_float scale;
	cl_float foldingLimit;
	cl_float foldingValue;
	cl_float foldingSphericalMin;
	cl_float foldingSphericalFixed;
	cl_float sharpness;
	cl_float solid;
	cl_float melt;
	cl_float4 offset;
	cl_int rotationsEnabled;
	cl_int mainRotationEnabled;
	matrix33 mainRot;
	matrix33 rot[MANDELBOX_FOLDSCl][3];
	matrix33 rotinv[MANDELBOX_FOLDSCl][3];

	cl_float fR2;
	cl_float mR2;
	cl_float mboxFactor1;
} sFractalMandelboxCl;

typedef struct
{
	cl_float zFactor;
	cl_float foldFactor;
} sFractalBoxFoldBulbPow2Cl;

typedef struct
{
	cl_float power;
	cl_float alphaAngleOffset;
	cl_float betaAngleOffset;
	cl_float gammaAngleOffset;
} sFractalMandelbulbCl;

typedef struct
{
	cl_float cadd;
} sFractalAexionCl;

typedef struct
{
	cl_int preabsx;
	cl_int preabsy;
	cl_int preabsz;
	cl_int absx;
	cl_int absy;
	cl_int absz;
	cl_int posz;
} sFractalBuffaloCl;

typedef struct
{
	cl_float ringRadius;
	cl_float ringThickness;
	cl_float factor;
	cl_float number;
} sFractalDonutCl;

//----------------------------------------------------------
typedef struct
{
	cl_float frequency;
	cl_float amplitude;
	cl_float rhoMul;
} sFractalPlatonicSolidCl;

// mandelbulb multi
typedef enum { multi_acosOrAsinCl_acos, multi_acosOrAsinCl_asin } enumMulti_acosOrAsinCl;

typedef enum { multi_atanOrAtan2Cl_atan, multi_atanOrAtan2Cl_atan2 } enumMulti_atanOrAtan2Cl;

typedef enum {
	multi_OrderOfXYZCl_xyz,
	multi_OrderOfXYZCl_xzy,
	multi_OrderOfXYZCl_yxz,
	multi_OrderOfXYZCl_yzx,
	multi_OrderOfXYZCl_zxy,
	multi_OrderOfXYZCl_zyx
} enumMulti_OrderOfXYZCl;
typedef struct
{
	enumMulti_acosOrAsinCl acosOrAsin;
	enumMulti_acosOrAsinCl acosOrAsinA;
	enumMulti_atanOrAtan2Cl atanOrAtan2;
	enumMulti_atanOrAtan2Cl atanOrAtan2A;

	enumMulti_OrderOfXYZCl orderOfXYZ;
	enumMulti_OrderOfXYZCl orderOfXYZ2;
	enumMulti_OrderOfXYZCl orderOfXYZC;
} sFractalMandelbulbMultiCl;

// sinTan2Trig
typedef enum { multi_asinOrAcosCl_asin, multi_asinOrAcosCl_acos } enumMulti_asinOrAcosCl;

typedef enum { multi_atan2OrAtanCl_atan2, multi_atan2OrAtanCl_atan } enumMulti_atan2OrAtanCl;

typedef enum {
	multi_OrderOfZYXCl_zyx,
	multi_OrderOfZYXCl_zxy,
	multi_OrderOfZYXCl_yzx,
	multi_OrderOfZYXCl_yxz,
	multi_OrderOfZYXCl_xzy,
	multi_OrderOfZYXCl_xyz
} enumMulti_OrderOfZYXCl;
typedef struct
{
	enumMulti_asinOrAcosCl asinOrAcos;
	enumMulti_atan2OrAtanCl atan2OrAtan;
	enumMulti_OrderOfZYXCl orderOfZYX;
} sFractalSinTan2TrigCl;

// surf fold box
typedef enum {
	multi_orderOfFoldsCl_type1,
	multi_orderOfFoldsCl_type2,
	multi_orderOfFoldsCl_type3,
	multi_orderOfFoldsCl_type4,
	multi_orderOfFoldsCl_type5
} enumMulti_orderOfFoldsCl;
typedef struct
{
	enumMulti_orderOfFoldsCl orderOfFolds1;
	enumMulti_orderOfFoldsCl orderOfFolds2;
	enumMulti_orderOfFoldsCl orderOfFolds3;
	enumMulti_orderOfFoldsCl orderOfFolds4;
	enumMulti_orderOfFoldsCl orderOfFolds5;
} sFractalSurfFoldsCl;

// benesi mag transforms
typedef enum {
	multi_orderOfTransfCl_typeT1,
	multi_orderOfTransfCl_typeT1Mod,
	multi_orderOfTransfCl_typeT2,
	multi_orderOfTransfCl_typeT3,
	multi_orderOfTransfCl_typeT4,
	multi_orderOfTransfCl_typeT5b,
} enumMulti_orderOfTransfCl;
typedef struct
{
	enumMulti_orderOfTransfCl orderOfTransf1;
	enumMulti_orderOfTransfCl orderOfTransf2;
	enumMulti_orderOfTransfCl orderOfTransf3;
	enumMulti_orderOfTransfCl orderOfTransf4;
	enumMulti_orderOfTransfCl orderOfTransf5;
} sFractalMagTransformsCl;

// basic combo
typedef enum {
	comboCl_mode0,
	comboCl_mode1,
	comboCl_mode2,
	comboCl_mode3,
	comboCl_mode4,
	comboCl_mode5,
	comboCl_mode6,
	comboCl_mode7,
} enumComboCl;
typedef struct
{
	enumComboCl modeA;
	//		combo modeB;
	//		combo modeC;
} sFractalComboCl;

// for surfbox types
typedef struct
{
	cl_int enabledX1;
	cl_int enabledY1;
	cl_int enabledZ1;
	cl_int enabledX2False;
	cl_int enabledY2False;
	cl_int enabledZ2False;
	cl_int enabledX3False;
	cl_int enabledY3False;
	cl_int enabledZ3False;
	cl_int enabledX4False;
	cl_int enabledY4False;
	cl_int enabledZ4False;
	cl_int enabledX5False;
	cl_int enabledY5False;
	cl_int enabledZ5False;
	cl_float3 offset1A111;
	cl_float3 offset1B111;
	cl_float3 offset2A111;
	cl_float3 offset2B111;
	cl_float3 offset3A111;
	cl_float3 offset3B111;
	cl_float3 offset1A222;
	cl_float3 offset1B222;
	cl_float scale1Z1;
} sFractalSurfBoxCl;

// for curvilinear
typedef struct
{
	cl_int enabledLinear;
	cl_int enabledCurves;
	cl_int enabledParabFalse;
	cl_int enabledParaAddP0;
	cl_float para00;
	cl_float paraA0;
	cl_float paraB0;
	cl_float paraC0;
	cl_float parabOffset0;
	cl_float para0;
	cl_float paraA;
	cl_float paraB;
	cl_float paraC;
	cl_float parabOffset;
	cl_float parabSlope;
	cl_float parabScale;
	cl_int iterA;
	cl_int iterB;
	cl_int iterC;
} sFractalCparaCl;

typedef struct
{
	cl_int enabledFalse;
	cl_int enabledAuxR2False;
	cl_float scale1;
	cl_float tweak005;
	cl_float offset0;
	cl_float offset1;
	cl_float offset2;
	cl_float factor2;
	cl_float scaleLin;
	cl_float offsetLin;
} sFractalAnalyticDECl;

// common parameters for transforming formulas
typedef struct
{
	cl_float alphaAngleOffset;
	cl_float betaAngleOffset;
	cl_float foldingValue;
	cl_float foldingLimit;
	cl_float offset;
	cl_float offset0;
	cl_float offsetA0;
	cl_float offsetB0;
	cl_float offsetC0;
	cl_float offset0005;
	cl_float offset05;
	cl_float offset1;
	cl_float offset105;
	cl_float offset2;
	cl_float multiplication;
	cl_float minRNeg1;
	cl_float minR0;
	cl_float minR05;
	cl_float minR06;
	cl_float minR2p25;
	cl_float maxR2d1;
	cl_float maxMinR2factor;
	cl_float scale;
	cl_float scale0;
	cl_float scale025;
	cl_float scale05;
	cl_float scale08;
	cl_float scale1;
	cl_float scaleA1;
	cl_float scaleB1;
	cl_float scaleC1;
	cl_float scaleD1;
	cl_float scaleE1;
	cl_float scaleF1;
	cl_float scaleG1;
	cl_float scaleA2;
	cl_float scale015;
	cl_float scale2;
	cl_float scale3;
	cl_float scaleA3;
	cl_float scaleB3;
	cl_float scale4;
	cl_float scale8;
	cl_float pwr05;
	cl_float pwr4;
	cl_float pwr8;
	cl_float pwr8a;
	cl_float sqtR;
	cl_float mboxFactor1;

	cl_int startIterations;
	cl_int startIterations250;
	cl_int stopIterations;
	cl_int startIterationsA;
	cl_int stopIterationsA;
	cl_int startIterationsB;
	cl_int stopIterationsB;
	cl_int startIterationsC;
	cl_int stopIterationsC;
	cl_int stopIterationsC1;
	cl_int startIterationsD;
	cl_int stopIterationsD;
	cl_int stopIterationsD1;
	cl_int startIterationsE;
	cl_int stopIterationsE;
	cl_int startIterationsF;
	cl_int stopIterationsF;
	cl_int startIterationsP;
	cl_int stopIterationsP1;
	cl_int startIterationsR;
	cl_int stopIterationsR;
	cl_int startIterationsS;
	cl_int stopIterationsS;
	cl_int startIterationsT;
	cl_int stopIterationsT;
	cl_int startIterationsM;
	cl_int stopIterationsM;
	cl_int stopIterations1;
	cl_int stopIterationsT1;
	cl_int stopIterationsTM1;
	cl_int startIterationsX;
	cl_int stopIterationsX;
	cl_int startIterationsY;
	cl_int stopIterationsY;
	cl_int startIterationsZ;
	cl_int stopIterationsZ;
	cl_int intA;
	cl_int intB;
	cl_int int1;
	cl_int int8X;
	cl_int int8Y;
	cl_int int8Z;

	cl_float4 additionConstant0555;
	cl_float4 additionConstant0777;
	cl_float4 additionConstant000;
	cl_float4 additionConstantA000;
	cl_float3 additionConstantP000;
	cl_float4 additionConstant111;
	cl_float3 additionConstantA111;
	cl_float4 additionConstant222;
	cl_float3 additionConstantNeg100;
	cl_float4 constantMultiplier000;
	cl_float4 constantMultiplier001;
	cl_float4 constantMultiplier010;
	cl_float4 constantMultiplier100;
	cl_float4 constantMultiplierA100;
	cl_float4 constantMultiplier111;
	cl_float4 constantMultiplierA111;
	cl_float4 constantMultiplierB111;
	cl_float3 constantMultiplierC111;
	cl_float3 constantMultiplier121;
	cl_float3 constantMultiplier122;
	cl_float4 constantMultiplier221;
	cl_float3 constantMultiplier222;
	cl_float3 constantMultiplier441;
	cl_float4 juliaC;
	cl_float4 offset000;
	cl_float4 offsetA000;
	cl_float3 offsetF000;
	cl_float4 offset100;
	cl_float4 offset1105;
	cl_float4 offset111;
	cl_float4 offsetA111;
	cl_float4 offsetB111;
	cl_float4 offsetC111;
	cl_float4 offset200;
	cl_float4 offsetA200;
	cl_float4 offset222;

	cl_float3 power025;
	cl_float3 power8;
	cl_float3 rotation;
	cl_float3 rotation2;
	cl_float3 rotation44a; //.........................
	cl_float3 rotation44b; //..........................
	cl_float3 scale3D000;
	cl_float3 scale3D111;
	cl_float3 scale3D222;
	cl_float3 scale3Da222;
	cl_float3 scale3Db222;
	cl_float3 scale3Dc222;
	cl_float3 scale3Dd222;
	cl_float3 scale3D333;
	cl_float3 scale3D444;

	cl_float4 additionConstant0000;
	cl_float4 offset0000;
	cl_float4 offset1111;
	cl_float4 offsetA1111;
	cl_float4 additionConstant111d5;
	cl_float4 constantMultiplier1220;

	matrix33 rotationMatrix;
	matrix33 rotationMatrix2;
	// matrix44 rotationMatrix44; //....................
	matrix33 tempRotMatrix;

	cl_int addCpixelEnabled;
	cl_int addCpixelEnabledFalse;
	cl_int alternateEnabledFalse;
	cl_int benesiT1Enabled;
	cl_int benesiT1EnabledFalse;
	cl_int benesiT1MEnabledFalse;
	cl_int functionEnabled;
	cl_int functionEnabledFalse;
	cl_int functionEnabledx;
	cl_int functionEnabledy;
	cl_int functionEnabledz;
	cl_int functionEnabledw;
	cl_int functionEnabledxFalse;
	cl_int functionEnabledyFalse;
	cl_int functionEnabledzFalse;
	cl_int functionEnabledwFalse;
	cl_int functionEnabledAx;
	cl_int functionEnabledAy;
	cl_int functionEnabledAz;
	cl_int functionEnabledAw;
	cl_int functionEnabledAxFalse;
	cl_int functionEnabledAyFalse;
	cl_int functionEnabledAzFalse;
	cl_int functionEnabledAwFalse;
	cl_int functionEnabledBx;
	cl_int functionEnabledBy;
	cl_int functionEnabledBz;
	cl_int functionEnabledBxFalse;
	cl_int functionEnabledByFalse;
	cl_int functionEnabledBzFalse;
	cl_int functionEnabledCx;
	cl_int functionEnabledCy;
	cl_int functionEnabledCz;
	cl_int functionEnabledCxFalse;
	cl_int functionEnabledCyFalse;
	cl_int functionEnabledCzFalse;
	cl_int functionEnabledDFalse;
	cl_int functionEnabledEFalse;
	cl_int functionEnabledFFalse;
	cl_int functionEnabledKFalse;
	cl_int functionEnabledM;
	cl_int functionEnabledMFalse;
	cl_int functionEnabledPFalse;
	cl_int functionEnabledRFalse;
	cl_int functionEnabledSFalse;
	cl_int functionEnabledSwFalse;
	cl_int functionEnabledXFalse;
	cl_int juliaMode;
	cl_int rotationEnabled;
} sFractalTransformCommonCl;

typedef struct
{

	sFractalMandelbulbCl bulb;
	sFractalIFSCl IFS;
	sFractalMandelboxCl mandelbox;
	sFractalGeneralizedFoldBoxCl genFoldBox;
	sFractalBoxFoldBulbPow2Cl foldingIntPow;
	sFractalMandelboxVary4DCl mandelboxVary4D;
	sFractalAexionCl aexion;
	sFractalBuffaloCl buffalo;
	sFractalPlatonicSolidCl platonicSolid;
	sFractalTransformCommonCl transformCommon;
	sFractalAnalyticDECl analyticDE;
	sFractalMandelbulbMultiCl mandelbulbMulti;
	sFractalSinTan2TrigCl sinTan2Trig;
	sFractalSurfBoxCl surfBox;
	sFractalSurfFoldsCl surfFolds;
	sFractalDonutCl donut;
	sFoldColorCl foldColor;
	sFractalMagTransformsCl magTransf;
	sFractalCparaCl Cpara;
	sFractalComboCl combo;

#ifdef USE_OPENCL
//	cl_float customParameters[15];
//	cl_float deltaDEStep;
//	char customOCLFormulaName[100];

#endif
} sFractalCl;

#ifndef OPENCL_KERNEL_CODE
inline sExtendedAuxCl clCopySExtendedAuxCl(sExtendedAux &source)
{
	sExtendedAuxCl target;
	target.i = source.i;
	target.r_dz = source.r_dz;
	target.r = source.r;
	target.DE = source.DE;
	target.color = source.color;
	target.actualScale = source.actualScale;
	target.pseudoKleinianDE = source.pseudoKleinianDE;
	target.linearDE = source.linearDE;
	target.cw = source.cw;
	target.foldFactor = source.foldFactor;
	target.minRFactor = source.minRFactor;
	target.scaleFactor = source.scaleFactor;
	target.c = toClFloat4(source.c);
	target.const_c = toClFloat4(source.const_c);
	return target;
}

inline sFoldColorCl clCopySFoldColorCl(sFoldColor &source)
{
	sFoldColorCl target;
	target.factor = toClFloat3(source.factor);
	target.factor4D = toClFloat4(source.factor4D);
	target.factorR = source.factorR;
	target.factorSp1 = source.factorSp1;
	target.factorSp2 = source.factorSp2;
	target.colorMin = source.colorMin;
	target.compFold0 = source.compFold0;
	target.compFold = source.compFold;
	target.compMinR = source.compMinR;
	target.compScale = source.compScale;
	return target;
}

inline sFractalGeneralizedFoldBoxCl clCopySFractalGeneralizedFoldBoxCl(
	sFractalGeneralizedFoldBox &source)
{
	sFractalGeneralizedFoldBoxCl target;
	for (int i = 0; i < 4; i++)
	{
		target.Nv_tet[i] = toClFloat3(source.Nv_tet[i]);
	}
	for (int i = 0; i < 6; i++)
	{
		target.Nv_cube[i] = toClFloat3(source.Nv_cube[i]);
	}
	for (int i = 0; i < 8; i++)
	{
		target.Nv_oct[i] = toClFloat3(source.Nv_oct[i]);
	}
	for (int i = 0; i < 14; i++)
	{
		target.Nv_oct_cube[i] = toClFloat3(source.Nv_oct_cube[i]);
	}
	for (int i = 0; i < 12; i++)
	{
		target.Nv_dodeca[i] = toClFloat3(source.Nv_dodeca[i]);
	}
	for (int i = 0; i < 20; i++)
	{
		target.Nv_icosa[i] = toClFloat3(source.Nv_icosa[i]);
	}
	for (int i = 0; i < 8; i++)
	{
		target.Nv_box6[i] = toClFloat3(source.Nv_box6[i]);
	}
	for (int i = 0; i < 7; i++)
	{
		target.Nv_box5[i] = toClFloat3(source.Nv_box5[i]);
	}
	target.sides_tet = source.sides_tet;
	target.sides_cube = source.sides_cube;
	target.sides_oct = source.sides_oct;
	target.sides_oct_cube = source.sides_oct_cube;
	target.sides_dodeca = source.sides_dodeca;
	target.sides_icosa = source.sides_icosa;
	target.sides_box6 = source.sides_box6;
	target.sides_box5 = source.sides_box5;
	return target;
}

inline sFractalIFSCl clCopySFractalIFSCl(sFractalIFS &source)
{
	sFractalIFSCl target;
	target.absX = source.absX;
	target.absY = source.absY;
	target.absZ = source.absZ;
	for (int i = 0; i < IFS_VECTOR_COUNTCl; i++)
	{
		target.enabled[i] = source.enabled[i];
	}
	target.mengerSpongeMode = source.mengerSpongeMode;
	target.rotationEnabled = source.rotationEnabled;
	target.edgeEnabled = source.edgeEnabled;
	target.mainRot = toClMatrix33(source.mainRot);
	for (int i = 0; i < IFS_VECTOR_COUNTCl; i++)
	{
		target.rot[i] = toClMatrix33(source.rot[i]);
	}
	for (int i = 0; i < IFS_VECTOR_COUNTCl; i++)
	{
		target.direction[i] = toClFloat4(source.direction[i]);
	}
	target.edge = toClFloat3(source.edge);
	target.offset = toClFloat4(source.offset);
	for (int i = 0; i < IFS_VECTOR_COUNTCl; i++)
	{
		target.rotations[i] = toClFloat3(source.rotations[i]);
	}
	for (int i = 0; i < IFS_VECTOR_COUNTCl; i++)
	{
		target.distance[i] = source.distance[i];
	}
	for (int i = 0; i < IFS_VECTOR_COUNTCl; i++)
	{
		target.intensity[i] = source.intensity[i];
	}
	target.rotation = toClFloat3(source.rotation);
	target.scale = source.scale;
	return target;
}

inline sFractalMandelboxVary4DCl clCopySFractalMandelboxVary4DCl(sFractalMandelboxVary4D &source)
{
	sFractalMandelboxVary4DCl target;
	target.fold = source.fold;
	target.minR = source.minR;
	target.scaleVary = source.scaleVary;
	target.wadd = source.wadd;
	target.rPower = source.rPower;
	return target;
}

inline sFractalMandelboxCl clCopySFractalMandelboxCl(sFractalMandelbox &source)
{
	sFractalMandelboxCl target;
	target.rotationMain = toClFloat3(source.rotationMain);
	for (int i = 0; i < MANDELBOX_FOLDSCl; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			target.rotation[i][j] = toClFloat3(source.rotation[i][j]);
		}
	}
	target.color = clCopySFoldColorCl(source.color);
	target.scale = source.scale;
	target.foldingLimit = source.foldingLimit;
	target.foldingValue = source.foldingValue;
	target.foldingSphericalMin = source.foldingSphericalMin;
	target.foldingSphericalFixed = source.foldingSphericalFixed;
	target.sharpness = source.sharpness;
	target.solid = source.solid;
	target.melt = source.melt;
	target.offset = toClFloat4(source.offset);
	target.rotationsEnabled = source.rotationsEnabled;
	target.mainRotationEnabled = source.mainRotationEnabled;
	target.mainRot = toClMatrix33(source.mainRot);
	for (int i = 0; i < MANDELBOX_FOLDSCl; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			target.rot[i][j] = toClMatrix33(source.rot[i][j]);
		}
	}
	for (int i = 0; i < MANDELBOX_FOLDSCl; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			target.rotinv[i][j] = toClMatrix33(source.rotinv[i][j]);
		}
	}
	target.fR2 = source.fR2;
	target.mR2 = source.mR2;
	target.mboxFactor1 = source.mboxFactor1;
	return target;
}

inline sFractalBoxFoldBulbPow2Cl clCopySFractalBoxFoldBulbPow2Cl(sFractalBoxFoldBulbPow2 &source)
{
	sFractalBoxFoldBulbPow2Cl target;
	target.zFactor = source.zFactor;
	target.foldFactor = source.foldFactor;
	return target;
}

inline sFractalMandelbulbCl clCopySFractalMandelbulbCl(sFractalMandelbulb &source)
{
	sFractalMandelbulbCl target;
	target.power = source.power;
	target.alphaAngleOffset = source.alphaAngleOffset;
	target.betaAngleOffset = source.betaAngleOffset;
	target.gammaAngleOffset = source.gammaAngleOffset;
	return target;
}

inline sFractalAexionCl clCopySFractalAexionCl(sFractalAexion &source)
{
	sFractalAexionCl target;
	target.cadd = source.cadd;
	return target;
}

inline sFractalBuffaloCl clCopySFractalBuffaloCl(sFractalBuffalo &source)
{
	sFractalBuffaloCl target;
	target.preabsx = source.preabsx;
	target.preabsy = source.preabsy;
	target.preabsz = source.preabsz;
	target.absx = source.absx;
	target.absy = source.absy;
	target.absz = source.absz;
	target.posz = source.posz;
	return target;
}

inline sFractalDonutCl clCopySFractalDonutCl(sFractalDonut &source)
{
	sFractalDonutCl target;
	target.ringRadius = source.ringRadius;
	target.ringThickness = source.ringThickness;
	target.factor = source.factor;
	target.number = source.number;
	return target;
}

inline sFractalPlatonicSolidCl clCopySFractalPlatonicSolidCl(sFractalPlatonicSolid &source)
{
	sFractalPlatonicSolidCl target;
	target.frequency = source.frequency;
	target.amplitude = source.amplitude;
	target.rhoMul = source.rhoMul;
	return target;
}

inline sFractalMandelbulbMultiCl clCopySFractalMandelbulbMultiCl(sFractalMandelbulbMulti &source)
{
	sFractalMandelbulbMultiCl target;
	target.acosOrAsin = enumMulti_acosOrAsinCl(source.acosOrAsin);
	target.acosOrAsinA = enumMulti_acosOrAsinCl(source.acosOrAsinA);
	target.atanOrAtan2 = enumMulti_atanOrAtan2Cl(source.atanOrAtan2);
	target.atanOrAtan2A = enumMulti_atanOrAtan2Cl(source.atanOrAtan2A);
	target.orderOfXYZ = enumMulti_OrderOfXYZCl(source.orderOfXYZ);
	target.orderOfXYZ2 = enumMulti_OrderOfXYZCl(source.orderOfXYZ2);
	target.orderOfXYZC = enumMulti_OrderOfXYZCl(source.orderOfXYZC);
	return target;
}

inline sFractalSinTan2TrigCl clCopySFractalSinTan2TrigCl(sFractalSinTan2Trig &source)
{
	sFractalSinTan2TrigCl target;
	target.asinOrAcos = enumMulti_asinOrAcosCl(source.asinOrAcos);
	target.atan2OrAtan = enumMulti_atan2OrAtanCl(source.atan2OrAtan);
	target.orderOfZYX = enumMulti_OrderOfZYXCl(source.orderOfZYX);
	return target;
}

inline sFractalSurfFoldsCl clCopySFractalSurfFoldsCl(sFractalSurfFolds &source)
{
	sFractalSurfFoldsCl target;
	target.orderOfFolds1 = enumMulti_orderOfFoldsCl(source.orderOfFolds1);
	target.orderOfFolds2 = enumMulti_orderOfFoldsCl(source.orderOfFolds2);
	target.orderOfFolds3 = enumMulti_orderOfFoldsCl(source.orderOfFolds3);
	target.orderOfFolds4 = enumMulti_orderOfFoldsCl(source.orderOfFolds4);
	target.orderOfFolds5 = enumMulti_orderOfFoldsCl(source.orderOfFolds5);
	return target;
}

inline sFractalMagTransformsCl clCopySFractalMagTransformsCl(sFractalMagTransforms &source)
{
	sFractalMagTransformsCl target;
	target.orderOfTransf1 = enumMulti_orderOfTransfCl(source.orderOfTransf1);
	target.orderOfTransf2 = enumMulti_orderOfTransfCl(source.orderOfTransf2);
	target.orderOfTransf3 = enumMulti_orderOfTransfCl(source.orderOfTransf3);
	target.orderOfTransf4 = enumMulti_orderOfTransfCl(source.orderOfTransf4);
	target.orderOfTransf5 = enumMulti_orderOfTransfCl(source.orderOfTransf5);
	return target;
}

inline sFractalComboCl clCopySFractalComboCl(sFractalCombo &source)
{
	sFractalComboCl target;
	target.modeA = enumComboCl(source.modeA);
	return target;
}

inline sFractalSurfBoxCl clCopySFractalSurfBoxCl(sFractalSurfBox &source)
{
	sFractalSurfBoxCl target;
	target.enabledX1 = source.enabledX1;
	target.enabledY1 = source.enabledY1;
	target.enabledZ1 = source.enabledZ1;
	target.enabledX2False = source.enabledX2False;
	target.enabledY2False = source.enabledY2False;
	target.enabledZ2False = source.enabledZ2False;
	target.enabledX3False = source.enabledX3False;
	target.enabledY3False = source.enabledY3False;
	target.enabledZ3False = source.enabledZ3False;
	target.enabledX4False = source.enabledX4False;
	target.enabledY4False = source.enabledY4False;
	target.enabledZ4False = source.enabledZ4False;
	target.enabledX5False = source.enabledX5False;
	target.enabledY5False = source.enabledY5False;
	target.enabledZ5False = source.enabledZ5False;
	target.offset1A111 = toClFloat3(source.offset1A111);
	target.offset1B111 = toClFloat3(source.offset1B111);
	target.offset2A111 = toClFloat3(source.offset2A111);
	target.offset2B111 = toClFloat3(source.offset2B111);
	target.offset3A111 = toClFloat3(source.offset3A111);
	target.offset3B111 = toClFloat3(source.offset3B111);
	target.offset1A222 = toClFloat3(source.offset1A222);
	target.offset1B222 = toClFloat3(source.offset1B222);
	target.scale1Z1 = source.scale1Z1;
	return target;
}

inline sFractalCparaCl clCopySFractalCparaCl(sFractalCpara &source)
{
	sFractalCparaCl target;
	target.enabledLinear = source.enabledLinear;
	target.enabledCurves = source.enabledCurves;
	target.enabledParabFalse = source.enabledParabFalse;
	target.enabledParaAddP0 = source.enabledParaAddP0;
	target.para00 = source.para00;
	target.paraA0 = source.paraA0;
	target.paraB0 = source.paraB0;
	target.paraC0 = source.paraC0;
	target.parabOffset0 = source.parabOffset0;
	target.para0 = source.para0;
	target.paraA = source.paraA;
	target.paraB = source.paraB;
	target.paraC = source.paraC;
	target.parabOffset = source.parabOffset;
	target.parabSlope = source.parabSlope;
	target.parabScale = source.parabScale;
	target.iterA = source.iterA;
	target.iterB = source.iterB;
	target.iterC = source.iterC;
	return target;
}

inline sFractalAnalyticDECl clCopySFractalAnalyticDECl(sFractalAnalyticDE &source)
{
	sFractalAnalyticDECl target;
	target.enabledFalse = source.enabledFalse;
	target.enabledAuxR2False = source.enabledAuxR2False;
	target.scale1 = source.scale1;
	target.tweak005 = source.tweak005;
	target.offset0 = source.offset0;
	target.offset1 = source.offset1;
	target.offset2 = source.offset2;
	target.factor2 = source.factor2;
	target.scaleLin = source.scaleLin;
	target.offsetLin = source.offsetLin;
	return target;
}

inline sFractalTransformCommonCl clCopySFractalTransformCommonCl(sFractalTransformCommon &source)
{
	sFractalTransformCommonCl target;
	target.alphaAngleOffset = source.alphaAngleOffset;
	target.betaAngleOffset = source.betaAngleOffset;
	target.foldingValue = source.foldingValue;
	target.foldingLimit = source.foldingLimit;
	target.offset = source.offset;
	target.offset0 = source.offset0;
	target.offsetA0 = source.offsetA0;
	target.offsetB0 = source.offsetB0;
	target.offsetC0 = source.offsetC0;
	target.offset0005 = source.offset0005;
	target.offset05 = source.offset05;
	target.offset1 = source.offset1;
	target.offset105 = source.offset105;
	target.offset2 = source.offset2;
	target.multiplication = source.multiplication;
	target.minRNeg1 = source.minRNeg1;
	target.minR0 = source.minR0;
	target.minR05 = source.minR05;
	target.minR06 = source.minR06;
	target.minR2p25 = source.minR2p25;
	target.maxR2d1 = source.maxR2d1;
	target.maxMinR2factor = source.maxMinR2factor;
	target.scale = source.scale;
	target.scale0 = source.scale0;
	target.scale025 = source.scale025;
	target.scale05 = source.scale05;
	target.scale08 = source.scale08;
	target.scale1 = source.scale1;
	target.scaleA1 = source.scaleA1;
	target.scaleB1 = source.scaleB1;
	target.scaleC1 = source.scaleC1;
	target.scaleD1 = source.scaleD1;
	target.scaleE1 = source.scaleE1;
	target.scaleF1 = source.scaleF1;
	target.scaleG1 = source.scaleG1;
	target.scaleA2 = source.scaleA2;
	target.scale015 = source.scale015;
	target.scale2 = source.scale2;
	target.scale3 = source.scale3;
	target.scaleA3 = source.scaleA3;
	target.scaleB3 = source.scaleB3;
	target.scale4 = source.scale4;
	target.scale8 = source.scale8;
	target.pwr05 = source.pwr05;
	target.pwr4 = source.pwr4;
	target.pwr8 = source.pwr8;
	target.pwr8a = source.pwr8a;
	target.sqtR = source.sqtR;
	target.mboxFactor1 = source.mboxFactor1;
	target.startIterations = source.startIterations;
	target.startIterations250 = source.startIterations250;
	target.stopIterations = source.stopIterations;
	target.startIterationsA = source.startIterationsA;
	target.stopIterationsA = source.stopIterationsA;
	target.startIterationsB = source.startIterationsB;
	target.stopIterationsB = source.stopIterationsB;
	target.startIterationsC = source.startIterationsC;
	target.stopIterationsC = source.stopIterationsC;
	target.stopIterationsC1 = source.stopIterationsC1;
	target.startIterationsD = source.startIterationsD;
	target.stopIterationsD = source.stopIterationsD;
	target.stopIterationsD1 = source.stopIterationsD1;
	target.startIterationsE = source.startIterationsE;
	target.stopIterationsE = source.stopIterationsE;
	target.startIterationsF = source.startIterationsF;
	target.stopIterationsF = source.stopIterationsF;
	target.startIterationsP = source.startIterationsP;
	target.stopIterationsP1 = source.stopIterationsP1;
	target.startIterationsR = source.startIterationsR;
	target.stopIterationsR = source.stopIterationsR;
	target.startIterationsS = source.startIterationsS;
	target.stopIterationsS = source.stopIterationsS;
	target.startIterationsT = source.startIterationsT;
	target.stopIterationsT = source.stopIterationsT;
	target.startIterationsM = source.startIterationsM;
	target.stopIterationsM = source.stopIterationsM;
	target.stopIterations1 = source.stopIterations1;
	target.stopIterationsT1 = source.stopIterationsT1;
	target.stopIterationsTM1 = source.stopIterationsTM1;
	target.startIterationsX = source.startIterationsX;
	target.stopIterationsX = source.stopIterationsX;
	target.startIterationsY = source.startIterationsY;
	target.stopIterationsY = source.stopIterationsY;
	target.startIterationsZ = source.startIterationsZ;
	target.stopIterationsZ = source.stopIterationsZ;
	target.intA = source.intA;
	target.intB = source.intB;
	target.int1 = source.int1;
	target.int8X = source.int8X;
	target.int8Y = source.int8Y;
	target.int8Z = source.int8Z;
	target.additionConstant0555 = toClFloat4(source.additionConstant0555);
	target.additionConstant0777 = toClFloat4(source.additionConstant0777);
	target.additionConstant000 = toClFloat4(source.additionConstant000);
	target.additionConstantA000 = toClFloat4(source.additionConstantA000);
	target.additionConstantP000 = toClFloat3(source.additionConstantP000);
	target.additionConstant111 = toClFloat4(source.additionConstant111);
	target.additionConstantA111 = toClFloat3(source.additionConstantA111);
	target.additionConstant222 = toClFloat4(source.additionConstant222);
	target.additionConstantNeg100 = toClFloat3(source.additionConstantNeg100);
	target.constantMultiplier000 = toClFloat4(source.constantMultiplier000);
	target.constantMultiplier001 = toClFloat4(source.constantMultiplier001);
	target.constantMultiplier010 = toClFloat4(source.constantMultiplier010);
	target.constantMultiplier100 = toClFloat4(source.constantMultiplier100);
	target.constantMultiplierA100 = toClFloat4(source.constantMultiplierA100);
	target.constantMultiplier111 = toClFloat4(source.constantMultiplier111);
	target.constantMultiplierA111 = toClFloat4(source.constantMultiplierA111);
	target.constantMultiplierB111 = toClFloat4(source.constantMultiplierB111);
	target.constantMultiplierC111 = toClFloat3(source.constantMultiplierC111);
	target.constantMultiplier121 = toClFloat3(source.constantMultiplier121);
	target.constantMultiplier122 = toClFloat3(source.constantMultiplier122);
	target.constantMultiplier221 = toClFloat4(source.constantMultiplier221);
	target.constantMultiplier222 = toClFloat3(source.constantMultiplier222);
	target.constantMultiplier441 = toClFloat3(source.constantMultiplier441);
	target.juliaC = toClFloat4(source.juliaC);
	target.offset000 = toClFloat4(source.offset000);
	target.offsetA000 = toClFloat4(source.offsetA000);
	target.offsetF000 = toClFloat3(source.offsetF000);
	target.offset100 = toClFloat4(source.offset100);
	target.offset1105 = toClFloat4(source.offset1105);
	target.offset111 = toClFloat4(source.offset111);
	target.offsetA111 = toClFloat4(source.offsetA111);
	target.offsetB111 = toClFloat4(source.offsetB111);
	target.offsetC111 = toClFloat4(source.offsetC111);
	target.offset200 = toClFloat4(source.offset200);
	target.offsetA200 = toClFloat4(source.offsetA200);
	target.offset222 = toClFloat4(source.offset222);
	target.power025 = toClFloat3(source.power025);
	target.power8 = toClFloat3(source.power8);
	target.rotation = toClFloat3(source.rotation);
	target.rotation2 = toClFloat3(source.rotation2);
	target.rotation44a = toClFloat3(source.rotation44a);
	target.rotation44b = toClFloat3(source.rotation44b);
	target.scale3D000 = toClFloat3(source.scale3D000);
	target.scale3D111 = toClFloat3(source.scale3D111);
	target.scale3D222 = toClFloat3(source.scale3D222);
	target.scale3Da222 = toClFloat3(source.scale3Da222);
	target.scale3Db222 = toClFloat3(source.scale3Db222);
	target.scale3Dc222 = toClFloat3(source.scale3Dc222);
	target.scale3Dd222 = toClFloat3(source.scale3Dd222);
	target.scale3D333 = toClFloat3(source.scale3D333);
	target.scale3D444 = toClFloat3(source.scale3D444);
	target.additionConstant0000 = toClFloat4(source.additionConstant0000);
	target.offset0000 = toClFloat4(source.offset0000);
	target.offset1111 = toClFloat4(source.offset1111);
	target.offsetA1111 = toClFloat4(source.offsetA1111);
	target.additionConstant111d5 = toClFloat4(source.additionConstant111d5);
	target.constantMultiplier1220 = toClFloat4(source.constantMultiplier1220);
	target.rotationMatrix = toClMatrix33(source.rotationMatrix);
	target.rotationMatrix2 = toClMatrix33(source.rotationMatrix2);
	target.tempRotMatrix = toClMatrix33(source.tempRotMatrix);
	target.addCpixelEnabled = source.addCpixelEnabled;
	target.addCpixelEnabledFalse = source.addCpixelEnabledFalse;
	target.alternateEnabledFalse = source.alternateEnabledFalse;
	target.benesiT1Enabled = source.benesiT1Enabled;
	target.benesiT1EnabledFalse = source.benesiT1EnabledFalse;
	target.benesiT1MEnabledFalse = source.benesiT1MEnabledFalse;
	target.functionEnabled = source.functionEnabled;
	target.functionEnabledFalse = source.functionEnabledFalse;
	target.functionEnabledx = source.functionEnabledx;
	target.functionEnabledy = source.functionEnabledy;
	target.functionEnabledz = source.functionEnabledz;
	target.functionEnabledw = source.functionEnabledw;
	target.functionEnabledxFalse = source.functionEnabledxFalse;
	target.functionEnabledyFalse = source.functionEnabledyFalse;
	target.functionEnabledzFalse = source.functionEnabledzFalse;
	target.functionEnabledwFalse = source.functionEnabledwFalse;
	target.functionEnabledAx = source.functionEnabledAx;
	target.functionEnabledAy = source.functionEnabledAy;
	target.functionEnabledAz = source.functionEnabledAz;
	target.functionEnabledAw = source.functionEnabledAw;
	target.functionEnabledAxFalse = source.functionEnabledAxFalse;
	target.functionEnabledAyFalse = source.functionEnabledAyFalse;
	target.functionEnabledAzFalse = source.functionEnabledAzFalse;
	target.functionEnabledAwFalse = source.functionEnabledAwFalse;
	target.functionEnabledBx = source.functionEnabledBx;
	target.functionEnabledBy = source.functionEnabledBy;
	target.functionEnabledBz = source.functionEnabledBz;
	target.functionEnabledBxFalse = source.functionEnabledBxFalse;
	target.functionEnabledByFalse = source.functionEnabledByFalse;
	target.functionEnabledBzFalse = source.functionEnabledBzFalse;
	target.functionEnabledCx = source.functionEnabledCx;
	target.functionEnabledCy = source.functionEnabledCy;
	target.functionEnabledCz = source.functionEnabledCz;
	target.functionEnabledCxFalse = source.functionEnabledCxFalse;
	target.functionEnabledCyFalse = source.functionEnabledCyFalse;
	target.functionEnabledCzFalse = source.functionEnabledCzFalse;
	target.functionEnabledDFalse = source.functionEnabledDFalse;
	target.functionEnabledEFalse = source.functionEnabledEFalse;
	target.functionEnabledFFalse = source.functionEnabledFFalse;
	target.functionEnabledKFalse = source.functionEnabledKFalse;
	target.functionEnabledM = source.functionEnabledM;
	target.functionEnabledMFalse = source.functionEnabledMFalse;
	target.functionEnabledPFalse = source.functionEnabledPFalse;
	target.functionEnabledRFalse = source.functionEnabledRFalse;
	target.functionEnabledSFalse = source.functionEnabledSFalse;
	target.functionEnabledSwFalse = source.functionEnabledSwFalse;
	target.functionEnabledXFalse = source.functionEnabledXFalse;
	target.juliaMode = source.juliaMode;
	target.rotationEnabled = source.rotationEnabled;
	return target;
}

inline sFractalCl clCopySFractalCl(sFractal &source)
{
	sFractalCl target;
	target.bulb = clCopySFractalMandelbulbCl(source.bulb);
	target.IFS = clCopySFractalIFSCl(source.IFS);
	target.mandelbox = clCopySFractalMandelboxCl(source.mandelbox);
	target.genFoldBox = clCopySFractalGeneralizedFoldBoxCl(source.genFoldBox);
	target.foldingIntPow = clCopySFractalBoxFoldBulbPow2Cl(source.foldingIntPow);
	target.mandelboxVary4D = clCopySFractalMandelboxVary4DCl(source.mandelboxVary4D);
	target.aexion = clCopySFractalAexionCl(source.aexion);
	target.buffalo = clCopySFractalBuffaloCl(source.buffalo);
	target.platonicSolid = clCopySFractalPlatonicSolidCl(source.platonicSolid);
	target.transformCommon = clCopySFractalTransformCommonCl(source.transformCommon);
	target.analyticDE = clCopySFractalAnalyticDECl(source.analyticDE);
	target.mandelbulbMulti = clCopySFractalMandelbulbMultiCl(source.mandelbulbMulti);
	target.sinTan2Trig = clCopySFractalSinTan2TrigCl(source.sinTan2Trig);
	target.surfBox = clCopySFractalSurfBoxCl(source.surfBox);
	target.surfFolds = clCopySFractalSurfFoldsCl(source.surfFolds);
	target.donut = clCopySFractalDonutCl(source.donut);
	target.foldColor = clCopySFoldColorCl(source.foldColor);
	target.magTransf = clCopySFractalMagTransformsCl(source.magTransf);
	target.Cpara = clCopySFractalCparaCl(source.Cpara);
	target.combo = clCopySFractalComboCl(source.combo);
	return target;
}
#endif /* OPENCL_KERNEL_CODE */

#endif /* MANDELBULBER2_OPENCL_FRACTAL_CL_H_ */
