#include "spectrogram.h"
#include "usdmodel.h"
#include "QtMath"
#include <QtDebug>

#include <fstream>
#include <iostream>

Spectrogram::Spectrogram(uint32_t dataSize, QCustomPlot *parent) :
    QCustomPlot(parent){
    _dataSize = dataSize;
    _frequency.resize(_dataSize);
    _data.resize(_dataSize);
    _SampleFreq = 64000 / _dataSize;
    for (uint32_t i = 0; i < _dataSize; i++){
        _frequency[i] = i;// (double)i * _SampleFreq;
        _data[i] = i;
    }

    addGraph();
    setNoAntialiasingOnDrag(true); // more performance/responsiveness during dragging

    //xAxis->setLabel("frequency (kHz)");
    yAxis->setLabel("Velocity (cm/s)");
    //yAxis->setLabel("Magnitude in dB");
    //yAxis->setLabel("Amplitude in mV");

    xAxis->setRange(0, _dataSize);
    //xAxis->setRange(_frequency[1], _frequency[SAMPLES/2-1]);
    graph(0)->setData(_frequency, _data);
/**/
    //graph(0)->setBrush(QBrush(QColor(255/4.0,160,50,150)));
/**/
    yAxis->setRange(-150, 150);
    xAxis->setRange(0, _dataSize);
    //yAxis->setNumberPrecision(3); // makes sure "1*10^4" is displayed only as "10^4"
/**/
    //yAxis->grid()->setSubGridVisible(true);
    //xAxis->grid()->setSubGridVisible(true);

    //xAxis->setScaleType(QCPAxis::stLogarithmic);
    //xAxis->setScaleLogBase(10);
    //xAxis->setNumberFormat("b"); // e = exponential, b = beautiful decimal powers
    //xAxis->setNumberPrecision(0); // makes sure "1*10^4" is displayed only as "10^4"
    //xAxis->setSubTickCount(8);
/**/
    setInteraction(QCP::iRangeDrag, true);
    setInteraction(QCP::iRangeZoom, true);
    axisRect()->setRangeZoom(Qt::Vertical);
    setBackground(Qt::lightGray);
    axisRect()->setBackground(Qt::white);
    replot();
    connect(this, SIGNAL(mouseWheel(QWheelEvent*)), this, SLOT(on_mouseWheel(QWheelEvent*)));
}

void Spectrogram::on_NewData(int16_t *data, int size)
{
    Q_UNUSED(size)

    double sum = 0.0, signal = 0.0;//, rauschen = 0.0;
    float magnitude = 0.0;
/*
    kiss_fftr_cfg fftcfg = kiss_fftr_alloc(SAMPLES, 0, NULL, NULL);

    //fill cin array
    kiss_fft_scalar in[SAMPLES];
    kiss_fft_cpx cout[SAMPLES];
    for (int i = 0; i < SAMPLES; i++){
        in[i] = (uint16_t)data[i];//

    }

    kiss_fftr(fftcfg, in, cout);
    free(fftcfg);
*/
/*    for (int i = 0; i < SAMPLES; i++){
        //printf(" in[%2zu] = %+f    ", i, in[i]);
       // if (i < SAMPLES / 2 + 1)
         //   printf("out[%2zu] = %+f , %+f", i, cout[i].r, cout[i].i);
        //printf("\n");
    }
*/

    //rauschen = sum - signal;
    //qDebug() << magnitude <<  (signal / rauschen);
    // optional, as QFile destructor will already do it:
/*
    for (int i = 0; i < SAMPLES/2; i++){
        float re = cout[i].r*SAMPLES;
        float im = cout[i].i*SAMPLES;

        if(i > 0)
            _data[i] = sqrtf(re*re+im*im)/(SAMPLES/2);
        else
            _data[i] = sqrtf(re*re+im*im)/SAMPLES;

        magnitude = (double)sqrt(cout[i].r*cout[i].r+cout[i].i*cout[i].i); //10*log (S/N)
        _data[i] = 20 * log10(2 * magnitude / SAMPLES);
        //out << data[i] << "\t" << _frequency[i] << "\t" << _data[i] << "\t" << cout[i].r*1000 << "\t" << cout[i].i*1000 << "\n";
       // qDebug() << _frequency[i] << "kHz" << (int)round(data[i]) << data[i] << static_cast<int>(data[i]);
        sum += _data[i];
        if(i == 32 || 31 || 33) {
            signal = _data[i];
            sum -= signal;
        }
    }
*/
     ofstream file ("D://out.txt");

    for (uint32_t i = 0; i < _dataSize; i++){
        _data[i] = (double)data[i];// usdDevice::valueToVolt(data[i]); //2000 mV/2^14bit und dann durch gain von 20
        file<<data[i]<<"\n";
    }
    file.close();
    graph(0)->setData(_frequency, _data);
    replot();
    emit graphChanged();
}


void Spectrogram::on_SampleFreqChanged(quint32 divider)
{
    switch(divider){
    case 2000000:
        _SampleFreq = 16000 / _dataSize;
        xAxis->setRange(0, 8000);
        break;
    case 4000000:
        _SampleFreq = 32000 / _dataSize;
        xAxis->setRange(0, 16000);
        break;
    case 8000000:
        _SampleFreq = 64000 / _dataSize;
        xAxis->setRange(0, 32000);
        break;
    }
    for (uint32_t i = 0; i < _dataSize; i++){
        _frequency[i] = (double)i * _SampleFreq;
    }
}

void Spectrogram::on_mouseWheel(QWheelEvent *event)
{
    (QApplication::keyboardModifiers() && Qt::ControlModifier) ?
        axisRect()->setRangeZoom(Qt::Horizontal) : axisRect()->setRangeZoom(Qt::Vertical);
    event->isAccepted();
}
