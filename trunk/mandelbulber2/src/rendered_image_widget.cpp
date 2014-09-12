/*
 * rendered_image_widget.cpp
 *
 *  Created on: Aug 15, 2014
 *      Author: krzysztof
 */

#include "rendered_image_widget.hpp"
#include <QtCore>
#include <QMouseEvent>
#include <QKeyEvent>
#include <QApplication>
#include <QPainter>
#include "fractparams.hpp"
#include "common_math.h"

using namespace Qt;

RenderedImage::RenderedImage(QWidget *parent) :
		QWidget(parent)
{
	// makes RenderedImage focusable to catch keyboard events
	setFocusPolicy(Qt::StrongFocus);
	setMouseTracking(true);

	image = NULL;
	params = NULL;
	cursorVisible = true; //TODO changing cursor visibility
	clickMode = clickMoveCamera;
	smoothLastZMouse = 0.0;
	redrawed = true;
	isFocus = false;
	isOnObject = false;
	lastDepth = 0.0;
	frontDist = 0.0;
}

void RenderedImage::paintEvent(QPaintEvent *event)
{
	(void) event;

	if (image)
	{
		if(cursorVisible && isFocus)
		{
			CVector2<int> point = lastMousePosition / image->GetPreviewScale();
			double z = image->GetPixelZBuffer(point.x, point.y);

			if(z < 1e10)
			{
				redrawed = false;
				isOnObject = true;
				Display3DCursor(lastMousePosition, z);
			}
			else
			{
				isOnObject = false;
			}
		}

		image->RedrawInWidget();

		if(cursorVisible && isFocus && isOnObject)
		{
			DisplayCoordinates();
		}
		redrawed = true;
	}
	else
	{
		qCritical() << "RenderedImage::mouseMoveEvent(QMouseEvent * event): image not assigned";
	}
}

void RenderedImage::DisplayCoordinates()
{
	QPainter painter(this);
	painter.setRenderHints(QPainter::Antialiasing | QPainter::SmoothPixmapTransform);

	QPen penWhite(Qt::white, 1, Qt::SolidLine);
	QBrush brushBrown(QColor(100, 50, 0));
	QBrush brushDarkBlue(QColor(0, 0, 100));

	QString text;
	switch (clickMode)
	{
		case clickMoveCamera:
			text = QString("Move camera");
			break;

		case clickFogVisibility:
			text = QString("Change fog visibility");
			break;

		case clickDOFFocus:
			text = QString("Change DOF focus");
			break;

		case clickPlaceLight1:
			text = QString("Place light #1");
			break;
		case clickPlaceLight2:
			text = QString("Place light #2");
			break;
		case clickPlaceLight3:
			text = QString("Place light #3");
			break;
		case clickPlaceLight4:
			text = QString("Place light #4");
			break;
	}
	QRect textRect = painter.boundingRect(QRect(), Qt::AlignLeft, text);
	textRect.setHeight(textRect.height() + 2);
	textRect.moveBottomLeft(QPoint(lastMousePosition.x + 30, lastMousePosition.y - 3));

	painter.setOpacity(0.5);
	painter.setPen(penWhite);
	painter.setBrush(brushBrown);
	painter.drawRoundedRect(textRect, 3, 3);
	painter.drawText(QPoint(lastMousePosition.x + 30, lastMousePosition.y - 4), text);

	QString textCoordinates;
	textCoordinates += "x: " + QString::number(lastCoordinates.x, 'g', 15);
	textCoordinates += "\ny: " + QString::number(lastCoordinates.y, 'g', 15);
	textCoordinates += "\nz: " + QString::number(lastCoordinates.z, 'g', 15);
	textCoordinates += "\ndist: " + QString::number(lastDepth, 'g', 15);

	QRect textRect2 = painter.boundingRect(QRect(), Qt::AlignTop || Qt::AlignLeft, textCoordinates);
	textRect2.setHeight(textRect2.height() + 2);
	textRect2.moveTopLeft(QPoint(lastMousePosition.x + 30, lastMousePosition.y + 3));
	painter.setOpacity(0.5);
	painter.setPen(penWhite);
	painter.setBrush(brushDarkBlue);
	painter.drawRoundedRect(textRect2, 3, 3);
	painter.drawText(textRect2, Qt::AlignTop || Qt::AlignLeft, textCoordinates);
}

