/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Adds Cpixel constant to z vector. Possible to swap Cpixel vector axes.
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void TransfAddCpixelAxisSwapIteration(
	float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 c = aux->const_c;

	float4 tempC = c;
	if (fractal->transformCommon.alternateEnabledFalse) // alternate
	{
		tempC = aux->c;
		switch (fractal->mandelbulbMulti.orderOfXYZ)
		{
			case multi_OrderOfXYZCl_xyz:
			default: tempC = (float4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
			case multi_OrderOfXYZCl_xzy: tempC = (float4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
			case multi_OrderOfXYZCl_yxz: tempC = (float4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
			case multi_OrderOfXYZCl_yzx: tempC = (float4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
			case multi_OrderOfXYZCl_zxy: tempC = (float4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
			case multi_OrderOfXYZCl_zyx: tempC = (float4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
		}
		aux->c = tempC;
	}
	else
	{
		switch (fractal->mandelbulbMulti.orderOfXYZ)
		{
			case multi_OrderOfXYZCl_xyz:
			default: tempC = (float4){c.x, c.y, c.z, c.w}; break;
			case multi_OrderOfXYZCl_xzy: tempC = (float4){c.x, c.z, c.y, c.w}; break;
			case multi_OrderOfXYZCl_yxz: tempC = (float4){c.y, c.x, c.z, c.w}; break;
			case multi_OrderOfXYZCl_yzx: tempC = (float4){c.y, c.z, c.x, c.w}; break;
			case multi_OrderOfXYZCl_zxy: tempC = (float4){c.z, c.x, c.y, c.w}; break;
			case multi_OrderOfXYZCl_zyx: tempC = (float4){c.z, c.y, c.x, c.w}; break;
		}
	}
	*z += tempC * fractal->transformCommon.constantMultiplier111;
}
#else
void TransfAddCpixelAxisSwapIteration(
	double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 c = aux->const_c;

	double4 tempC = c;
	if (fractal->transformCommon.alternateEnabledFalse) // alternate
	{
		tempC = aux->c;
		switch (fractal->mandelbulbMulti.orderOfXYZ)
		{
			case multi_OrderOfXYZCl_xyz:
			default: tempC = (double4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
			case multi_OrderOfXYZCl_xzy: tempC = (double4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
			case multi_OrderOfXYZCl_yxz: tempC = (double4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
			case multi_OrderOfXYZCl_yzx: tempC = (double4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
			case multi_OrderOfXYZCl_zxy: tempC = (double4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
			case multi_OrderOfXYZCl_zyx: tempC = (double4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
		}
		aux->c = tempC;
	}
	else
	{
		switch (fractal->mandelbulbMulti.orderOfXYZ)
		{
			case multi_OrderOfXYZCl_xyz:
			default: tempC = (double4){c.x, c.y, c.z, c.w}; break;
			case multi_OrderOfXYZCl_xzy: tempC = (double4){c.x, c.z, c.y, c.w}; break;
			case multi_OrderOfXYZCl_yxz: tempC = (double4){c.y, c.x, c.z, c.w}; break;
			case multi_OrderOfXYZCl_yzx: tempC = (double4){c.y, c.z, c.x, c.w}; break;
			case multi_OrderOfXYZCl_zxy: tempC = (double4){c.z, c.x, c.y, c.w}; break;
			case multi_OrderOfXYZCl_zyx: tempC = (double4){c.z, c.y, c.x, c.w}; break;
		}
	}
	*z += tempC * fractal->transformCommon.constantMultiplier111;
}
#endif
