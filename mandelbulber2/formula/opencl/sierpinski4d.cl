/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Sierpinski4D.from Syntopia & Darkbeam's code
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "Sierpinski4dIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 Sierpinski4dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{

	REAL temp;
	if (z.x + z.y < 0.0f)
	{
		temp = z.x;
		z.x = -z.y;
		z.y = -temp;
	}

	if (z.x + z.z < 0.0f)
	{
		temp = z.x;
		z.x = -z.z;
		z.z = -temp;
	}

	if (z.y + z.z < 0.0f)
	{
		temp = z.z;
		z.z = -z.y;
		z.y = -temp;
	}

	if (z.x + z.w < 0.0f)
	{
		temp = z.x;
		z.x = -z.w;
		z.w = -temp;
	}

	if (z.y + z.w < 0.0f)
	{
		temp = z.y;
		z.y = -z.w;
		z.w = -temp;
	}

	if (z.z + z.w < 0.0f)
	{
		temp = z.z;
		z.z = -z.w;
		z.w = -temp;
	}

	z = z * fractal->transformCommon.scaleA2;

	if (aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		z -= fractal->transformCommon.offset1111; // neg offset
	}

	// 6 plane rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		REAL4 tp;
		if (fractal->transformCommon.rotation44a.x != 0)
		{
			tp = z;
			REAL alpha = fractal->transformCommon.rotation44a.x * M_PI_180;
			z.x = mad(tp.x, native_cos(alpha), tp.y * native_sin(alpha));
			z.y = mad(tp.x, -native_sin(alpha), tp.y * native_cos(alpha));
		}
		if (fractal->transformCommon.rotation44a.y != 0)
		{
			tp = z;
			REAL beta = fractal->transformCommon.rotation44a.y * M_PI_180;
			z.y = mad(tp.y, native_cos(beta), tp.z * native_sin(beta));
			z.z = mad(tp.y, -native_sin(beta), tp.z * native_cos(beta));
		}
		if (fractal->transformCommon.rotation44a.z != 0)
		{
			tp = z;
			REAL gamma = fractal->transformCommon.rotation44a.z * M_PI_180;
			z.x = mad(tp.x, native_cos(gamma), tp.z * native_sin(gamma));
			z.z = mad(tp.x, -native_sin(gamma), tp.z * native_cos(gamma));
		}
		if (fractal->transformCommon.rotation44b.x != 0)
		{
			tp = z;
			REAL delta = fractal->transformCommon.rotation44b.x * M_PI_180;
			z.x = mad(tp.x, native_cos(delta), tp.w * native_sin(delta));
			z.w = mad(tp.x, -native_sin(delta), tp.w * native_cos(delta));
		}
		if (fractal->transformCommon.rotation44b.y != 0)
		{
			tp = z;
			REAL epsilon = fractal->transformCommon.rotation44b.y * M_PI_180;
			z.y = mad(tp.y, native_cos(epsilon), tp.w * native_sin(epsilon));
			z.w = mad(tp.y, -native_sin(epsilon), tp.w * native_cos(epsilon));
		}
		if (fractal->transformCommon.rotation44b.z != 0)
		{
			tp = z;
			REAL zeta = fractal->transformCommon.rotation44b.z * M_PI_180;
			z.z = mad(tp.z, native_cos(zeta), tp.w * native_sin(zeta));
			z.w = mad(tp.z, -native_sin(zeta), tp.w * native_cos(zeta));
		}
	}

	if (!fractal->analyticDE.enabledFalse) // testing
		aux->DE *= fractal->transformCommon.scaleA2;
	else
		aux->DE = mad(aux->DE * fractal->transformCommon.scaleA2, fractal->analyticDE.scale1,
			fractal->analyticDE.offset0);
	return z;
}