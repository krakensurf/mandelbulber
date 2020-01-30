/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * scale - offset  simple

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_scale_offset.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfScaleOffsetIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	z -= fractal->transformCommon.additionConstant000;
	z *= fractal->transformCommon.scale1;
	z += fractal->transformCommon.additionConstant000;
	if (!fractal->analyticDE.enabledFalse)
		aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale), 1.0f);
	else
		aux->DE = mad(aux->DE * fabs(fractal->transformCommon.scale), fractal->analyticDE.scale1,
			fractal->analyticDE.offset1);
	return z;
}