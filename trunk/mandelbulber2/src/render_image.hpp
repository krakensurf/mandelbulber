/**
 * Mandelbulber v2, a 3D fractal generator
 *
 * cRenderer class - calculates image using multiple CPU cores and does post processing
 *
 * Copyright (C) 2014 Krzysztof Marczak
 *
 * This file is part of Mandelbulber.
 *
 * Mandelbulber is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * Mandelbulber is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should have received a copy of the GNU
 * General Public License along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 */


#ifndef RENDER_IMAGE_HPP_
#define RENDER_IMAGE_HPP_

#include "cimage.hpp"
#include "fractparams.hpp"
#include "four_fractals.hpp"
#include "render_data.hpp"

class cRenderer : public QObject
{
	Q_OBJECT
public:
	cRenderer(const cParamRender *_params, const cFourFractals *_fractal, sRenderData *_renderData, cImage *_image, QObject *_parentObject);
	bool RenderImage();

private:
	const cParamRender *params;
	const cFourFractals *fractal;
	sRenderData *data;
	cImage *image;
	QObject *parentObject;

	signals:
	void updateProgressAndStatus(const QString &text, const QString &progressText, double progress);
	void updateHistogramIterations(cHistogram histogram);
	void updateHistogramStepCount(cHistogram histogram);
};

#endif /* RENDER_IMAGE_HPP_ */
