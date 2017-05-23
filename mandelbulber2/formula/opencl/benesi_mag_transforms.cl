/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * benesiMagTransforms
 * @reference
 * http://www.fractalforums.com/new-theories-and-research/
 * do-m3d-formula-have-to-be-distance-estimation-formulas/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void BenesiMagTransformsIteration(float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 c = aux->const_c;

	if (fractal->transformCommon.benesiT1Enabled && aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		float tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
		*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
			z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

		float4 temp = *z;
		float tempL = length(temp);
		*z = fabs(*z) * fractal->transformCommon.scale3D222;
		// if (tempL < 1e-21f) tempL =  1e-21f;
		float avgScale = native_divide(length(*z), tempL);

		aux->r_dz *= avgScale;
		aux->DE = mad(aux->DE, avgScale, 1.0f);

		tempXZ = (z->y + z->x) * SQRT_1_2;

		*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
			z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
		*z = *z - fractal->transformCommon.offset200;
	}

	if (fractal->transformCommon.rotationEnabled)
		*z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, *z);

	if (fractal->transformCommon.addCpixelEnabled
			&& aux->i >= fractal->transformCommon.startIterationsT
			&& aux->i < fractal->transformCommon.stopIterationsT)
	{
		float4 temp = *z;
		aux->r = length(*z);
		*z *= *z;
		float t = 2.0f * temp.x;
		if (z->y + z->z > 0.0f)
			t = native_divide(t, native_sqrt(z->y + z->z));
		else
			t = 1.0f;
		if (fractal->transformCommon.addCpixelEnabled)
		{
			float4 tempC = c;
			if (fractal->transformCommon.alternateEnabledFalse) // alternate
			{
				tempC = (float4){aux->c.x, aux->c.z, aux->c.y, aux->c.w};
				aux->c = tempC;
			}
			else
			{
				tempC = (float4){c.x, c.z, c.y, c.w};
			}
			z->x = mad(fractal->transformCommon.constantMultiplier100.x, tempC.x, (z->x - z->y - z->z));
			z->z = mad(fractal->transformCommon.constantMultiplier100.y, tempC.z, (t * (z->y - z->z)));
			z->y = mad(
				fractal->transformCommon.constantMultiplier100.z, tempC.y, (2.0f * t * temp.y * temp.z));
		}
		aux->r_dz = mad(aux->r * aux->r_dz, 2.0f, 1.0f);
	}
	if (fractal->transformCommon.juliaMode)
	{
		z->x += fractal->transformCommon.juliaC.x * fractal->transformCommon.constantMultiplier100.x;
		z->z += fractal->transformCommon.juliaC.y * fractal->transformCommon.constantMultiplier100.y;
		z->y += fractal->transformCommon.juliaC.z * fractal->transformCommon.constantMultiplier100.z;
	}
	// additional transform slot controls
	bool functionEnabledN[5] = {fractal->transformCommon.functionEnabledAxFalse,
		fractal->transformCommon.functionEnabledAyFalse,
		fractal->transformCommon.functionEnabledAzFalse,
		fractal->transformCommon.functionEnabledBxFalse,
		fractal->transformCommon.functionEnabledByFalse};
	int startIterationN[5] = {fractal->transformCommon.startIterationsA,
		fractal->transformCommon.startIterationsB, fractal->transformCommon.startIterationsC,
		fractal->transformCommon.startIterationsD, fractal->transformCommon.startIterationsE};
	int stopIterationN[5] = {fractal->transformCommon.stopIterationsA,
		fractal->transformCommon.stopIterationsB, fractal->transformCommon.stopIterationsC,
		fractal->transformCommon.stopIterationsD, fractal->transformCommon.stopIterationsE};

	enumMulti_orderOfTransfCl transfN[5] = {fractal->magTransf.orderOfTransf1,
		fractal->magTransf.orderOfTransf2, fractal->magTransf.orderOfTransf3,
		fractal->magTransf.orderOfTransf4, fractal->magTransf.orderOfTransf5};

	for (int f = 0; f < 5; f++)
	{
		if (functionEnabledN[f] && aux->i >= startIterationN[f] && aux->i < stopIterationN[f])
		{
			float tempXZ;
			float tempL;
			float4 temp;
			float avgScale;
			float4 tempV2;

			switch (transfN[f])
			{
				case multi_orderOfTransfCl_typeT1:
				default:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					*z = fabs(*z) * fractal->transformCommon.scale3Da222;
					tempL = length(temp);
					// if (tempL < 1e-21f) tempL = 1e-21f;
					avgScale = native_divide(length(*z), tempL);
					aux->r_dz *= avgScale;
					aux->DE = mad(aux->DE, avgScale, 1.0f);
					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					*z = *z - fractal->transformCommon.offsetA200;
					break;

				case multi_orderOfTransfCl_typeT1Mod:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					*z = fabs(*z) * fractal->transformCommon.scale3D333;
					tempL = length(temp);
					// if (tempL < 1e-21f) tempL = 1e-21f;
					avgScale = native_divide(length(*z), tempL);
					aux->r_dz *= avgScale;
					aux->DE = mad(aux->DE, avgScale, 1.0f);
					*z = (fabs(*z + fractal->transformCommon.offset111)
								- fabs(*z - fractal->transformCommon.offset111) - *z);
					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT2:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					tempV2 = *z;
					tempV2.x = native_sqrt(mad(z->y, z->y, z->z * z->z));
					tempV2.y = native_sqrt(mad(z->x, z->x, z->z * z->z)); // switching, squared, sqrt
					tempV2.z = native_sqrt(mad(z->x, z->x, z->y * z->y));
					*z = fabs(tempV2 - fractal->transformCommon.offsetA111);
					temp = *z;
					tempL = length(temp);
					*z = fabs(*z) * fractal->transformCommon.scale3D444;
					// if (tempL < 1e-21f) tempL = 1e-21f;
					avgScale = native_divide(length(*z), tempL);
					aux->r_dz *= avgScale;
					aux->DE = mad(aux->DE, avgScale, 1.0f);
					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT3:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

					tempV2 = *z;
					tempV2.x = (z->y + z->z);
					tempV2.y = (z->x + z->z); // switching
					tempV2.z = (z->x + z->y);
					*z = (fabs(tempV2 - fractal->transformCommon.offset222))
							 * fractal->transformCommon.scale3Db222;

					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT4:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

					tempV2 = *z;
					tempV2.x = (mad(z->y, z->y, z->z * z->z));
					tempV2.y = (mad(z->x, z->x, z->z * z->z)); // switching, squared,
					tempV2.z = (mad(z->x, z->x, z->y * z->y));
					*z = (fabs(tempV2 - fractal->transformCommon.offsetB111))
							 * fractal->transformCommon.scale3Dc222;

					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT5b:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					// if (z->x > -1e-21f && z->x < 1e-21f)
					//	z->x = (z->x > 0) ? 1e-21f : -1e-21f;
					// if (z->y > -1e-21f && z->y < 1e-21f)
					//	z->y = (z->y > 0) ? 1e-21f : -1e-21f;
					// if (z->z > -1e-21f && z->z < 1e-21f)
					//	z->z = (z->z > 0) ? 1e-21f : -1e-21f;
					tempV2 = *z;
					tempV2.x = fabs(native_powr(native_powr(z->y, fractal->transformCommon.int8X)
																				+ native_powr(z->z, fractal->transformCommon.int8X),
						fractal->transformCommon.power025.x));
					tempV2.y = fabs(native_powr(native_powr(z->x, fractal->transformCommon.int8Y)
																				+ native_powr(z->z, fractal->transformCommon.int8Y),
						fractal->transformCommon.power025.y));
					tempV2.z = fabs(native_powr(native_powr(z->x, fractal->transformCommon.int8Z)
																				+ native_powr(z->y, fractal->transformCommon.int8Z),
						fractal->transformCommon.power025.z));
					*z = (fabs(tempV2 - fractal->transformCommon.offsetC111))
							 * fractal->transformCommon.scale3Dd222;

					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;
			}
		}
	}
}
#else
void BenesiMagTransformsIteration(double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 c = aux->const_c;

	if (fractal->transformCommon.benesiT1Enabled && aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		double tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
		*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
			z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

		double4 temp = *z;
		double tempL = length(temp);
		*z = fabs(*z) * fractal->transformCommon.scale3D222;
		// if (tempL < 1e-21) tempL =  1e-21;
		double avgScale = native_divide(length(*z), tempL);

		aux->r_dz *= avgScale;
		aux->DE = aux->DE * avgScale + 1.0;

		tempXZ = (z->y + z->x) * SQRT_1_2;

		*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
			z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
		*z = *z - fractal->transformCommon.offset200;
	}

	if (fractal->transformCommon.rotationEnabled)
		*z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, *z);

	if (fractal->transformCommon.addCpixelEnabled
			&& aux->i >= fractal->transformCommon.startIterationsT
			&& aux->i < fractal->transformCommon.stopIterationsT)
	{
		double4 temp = *z;
		aux->r = length(*z);
		*z *= *z;
		double t = 2.0 * temp.x;
		if (z->y + z->z > 0.0)
			t = native_divide(t, native_sqrt(z->y + z->z));
		else
			t = 1.0;
		if (fractal->transformCommon.addCpixelEnabled)
		{
			double4 tempC = c;
			if (fractal->transformCommon.alternateEnabledFalse) // alternate
			{
				tempC = (double4){aux->c.x, aux->c.z, aux->c.y, aux->c.w};
				aux->c = tempC;
			}
			else
			{
				tempC = (double4){c.x, c.z, c.y, c.w};
			}
			z->x = mad(fractal->transformCommon.constantMultiplier100.x, tempC.x, (z->x - z->y - z->z));
			z->z = mad(fractal->transformCommon.constantMultiplier100.y, tempC.z, (t * (z->y - z->z)));
			z->y =
				mad(fractal->transformCommon.constantMultiplier100.z, tempC.y, (2.0 * t * temp.y * temp.z));
		}
		aux->r_dz = aux->r * aux->r_dz * 2.0 + 1.0;
	}
	if (fractal->transformCommon.juliaMode)
	{
		z->x += fractal->transformCommon.juliaC.x * fractal->transformCommon.constantMultiplier100.x;
		z->z += fractal->transformCommon.juliaC.y * fractal->transformCommon.constantMultiplier100.y;
		z->y += fractal->transformCommon.juliaC.z * fractal->transformCommon.constantMultiplier100.z;
	}
	// additional transform slot controls
	bool functionEnabledN[5] = {fractal->transformCommon.functionEnabledAxFalse,
		fractal->transformCommon.functionEnabledAyFalse,
		fractal->transformCommon.functionEnabledAzFalse,
		fractal->transformCommon.functionEnabledBxFalse,
		fractal->transformCommon.functionEnabledByFalse};
	int startIterationN[5] = {fractal->transformCommon.startIterationsA,
		fractal->transformCommon.startIterationsB, fractal->transformCommon.startIterationsC,
		fractal->transformCommon.startIterationsD, fractal->transformCommon.startIterationsE};
	int stopIterationN[5] = {fractal->transformCommon.stopIterationsA,
		fractal->transformCommon.stopIterationsB, fractal->transformCommon.stopIterationsC,
		fractal->transformCommon.stopIterationsD, fractal->transformCommon.stopIterationsE};

	enumMulti_orderOfTransfCl transfN[5] = {fractal->magTransf.orderOfTransf1,
		fractal->magTransf.orderOfTransf2, fractal->magTransf.orderOfTransf3,
		fractal->magTransf.orderOfTransf4, fractal->magTransf.orderOfTransf5};

	for (int f = 0; f < 5; f++)
	{
		if (functionEnabledN[f] && aux->i >= startIterationN[f] && aux->i < stopIterationN[f])
		{
			double tempXZ;
			double tempL;
			double4 temp;
			double avgScale;
			double4 tempV2;

			switch (transfN[f])
			{
				case multi_orderOfTransfCl_typeT1:
				default:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					*z = fabs(*z) * fractal->transformCommon.scale3Da222;
					tempL = length(temp);
					// if (tempL < 1e-21) tempL = 1e-21;
					avgScale = native_divide(length(*z), tempL);
					aux->r_dz *= avgScale;
					aux->DE = aux->DE * avgScale + 1.0;
					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					*z = *z - fractal->transformCommon.offsetA200;
					break;

				case multi_orderOfTransfCl_typeT1Mod:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					*z = fabs(*z) * fractal->transformCommon.scale3D333;
					tempL = length(temp);
					// if (tempL < 1e-21) tempL = 1e-21;
					avgScale = native_divide(length(*z), tempL);
					aux->r_dz *= avgScale;
					aux->DE = aux->DE * avgScale + 1.0;
					*z = (fabs(*z + fractal->transformCommon.offset111)
								- fabs(*z - fractal->transformCommon.offset111) - *z);
					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT2:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					tempV2 = *z;
					tempV2.x = native_sqrt(mad(z->y, z->y, z->z * z->z));
					tempV2.y = native_sqrt(mad(z->x, z->x, z->z * z->z)); // switching, squared, sqrt
					tempV2.z = native_sqrt(mad(z->x, z->x, z->y * z->y));
					*z = fabs(tempV2 - fractal->transformCommon.offsetA111);
					temp = *z;
					tempL = length(temp);
					*z = fabs(*z) * fractal->transformCommon.scale3D444;
					// if (tempL < 1e-21) tempL = 1e-21;
					avgScale = native_divide(length(*z), tempL);
					aux->r_dz *= avgScale;
					aux->DE = aux->DE * avgScale + 1.0;
					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT3:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

					tempV2 = *z;
					tempV2.x = (z->y + z->z);
					tempV2.y = (z->x + z->z); // switching
					tempV2.z = (z->x + z->y);
					*z = (fabs(tempV2 - fractal->transformCommon.offset222))
							 * fractal->transformCommon.scale3Db222;

					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT4:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

					tempV2 = *z;
					tempV2.x = (mad(z->y, z->y, z->z * z->z));
					tempV2.y = (mad(z->x, z->x, z->z * z->z)); // switching, squared,
					tempV2.z = (mad(z->x, z->x, z->y * z->y));
					*z = (fabs(tempV2 - fractal->transformCommon.offsetB111))
							 * fractal->transformCommon.scale3Dc222;

					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;

				case multi_orderOfTransfCl_typeT5b:
					tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
					*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
						z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};
					// if (z->x > -1e-21 && z->x < 1e-21)
					//	z->x = (z->x > 0) ? 1e-21 : -1e-21;
					// if (z->y > -1e-21 && z->y < 1e-21)
					//	z->y = (z->y > 0) ? 1e-21 : -1e-21;
					// if (z->z > -1e-21 && z->z < 1e-21)
					//	z->z = (z->z > 0) ? 1e-21 : -1e-21;
					tempV2 = *z;
					tempV2.x = fabs(native_powr(native_powr(z->y, fractal->transformCommon.int8X)
																				+ native_powr(z->z, fractal->transformCommon.int8X),
						fractal->transformCommon.power025.x));
					tempV2.y = fabs(native_powr(native_powr(z->x, fractal->transformCommon.int8Y)
																				+ native_powr(z->z, fractal->transformCommon.int8Y),
						fractal->transformCommon.power025.y));
					tempV2.z = fabs(native_powr(native_powr(z->x, fractal->transformCommon.int8Z)
																				+ native_powr(z->y, fractal->transformCommon.int8Z),
						fractal->transformCommon.power025.z));
					*z = (fabs(tempV2 - fractal->transformCommon.offsetC111))
							 * fractal->transformCommon.scale3Dd222;

					tempXZ = (z->y + z->x) * SQRT_1_2;
					*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
						z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
					break;
			}
		}
	}
}
#endif