void RenderedImage::Display3DCursor(CVector2<int> screenPoint, double z)
{
	if (clickMode == clickPlaceLight1 || clickMode == clickPlaceLight2 || clickMode == clickPlaceLight3 || clickMode == clickPlaceLight4)
	{
		z -= frontDist;
	}

	smoothLastZMouse = smoothLastZMouse + (z - smoothLastZMouse) * 0.01;

	if (z > 0)
	{

		//preparing rotation matrix
		CVector3 rotation = params->Get<CVector3>("camera_rotation") / 180.0 * M_PI;
		CRotationMatrix mRot;
		mRot.RotateZ(rotation.x);
		mRot.RotateX(rotation.y);
		mRot.RotateY(rotation.z);

		double fov = params->Get<double>("fov");

		double sw = image->GetPreviewWidth();
		double sh = image->GetPreviewHeight();

		double aspectRatio = sw / sh;

		CVector2<double> p;
		p.x = (screenPoint.x / sw - 0.5) * aspectRatio;
		p.y = (screenPoint.y / sh - 0.5);

		double scale = smoothLastZMouse / z;

		double boxWidth = 10.0 / sw * scale;
		double boxHeight = 10.0 / sw * scale;
		double boxDepth = 10.0 / sw * scale;

		double boxWidth2 = boxWidth * z * fov;
		double boxHeigth2 = boxHeight * z * fov;
		double boxDepth2 = boxHeight * z * fov;

		double n = 3.0;

		for (int iz = -n; iz <= n; iz++)
		{
			double yy1 = ((p.y + n * boxHeight) / (1.0 - boxDepth * iz * fov) + 0.5) * sh;
			double yy2 = ((p.y - n * boxHeight) / (1.0 - boxDepth * iz * fov) + 0.5) * sh;
			for (int ix = -3.0; ix <= 3.0; ix++)
			{
				double xx1 = ((p.x + boxWidth * ix) / (1.0 - boxDepth * iz * fov) / aspectRatio + 0.5) * sw;
				unsigned char R = 128 + iz * 40;
				unsigned char G = 128 - iz * 40;
				unsigned char B = 0;
				double opacity = 0.8;
				if (iz == 0 && ix == 0)
				{
					R = G = B = 255;
					opacity = 1.0;
				}
				image->AntiAliasedLine(xx1, yy1, xx1, yy2, z - iz * boxDepth2, z - iz * boxDepth2, sRGB8(R, G, B), opacity, 1);
			}

			double xx1 = ((p.x + n * boxWidth) / (1.0 - boxDepth * iz * fov) / aspectRatio + 0.5) * sw;
			double xx2 = ((p.x - n * boxWidth) / (1.0 - boxDepth * iz * fov) / aspectRatio + 0.5) * sw;
			for (int iy = -n; iy <= n; iy++)
			{
				double yy1 = ((p.y + boxWidth * iy) / (1.0 - boxDepth * iz * fov) + 0.5) * sh;
				unsigned char R = 128 + iz * 40;
				unsigned char G = 128 - iz * 40;
				unsigned char B = 0;
				double opacity = 0.8;

				if (iz == 0 && iy == 0)
				{
					R = G = B = 255;
					opacity = 1.0;
				}

				image->AntiAliasedLine(xx1, yy1, xx2, yy1, z - iz * boxDepth2, z - iz * boxDepth2, sRGB8(R, G, B), opacity, 1);
			}

			if (iz < n)
			{
				for (int ix = -n; ix <= n; ix++)
				{
					for (int iy = -n; iy <= n; iy++)
					{
						double xx1 = ((p.x + boxWidth * ix) / (1.0 - boxDepth * iz * fov) / aspectRatio + 0.5) * sw;
						double yy1 = ((p.y + boxWidth * iy) / (1.0 - boxDepth * iz * fov) + 0.5) * sh;
						double xx2 = ((p.x + boxWidth * ix) / (1.0 - boxDepth * (iz + 1) * fov) / aspectRatio + 0.5) * sw;
						double yy2 = ((p.y + boxWidth * iy) / (1.0 - boxDepth * (iz + 1) * fov) + 0.5) * sh;

						double opacity = 0.8;
						unsigned char R = 128 + iz * 40;
						unsigned char G = 128 - iz * 40;
						unsigned char B = 0;

						if (ix == 0 && iy == 0)
						{
							R = G = B = 255;
							opacity = 1.0;
						}

						image->AntiAliasedLine(xx1, yy1, xx2, yy2, z - iz * boxDepth2, z - (iz + 1) * boxDepth2, sRGB8(R, G, B), opacity, 1);
					}
				}
			}
			if (iz == 0)
			{
				image->AntiAliasedLine(screenPoint.x - sw * 0.3, screenPoint.y, screenPoint.x + sw * 0.3, screenPoint.y, z, z, sRGB8(255, 255, 255), 1.0, 1);
				image->AntiAliasedLine(screenPoint.x, screenPoint.y - sh * 0.3, screenPoint.x, screenPoint.y + sh * 0.3, z, z, sRGB8(255, 255, 255), 1.0, 1);

				if (clickMode == clickPlaceLight1 || clickMode == clickPlaceLight2 || clickMode == clickPlaceLight3 || clickMode == clickPlaceLight4)
				{
					double r = 1.5 * (boxWidth * n / aspectRatio);
					if (r > 1.0) r = 1.0;
					image->CircleBorder(screenPoint.x, screenPoint.y, z, r * sw, (sRGB8 ) { 0, 100, 255 }, r * 0.1 * sw, 1.0, 1);
				}

			}
		}

		p.y *= -1.0;
		params::enumPerspectiveType perspType = (params::enumPerspectiveType) params->Get<int>("perspective_type");
		CVector3 camera = params->Get<CVector3>("camera");
		CVector3 viewVector = CalculateViewVector(p, fov, perspType, mRot);
		CVector3 point = camera + viewVector * z;
		lastCoordinates = point;
	}
	lastDepth = z;
}

