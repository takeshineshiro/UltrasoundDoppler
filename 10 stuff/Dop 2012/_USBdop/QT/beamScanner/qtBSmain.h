#ifndef QTBSMAIN_H
#define QTBSMAIN_H

#include <QMainWindow>
#include <math.h>
#include <beamScanner_hw.h>
#include <QMessageBox>
#include <QVector>
#include <libs/QCustomPlot/qcustomplot.h>
#include <usd.h>
#include <usb_api.h>

#include <windows.h>
#include <Dbt.h>
#include <SetupAPI.h>

static const GUID GUID_DEVINTERFACE =
{ 0xF70242C7, 0xFB25, 0x443B, { 0x9E, 0x7E, 0xA4, 0x26, 0x0F, 0x37, 0x39, 0x82 } };
//{ F70242C7-   FB25-   443B-     9E    7E-   A4    26    0F    37    39    82}

#define PLOT_SAMPLES  256 // 448

namespace Ui {
    class QTbsMain;
}

class QtBeamScannerMain : public QMainWindow
{
    Q_OBJECT

public:
    explicit QtBeamScannerMain(QWidget *parent = 0);
    ~QtBeamScannerMain();
protected :
    virtual bool nativeEvent(const QByteArray& , MSG* ,
                                      long* );
private slots:

    void on_btnList();

    void on_btnConnect();

    void on_btnDisconnect();

    void on_btnSendCtrl();

    void on_btnRunDevice();

    void on_btnRdData();

    void on_btnWrData();

//    void on_NewDataSignal(qint32* SV1I, qint32* SV1Q, qint32* SV2I, qint32* SV2Q);

private:
    Ui::QTbsMain *ui;
    BeamScannerHW *device;                          // hardware class
    USD *dev;
    UltrasonicDoppler *dop;
    QVector<double> time, data;
    qint16 scanData[PLOT_SAMPLES] = {0};

};

#endif // QTBSMAIN_H
