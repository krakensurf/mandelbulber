/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 *
 * quadratic iteration in real or imaginary scator algebra

 * @reference
 * http://www.fractalforums.com/new-theories-and-research/
 * ix-possibly-the-holy-grail-fractal-%28in-fff-lore%29
 * https://luz.izt.uam.mx/drupal/en/fractals/ix
 * @author Manuel Fernandez-Guasti

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TestingLogIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingLogIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	REAL4 oldZ = z;
	// if
	{
		REAL4 zz = z * z;
		// REAL r = aux->r;
		// log DE calc
		if (fractal->analyticDE.enabled)
		{
			REAL r = native_sqrt(zz.x + zz.y + zz.z + native_divide((zz.y * zz.z), zz.x));
			if (fractal->transformCommon.functionEnabledXFalse) r = length(z);
			if (fractal->transformCommon.functionEnabledyFalse)
				r = max(fabs(z.z), max(fabs(z.y), fabs(z.x)));
			if (fractal->transformCommon.functionEnabledzFalse)
			{
				REAL4 zz = z * z;
				r = native_sqrt(max(zz.x + zz.y, max(zz.y + zz.z, zz.x + zz.z)));
			}

			aux->DE = mad(r * aux->DE * 2.0f, fractal->analyticDE.scale1, fractal->analyticDE.offset1);
		}
		// r = max(fabs(z.z), max(fabs(z.y), fabs(z.x)));
		// REAL4 zz = z * z;
		// r = native_sqrt(max(zz.x + zz.y, max(zz.y + zz.z, zz.x + zz.z)))

		REAL4 newZ = z;

		if (fractal->transformCommon.functionEnabledFalse)
		/*{
			aux->DE = aux->DE * 2.0f * r;

			REAL temp = 1.0f - native_divide(zz.z, (zz.x + zz.y));
			newZ.x = (zz.x - zz.y) * temp;
			newZ.y = z.x * z.y * temp;
			newZ.z = -z.z * native_sqrt(zz.x + zz.y);

			newZ.x +=  native_divide((zz.y * zz.z), zz.x);
			newZ.y *= (1.0f - native_divide(zz.z, zz.x));
			newZ.z *= (1.0f - native_divide(zz.y, zz.x));
			newZ *= fractal->transformCommon.constantMultiplier122; //vec3 (1f,2,2)
			z = newZ;

		{
			Q_UNUSED(fractal);
			Q_UNUSED(aux);

			REAL x2 = z.x * z.x; // + 1e-030f;
			REAL y2 = z.y * z.y;
			REAL z2 = z.z * z.z;

			REAL newx = x2 - y2 - z2 + native_divide((y2 * z2), x2);
			REAL newy = 2.0f * z.x * z.y * (1.0f - native_divide(z2, x2));
			REAL newz = 2.0f * z.x * z.z * (1.0f - native_divide(y2, x2));

			z.x = newx;
			z.y = newy;
			z.z = newz;
		}

		}*/

		{
			newZ.x = zz.x - zz.y - zz.z;
			newZ.y = z.x * z.y;
			newZ.z = z.x * z.z;
			newZ *= fractal->transformCommon.constantMultiplier122; // vec3 (1f,2,2)
			if (fractal->transformCommon.functionEnabledDFalse)
			{
				newZ += c * fractal->transformCommon.additionConstant000;
			}

			REAL4 scaleScat = fractal->transformCommon.constantMultiplierA111; // vec3 (1f,1,1)
			newZ.x += scaleScat.x * (zz.y * native_divide(zz.z, zz.x));
			newZ.y *= 1.0f - (scaleScat.y * (native_divide(zz.z, zz.x)));
			newZ.z *= 1.0f - (scaleScat.z * (native_divide(zz.y, zz.x)));

			if (fractal->transformCommon.functionEnabledSFalse)
			{ // rev
				zz = newZ * newZ;
				newZ.x -= native_divide((zz.y * zz.z), zz.x);
				newZ.y /= (1.0f - native_divide(zz.z, zz.x));
				newZ.z /= (1.0f - native_divide(zz.y, zz.x));
			}
			z = newZ;
		}
		else
		{
			newZ.x = zz.x + zz.y + zz.z; // + native_divide((zz.y * zz.z), zz.x);
			newZ.y = z.x * z.y;					 //* (1.0f + native_divide(zz.z, zz.x));
			newZ.z = z.x * z.z;					 // * (1.0f + native_divide(zz.y, zz.x));
			newZ *= fractal->transformCommon.constantMultiplier122;

			if (fractal->transformCommon.functionEnabledDFalse)
			{
				newZ += c * fractal->transformCommon.additionConstant000;
			}

			REAL4 scaleScat = fractal->transformCommon.constantMultiplierA111; // vec3 (1f,1,1)
			newZ.x += scaleScat.x * (zz.y * native_divide(zz.z, zz.x));
			newZ.y *= 1.0f + (scaleScat.y * (native_divide(zz.z, zz.x)));
			newZ.z *= 1.0f + (scaleScat.z * (native_divide(zz.y, zz.x)));

			// aux->DE = aux->DE * 2.0f * aux->r;
			// REAL tempL = length(z);

			// if (tempL < 1e-21f) tempL = 1e-21f;

			// REAL4 tempAvgScale = (REAL4) {z.x, native_divide(z.y, 2.0f), native_divide(z.z, 2.0f),
			// z.w};
			// REAL avgScale = native_divide(length(tempAvgScale), tempL);
			// REAL tempAux = aux->DE * avgScale;
			// aux->DE = mad(fractal->transformCommon.scaleA1, (tempAux - aux->DE), aux->DE);
			// newZ += fractal->transformCommon.additionConstant000;

			if (fractal->transformCommon.functionEnabledSFalse)
			{
				zz = newZ * newZ;
				newZ.x -= native_divide((zz.y * zz.z), zz.x);
				newZ.y /= (1.0f + native_divide(zz.z, zz.x));
				newZ.z /= (1.0f + native_divide(zz.y, zz.x));
			}
			z = newZ;
			REAL tempp = native_divide(length(oldZ), length(z));
			aux->DE *= tempp;
		}
	}
	// addCpixel
	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate swap
		{

			tempC = aux->c;

			if (fractal->transformCommon.addCpixelEnabled)
			{
				REAL4 cc = tempC * tempC;
				REAL4 newC = tempC;

				if (fractal->transformCommon.functionEnabledFalse)
				{
					newC.x += native_divide((cc.y * cc.z), cc.x);
					newC.y *= (1.0f - native_divide(cc.z, cc.x));
					newC.z *= (1.0f - native_divide(cc.y, cc.x));
				}
				else
				{
					newC.x += native_divide((cc.y * cc.z), cc.x);
					newC.y *= (1.0f + native_divide(cc.z, cc.x));
					newC.z *= (1.0f + native_divide(cc.y, cc.x));
				}
				tempC = newC;
			}
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			if (fractal->transformCommon.addCpixelEnabled) // standard swap
			{
				REAL4 cc = c * c;
				REAL4 newC = c;

				if (fractal->transformCommon.functionEnabledFalse)
				{
					newC.x += 1.0f - native_divide((cc.y * cc.z), cc.x);
					// newC.x = c.x; // /(cc.y * cc.z);
					// newC.x = native_divide((cc.y * cc.z), cc.x);
					newC.y *= (1.0f - native_divide(cc.z, cc.x));
					newC.z *= (1.0f - native_divide(cc.y, cc.x));
				}
				else
				{
					// newC.x = c.x + native_divide((cc.y * cc.z), cc.x);
					newC.x = c.x; // /(cc.y * cc.z);
					// newC.x = native_divide((cc.y * cc.z), cc.x);
					newC.y *= c.y * (1.0f + native_divide(cc.z, cc.x));
					newC.z *= c.z * (1.0f + native_divide(cc.y, cc.x));

					// newC.y = (1.0f + native_divide(cc.z, cc.x));
					// newC.z = (1.0f + native_divide(cc.y, cc.x));
				}
				c = newC;
			}
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplier111;
	}

	/*REAL r = aux->r;
	if (fractal->transformCommon.functionEnabledXFalse)
	{
		r = length(z);
	}
	else
	{
		REAL4 zz = z * z;
		r = native_sqrt(zz.x + zz.y + zz.z + native_divide((zz.y * zz.z), (zz.x)));
	}
	aux->DE = mad(r * aux->DE * 2.0f, fractal->analyticDE.scale1, fractal->analyticDE.offset1);*/
	return z;
}