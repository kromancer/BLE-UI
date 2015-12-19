/*************************************************************************************
** The MIT License (MIT)
**
** Knobs is a free Qt and QML based widget.
** Copyright (c) 2015 Ashish Dabhade
** Email: ashishd157@gmail.com
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in all
** copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
** SOFTWARE.
************************************************************************************/

#include "knob.h"

Knob::Knob(QQuickItem *parent)
    : QQuickItem(parent),
      m_size(200),
      m_color(QColor(135,206,235)),
      m_backgroundColor(QColor(241,241,241)),
      m_foregroundColor(Qt::white),
      m_textColor(Qt::red),
      m_borderColor(Qt::darkGray),
      m_value(0),
      m_minimumValue(0),
      m_maximumValue(100),
      m_percent(0),
      m_readOnly(false),
      m_pieMultiColor(false),
      m_meter(false),
      m_style(Knob::Pie),
      m_needleType(Knob::Point),
      m_pieType(Knob::Flat),
      m_mode(Knob::Normal),
      m_engine(0),
      m_base(0),
      m_text(0)
{
    setSmooth(true);
    setAntialiasing(true);
}

Knob::~Knob()
{
    delete m_base;
    m_base = 0;
    delete m_text;
    m_text = 0;
}

void Knob::classBegin()
{ }

void Knob::componentComplete()
{
    setWidth(m_size);
    setHeight(m_size);
    m_engine = qmlEngine(parentItem());
    connect(parentItem(),&QQuickItem::destroyed,m_engine,&QQmlEngine::deleteLater);
    base();top();mid();
    if(m_style==Knob::Needle&&m_needleType==Knob::Point&&m_meter==true)
        showMeter();
}

void Knob::base()
{
    m_base = new Dial(this);
    connect(parentItem(),&QQuickItem::destroyed,m_base,&QQuickItem::deleteLater);
    m_base->setProperty("x",x());
    m_base->setProperty("y",y());
    m_base->setProperty("z",0.1);
    m_base->setProperty("width",m_size);
    m_base->setProperty("height",m_size);
    m_base->setProperty("color",m_backgroundColor);
    m_base->setProperty("borderColor",m_borderColor);
}

void Knob::showMeter()
{
    Meter *meter = new Meter(m_base);
    connect(parentItem(),&QQuickItem::destroyed,meter,&QQuickItem::deleteLater);
    meter->setProperty("x",x());
    meter->setProperty("y",y());
    meter->setProperty("z",0.2);
    meter->setProperty("width",m_size);
    meter->setProperty("height",m_size);
}

void Knob::top()
{
    Dial *m_top = new Dial(m_base);
    connect(parentItem(),&QQuickItem::destroyed,m_top,&QQuickItem::deleteLater);
    m_top->setProperty("bottom",false);
    qreal w = m_needleType < 7 ? qreal(m_size/1.5) : qreal(m_size/1.2);
    m_top->setProperty("x",m_base->width()/2.0-w/2.0);
    m_top->setProperty("y",m_base->height()/2.0-w/2.0);
    m_top->setProperty("z",0.4);
    m_top->setProperty("width",w);
    m_top->setProperty("height",w);
    m_top->setProperty("color",m_foregroundColor);
    m_top->setProperty("borderColor",m_borderColor);

    QQmlComponent component(m_engine);
    component.setData(Component::getComponent("Text"),QUrl());
    m_text = qobject_cast<QQuickItem*>(component.create());
    m_text->setParentItem(m_base);
    m_text->setProperty("z",0.5);
    m_text->setProperty("color",m_textColor);
    QFont f; f.setPointSize(16);
    m_text->setProperty("font",f);
    m_text->setProperty("text",m_mode==Knob::Percent?QString::number(m_percent)+"%":QString::number(m_minimumValue));
}

