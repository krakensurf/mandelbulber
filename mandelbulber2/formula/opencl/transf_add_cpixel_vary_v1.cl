/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Adds Cpixel constant to z, Cpixel scaled  based on variable iteration parameters.

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfAddCpixelVaryV1Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfAddCpixelVaryV1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 tempVC = fractal->transformCommon.constantMultiplier111; // constant to be varied
	if (aux->i < fractal->transformCommon.startIterations250)
	{
		;
	}
	if (aux->i >= fractal->transformCommon.startIterations250
			&& aux->i < fractal->transformCommon.stopIterations
			&& (fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250
					 != 0))
	{

		int iterationRange =
			fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250;
		int currentIteration = (aux->i - fractal->transformCommon.startIterations250);
		tempVC +=
			fractal->transformCommon.offset000 * native_divide((1.0f * currentIteration), iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterations)
	{
		tempVC = (tempVC + fractal->transformCommon.offset000);
	}
	z += aux->const_c * tempVC;
	return z;
}