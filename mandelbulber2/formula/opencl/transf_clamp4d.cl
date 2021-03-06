/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * clamp 4d

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_clamp4d.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfClamp4dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 upper = fractal->transformCommon.offset1111;
	REAL4 lower = fractal->transformCommon.offsetNeg1111;
	REAL4 scale = fractal->transformCommon.scale0000;
	REAL4 oldZ = z;

	if (fractal->transformCommon.functionEnabledx)
	{
		if (fractal->transformCommon.functionEnabledxFalse) z.x = fabs(z.x);
		if (z.x < lower.x) z.x = lower.x;
		if (z.x > upper.x) z.x = upper.x;
		z.x = mad(oldZ.x, scale.x, -z.x);
	}
	if (fractal->transformCommon.functionEnabledAyFalse)
	{
		if (fractal->transformCommon.functionEnabledyFalse) z.y = fabs(z.y);
		if (z.y < lower.y) z.y = lower.y;
		if (z.y > upper.y) z.y = upper.y;
		z.y = mad(oldZ.y, scale.y, -z.y);
	}
	if (fractal->transformCommon.functionEnabledAzFalse)
	{
		if (fractal->transformCommon.functionEnabledzFalse) z.z = fabs(z.z);
		if (z.z < lower.z) z.z = lower.z;
		if (z.z > upper.z) z.z = upper.z;
		z.z = mad(oldZ.z, scale.z, -z.z);
	}

	if (fractal->transformCommon.functionEnabledAwFalse)
	{
		if (fractal->transformCommon.functionEnabledwFalse) z.w = fabs(z.w);
		if (z.w < lower.w) z.w = lower.w;
		if (z.w > upper.w) z.w = upper.w;
		z.w = mad(oldZ.w, scale.w, -z.w);
	}

	aux->DE *= fractal->analyticDE.scale1;
	return z;
}