void RenderedImage::mouseMoveEvent(QMouseEvent * event)
{
	CVector2<int> screenPoint(event->x(), event->y());

	//remember last mouse position
	lastMousePosition = screenPoint;

	if(params)
	{
		if(cursorVisible && isFocus && redrawed)
		{
			update();
		}
	}
	else
	{
		qCritical() << "RenderedImage::mouseMoveEvent(QMouseEvent * event): parameters not assigned";
	}

	emit mouseMoved(screenPoint.x, screenPoint.y);
}

void RenderedImage::mousePressEvent(QMouseEvent * event)
{
	emit singleClick(event->x(), event->y(), event->button());
}

void RenderedImage::mouseReleaseEvent(QMouseEvent * event)
{
}

void RenderedImage::enterEvent(QEvent * event)
{
	setFocus();
	isFocus = true;
}

void RenderedImage::leaveEvent(QEvent * event)
{
	isFocus = false;
	update();
}

void RenderedImage::keyPressEvent(QKeyEvent * event)
{
	emit keyPress((Qt::Key) event->key());
}

void RenderedImage::keyReleaseEvent(QKeyEvent * event)
{
	emit keyRelease((Qt::Key) event->key());
}

void RenderedImage::wheelEvent(QWheelEvent * event)
{
	emit mouseWheelRotated(event->delta());
	if(params)
	{
		if(cursorVisible && isFocus && redrawed)
		{
			update();
		}
	}
	else
	{
		qCritical() << "RenderedImage::mouseMoveEvent(QMouseEvent * event): parameters not assigned";
	}
}
