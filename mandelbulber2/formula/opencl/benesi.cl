/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Formula invented by Benesi
 * @reference http://www.fractalforums.com/index.php?action=profile;u=1170

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "BenesiIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 BenesiIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(fractal);

	REAL4 c = aux->const_c;
	aux->r_dz = aux->r_dz * 2.0f * aux->r;
	REAL r1 = mad(z.y, z.y, z.z * z.z);
	REAL newx;
	if (c.x < 0.0f || z.x < native_sqrt(r1))
	{
		newx = mad(z.x, z.x, -r1);
	}
	else
	{
		newx = mad(-z.x, z.x, r1);
	}
	r1 = -native_rsqrt(r1) * 2.0f * fabs(z.x);
	REAL newy = r1 * (mad(z.y, z.y, -z.z * z.z));
	REAL newz = r1 * 2.0f * z.y * z.z;

	z.x = newx;
	z.y = newy;
	z.z = newz;
	return z;
}