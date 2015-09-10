#ifndef SPECTROGRAM_H
#define SPECTROGRAM_H

#include <QWidget>
#include "libs/QCPlib/qcustomplot.h"
#include "libs/kiss_fft/kiss_fftr.h"

class Spectrogram : public QCustomPlot
{
    Q_OBJECT
public:
    explicit Spectrogram(uint32_t dataSize, QCustomPlot *parent = 0);
    Spectrogram* spectrogram()       { return this; }

signals:
    void graphChanged(void);
public slots:
    void on_NewData(uint16_t *data, int size);
    void on_SampleFreqChanged(quint32 divider);
private slots:
    void on_mouseWheel(QWheelEvent *event);
private:
    QVector<double> _frequency, _data;
    uint32_t _dataSize;
    double _SampleFreq;
    QCPBars *fft = new QCPBars(xAxis, yAxis);
};

#endif // SPECTROGRAM_H
