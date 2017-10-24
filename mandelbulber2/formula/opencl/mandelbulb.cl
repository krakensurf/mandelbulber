/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Classic Mandelbulb fractal.
 * @reference http://www.fractalforums.com/3d-fractal-generation/true-3d-mandlebrot-type-fractal/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "MandelbulbIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbulbIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// if (aux->r < 1e-21f) aux->r = 1e-21f;
	REAL th0 = asin(native_divide(z.z, aux->r)) + fractal->bulb.betaAngleOffset;
	REAL ph0 = atan2(z.y, z.x) + fractal->bulb.alphaAngleOffset;
	REAL rp = native_powr(aux->r, fractal->bulb.power - 1.0f);
	REAL th = th0 * fractal->bulb.power;
	REAL ph = ph0 * fractal->bulb.power;
	REAL cth = native_cos(th);
	aux->r_dz = mad((rp * aux->r_dz), fractal->bulb.power, 1.0f);
	rp *= aux->r;
	z.x = cth * native_cos(ph) * rp;
	z.y = cth * native_sin(ph) * rp;
	z.z = native_sin(th) * rp;
	return z;
}