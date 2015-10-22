#ifndef QTDOPMAIN_H
#define QTDOPMAIN_H

#include <QMainWindow>
#include <qwt_plot.h>
#include <qwt_plot_curve.h>
#include <math.h>
#include "digidophw.h"
#include <QMessageBox>

#define PLOT_SAMPLES    500

namespace Ui {
    class QTdopMain;
}

class QTdopMain : public QMainWindow
{
    Q_OBJECT

public:
    explicit QTdopMain(QWidget *parent = 0);
    ~QTdopMain();

private slots:

    void on_btnList_clicked();

    void on_btnConnect_clicked();

    void on_btnDisconnect_clicked();

    void on_btnSendCtrl_clicked();

    void on_btnRunDevice_clicked();

    void on_btnData_clicked();

    void on_NewDataSignal(int32_t* SV1I, int32_t* SV1Q, int32_t* SV2I, int32_t* SV2Q);

private:
    Ui::QTdopMain *ui;
    DigiDopHW *device;                          // hardware class

    double timeAxis[PLOT_SAMPLES];
    double dataSV1I[PLOT_SAMPLES];
    double dataSV1Q[PLOT_SAMPLES];
    double dataSV2I[PLOT_SAMPLES];
    double dataSV2Q[PLOT_SAMPLES];

    QwtPlot *pltData1;
    QwtPlot *pltData2;
    QwtPlot *pltData3;
    QwtPlot *pltData4;

    QwtPlotCurve *crvData1;
    QwtPlotCurve *crvData2;
    QwtPlotCurve *crvData3;
    QwtPlotCurve *crvData4;

    unsigned int callcnt_plot;
};

#endif // QTDOPMAIN_H
