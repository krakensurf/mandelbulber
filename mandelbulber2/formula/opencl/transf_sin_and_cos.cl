/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * sin and cos

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_sin_and_cos.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSinAndCosIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// Q_UNUSED(aux);
	REAL4 oldZ = z;
	REAL4 sinZ = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
	REAL4 cosZ = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};

	REAL4 scaleZ = z * fractal->transformCommon.constantMultiplierC111;

	if (fractal->transformCommon.functionEnabledAx)
		sinZ.x = native_sin(scaleZ.x); // scale =0, sin = 0
	if (fractal->transformCommon.functionEnabledAy) sinZ.y = native_sin(scaleZ.y);
	if (fractal->transformCommon.functionEnabledAz) sinZ.z = native_sin(scaleZ.z);

	if (fractal->transformCommon.functionEnabledAxFalse)
		cosZ.x = native_cos(scaleZ.x); // scale =0, cos = 1
	if (fractal->transformCommon.functionEnabledAyFalse) cosZ.y = native_cos(scaleZ.y);
	if (fractal->transformCommon.functionEnabledAzFalse) cosZ.z = native_cos(scaleZ.z);

	switch (fractal->combo6.combo6)
	{
		case multi_combo6Cl_type1:
		default: z = (sinZ + cosZ); break;
		case multi_combo6Cl_type2: z = sinZ * cosZ; break;
		case multi_combo6Cl_type3: z = oldZ + (sinZ + cosZ); break;
		case multi_combo6Cl_type4: z = oldZ + (sinZ * cosZ); break;
		case multi_combo6Cl_type5: z = oldZ * (sinZ + cosZ); break;
		case multi_combo6Cl_type6: z = oldZ * (sinZ * cosZ); break;
	}

	// post scale
	if (!fractal->transformCommon.functionEnabledFalse)
		z *= fractal->transformCommon.scale;
	else
	{
		z.x = z.x * native_divide(fractal->transformCommon.scale, (fabs(oldZ.x) + 1.0f));
		z.y = z.y * native_divide(fractal->transformCommon.scale, (fabs(oldZ.y) + 1.0f));
		z.z = z.z * native_divide(fractal->transformCommon.scale, (fabs(oldZ.z) + 1.0f));
		// aux->DE = aux->DE * native_divide(length(z), length(oldZ));
	}

	if (!fractal->analyticDE.enabledFalse)
		aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale), 1.0f);
	else
		aux->DE = mad(aux->DE * fabs(fractal->transformCommon.scale), fractal->analyticDE.scale1,
			fractal->analyticDE.offset1);
	return z;
}