void Knob::mid()
{
    QQuickItem *item = 0;
    QUrl url("qrc:/qml/");
    QQmlComponent component(m_engine);
    auto percentSlot = [=](const int &percent) { m_text->setProperty("text",QString::number(percent)+"%");};
    auto valueSlot = [=](const int &value) { m_text->setProperty("text",QString::number(value));};
    switch(m_style) {
        case Knob::Pie: {
            component.setData(Component::getComponent("PieStyle",m_mode==Knob::Percent?"percent":"value"),url);
            PieStyle *pie = qobject_cast<PieStyle*>(component.create());
            if(m_mode==Knob::Normal) {
                connect(pie,&PieStyle::valueChanged,valueSlot);
                connect(this,&Knob::valueChanged,[=](const int &value) {
                    if(pie->animationRunning()) return;
                    pie->setProperty("value",value);});
            } else {
                connect(pie,&PieStyle::percentChanged,percentSlot);
                connect(this,&Knob::percentChanged,[=](const int &percent) {
                    if(pie->animationRunning()) return;
                    pie->setProperty("percent",percent);});
            }
            makeConnections(*pie);
            item = pie;
            item->setProperty("multicolor",m_pieMultiColor);
            item->setProperty("style",m_pieType);
            break;
        }
        case Knob::Arc: {
            component.setData(Component::getComponent("ArcStyle",m_mode==Knob::Percent?"percent":"value"),url);
            ArcStyle *arc = qobject_cast<ArcStyle*>(component.create());
            if(m_mode==Knob::Normal) {

		
                connect(arc,&ArcStyle::valueChanged,valueSlot);
		connect(arc, SIGNAL(endValueChanged(int)), this, SLOT(newEndValue(int)) );

		
                connect(this,&Knob::valueChanged,[=](const int &value) {
                    if(arc->animationRunning()) return;
                    arc->setProperty("value",value);});
            } else {
                connect(arc,&ArcStyle::percentChanged,percentSlot);
                connect(this,&Knob::percentChanged,[=](const int &percent) {
                    if(arc->animationRunning()) return;
                    arc->setProperty("percent",percent);});
            }
            makeConnections(*arc);
            item = arc;
            break;
        }
        case Knob::Needle: {
            component.setData(Component::getComponent("NeedleStyle",m_mode==Knob::Percent?"percent":"value"),url);
            NeedleStyle *needle = qobject_cast<NeedleStyle*>(component.create());
            if(m_mode==Knob::Normal) {
                connect(needle,&NeedleStyle::valueChanged,valueSlot);
                connect(this,&Knob::valueChanged,[=](const int &value) {
                    if(needle->animationRunning()) return;
                    needle->setProperty("value",value);});
            } else {
                connect(needle,&NeedleStyle::percentChanged,percentSlot);
                connect(this,&Knob::percentChanged,[=](const int &percent) {
                    if(needle->animationRunning()) return;
                    needle->setProperty("percent",percent);});
            }
            makeConnections(*needle);
            item = needle;
            item->setProperty("style",m_needleType);
            break;
        }
    }
    item->setParentItem(m_base);
    item->setProperty("z",0.3);
    item->setProperty("width",m_size);
    item->setProperty("height",m_size);
    item->setProperty("color",m_color);
    item->setProperty("minValue",m_minimumValue);
    item->setProperty("maxValue",m_maximumValue);
    item->setProperty("readOnly",m_readOnly);
    item->setProperty("mode",m_mode);
    m_mode==Knob::Normal ? item->setProperty("value",m_value) : item->setProperty("percent",m_percent);
}

void Knob::makeConnections(QQuickItem &item)
{
    connect(&item,SIGNAL(valueChanged(int)),this,SLOT(setValue(int)));
    connect(&item,SIGNAL(percentChanged(int)),this,SLOT(setPercent(int)));
    connect(parentItem(),&QQuickItem::destroyed,&item,&QQuickItem::deleteLater);
}

void Knob::setSize(qreal arg)
{
    if (m_size == arg)
        return;

    m_size = arg;
    if(m_size<100)
        m_size = 100;
    emit sizeChanged(m_size);
}


void Knob::newEndValue(int v){
    qWarning() << "Salvation is near";
    emit endValueChanged(v);
}

