#include "mmode.h"

Mmode::Mmode(QCustomPlot *parent) :
    QCustomPlot(parent){
    _time.resize(SAMPLES/2);
    _dataRe.resize(SAMPLES/2);
    _dataIm.resize(SAMPLES/2);
    _data2Re.resize(SAMPLES/2);
    _data2Im.resize(SAMPLES/2);
    for (int i = 0; i < SAMPLES/2; i++){
        _time[i] = i;
        _dataRe[i] = (double)(i/10);
        _dataIm[i] = (double)(i/10);
    }
    addGraph();
    addGraph();
    graph(0)->setData(_time, _dataRe);
    graph(1)->setData(_time, _dataIm);
    graph(1)->setPen(QPen(Qt::red));
    addGraph();
    graph(2)->setData(_time, _data2Re);
    graph(2)->setPen(QPen(Qt::yellow));
    addGraph();
    graph(3)->setData(_time, _data2Im);
    graph(3)->setPen(QPen(Qt::green));
    xAxis->setLabel("x");
    yAxis->setLabel("Signalamplitude in mV");
    xAxis->setRange(0, SAMPLES/2);
    yAxis->setRange(-825, 825);

    setLocale(QLocale(QLocale::German, QLocale::Germany)); // period as decimal separator and comma as thousand separator

    //yAxis->setScaleType(QCPAxis::stLogarithmic);
    //yAxis->setScaleLogBase(10);
    //yAxis->setNumberFormat("mV"); // e = exponential, b = beautiful decimal powers
    //yAxis->setNumberPrecision(0); // makes sure "1*10^4" is displayed only as "10^4"

    setInteraction(QCP::iRangeDrag, true);
    setInteraction(QCP::iRangeZoom, true);
    axisRect()->setRangeZoom(Qt::Vertical);
    setBackground(Qt::lightGray);
    axisRect()->setBackground(Qt::white);
    replot();
    connect(this, SIGNAL(mouseWheel(QWheelEvent*)), this, SLOT(on_mouseWheel(QWheelEvent*)));
    fill_Time(SAMPLES*Multiply/2);
}

void Mmode::plot()
{
    graph(0)->setData(_time, _dataRe);
    graph(1)->setData(_time, _dataIm);
    graph(2)->setData(_time, _data2Re);
    graph(3)->setData(_time, _data2Im);
    replot();
    emit graphChanged();
}

void Mmode::on_NewData(int32_t *data, int size)
{
    for(int i = 0; i < size/4-1; i=i+2){
        _dataRe[i/2] = (double)data[2*i];//*usdDevice::adcRange()/2/usdDevice::adcResolution();//1650*data[i]/dbref;
        _dataIm[i/2] = (double)data[2*i+1];//*usdDevice::adcRange()/2/usdDevice::adcResolution();//1650*data[i]/dbref;
        _data2Re[i/2] = (double)data[2*i+2];//*usdDevice::adcRange()/2/usdDevice::adcResolution();//1650*data[i]/dbref;
        _data2Im[i/2] = (double)data[2*i+3];//*usdDevice::adcRange()/2/usdDevice::adcResolution();//1650*data[i]/dbref;
    }
    plot();
}

void Mmode::on_mouseWheel(QWheelEvent *event)
{
    (QApplication::keyboardModifiers() && Qt::ControlModifier) ?
        axisRect()->setRangeZoom(Qt::Horizontal) : axisRect()->setRangeZoom(Qt::Vertical);
    event->isAccepted();
}

void Mmode::fill_Time(int size)
{
    _dataRe.clear();
    _dataRe.resize(size);
    _dataIm.clear();
    _dataIm.resize(size);
    _data2Re.clear();
    _data2Re.resize(size);
    _data2Im.clear();
    _data2Im.resize(size);
    _time.clear();
    _time.resize(size);
    for (int i = 0; i < size; i++){
        _time[i] = i;
    }
    xAxis->setRange(0, size);
}
