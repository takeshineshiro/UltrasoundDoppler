#ifndef MMODE_H
#define MMODE_H


#include <QWidget>
#include "usdmodel.h"
#include <QtMath>
#include "libs/QCPlib/qcustomplot.h"

class Mmode : public QCustomPlot
{
    Q_OBJECT
public:
    explicit Mmode(QCustomPlot *parent = 0);
    Mmode* mmode()       { return this; }

    void plot();
signals:
    void graphChanged(void);
public slots:
    void on_NewData(int32_t *data, int size);
private slots:
    void on_mouseWheel(QWheelEvent *event);
private:
    QVector<double> _time, _dataRe, _dataIm, _data2Re, _data2Im;
    void fill_Time(int size);
};

#endif // MMODE_H
