/**
 * Mandelbulber v2, a 3D fractal generator
 *
 * RenderedImage class - extension for QWidget class. Widged prepared for displaying rendered image and 3D cursor
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

#ifndef RENDERED_IMAGE_WIDGET_HPP_
#define RENDERED_IMAGE_WIDGET_HPP_

#include <QWidget>
#include "cimage.hpp"
#include "parameters.hpp"
#include "algebra.hpp"

using namespace Qt;

class RenderedImage: public QWidget
{
Q_OBJECT

public:

enum enumClickMode
{
	clickDoNothing = 0,
	clickMoveCamera = 1,
	clickFogVisibility = 2,
	clickDOFFocus = 3,
	clickPlaceLight1 = 4,
	clickPlaceLight2 = 5,
	clickPlaceLight3 = 6,
	clickPlaceLight4 = 7,
	clickGetJuliaConstant = 8
};

	RenderedImage(QWidget *parent = 0);
	void AssignImage(cImage *_image) {image = _image;}
	void AssignParameters(cParameterContainer *_mainParams) {params = _mainParams;}
	void setNewZ(double z) {smoothLastZMouse = z;}
	void setClickMode(enumClickMode _clickMode) {clickMode = _clickMode;}
	void SetFrontDist(double dist) {frontDist = dist;}
	void SetCursorVisibility(bool enable) {cursorVisible = enable;};

protected:
	void paintEvent(QPaintEvent *event);
	void mouseMoveEvent(QMouseEvent * event);
	void mousePressEvent(QMouseEvent * event);
	void mouseReleaseEvent(QMouseEvent * event);
	void keyPressEvent(QKeyEvent * event);
	void keyReleaseEvent(QKeyEvent * event);
	void enterEvent(QEvent * event);
	void leaveEvent(QEvent * event);
	void wheelEvent(QWheelEvent * event);

private:
	void DisplayCoordinates();
	void Display3DCursor(CVector2<int> screenPoint, double z);

	cImage *image;
	enumClickMode clickMode;
	cParameterContainer *params;
	bool cursorVisible;
	double smoothLastZMouse;
	bool redrawed;
	CVector2<int> lastMousePosition;
	CVector3 lastCoordinates;
	double lastDepth;
	bool isFocus;
	bool isOnObject;
	double frontDist;

signals:
	void mouseMoved(int x, int y);
	void singleClick(int x, int y, Qt::MouseButton button);
	void keyPress(Qt::Key key);
	void keyRelease(Qt::Key key);
	void mouseWheelRotated(int delta);
};


#endif /* RENDERED_IMAGE_WIDGET_HPP_ */
