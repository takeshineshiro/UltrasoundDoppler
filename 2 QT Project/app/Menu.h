#ifndef USDAPP_H
#define USDAPP_H

#include <QObject>
#include <QToolBar>
#include <QMenu>
#include <QAction>
#include <QtCore>
#include <QComboBox>
#include <QLabel>
#include <QSpinBox>
#include <QGroupBox>
#include <QDockWidget>
#include <QString>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QSlider>


#include "stringextentions.h"
#include "usdmodel.h"
#include "mmode.h"
#include "spectrogram.h"

#define LBL_PRF                 "PRF:"
#define TOOLTIP_PRF             "Selected pulse repetition frequency"
#define TOOLTIP_BURST           "Selected Burst rate"
#define LBL_BURSTRATE           "Burst Rate:"
#define LBL_CAPUTURE_TRUE       "Run"
#define LBL_CAPUTURE_FALSE      "Stop"
#define TOOLTIP_CAPUTURE_FALSE  "disable continuous caputuring"
#define TOOLTIP_CAPUTURE_TRUE   "start continuous caputuring"
#define LBL_SINGLESHOT          "Singleshot"
#define TOOLTIP_SINGLESHOT      "single capture over 1 buffer"
#define LBL_START_BURST         "Burst waves"
#define TOOLTIP_START_BURST     "select Burst waves for ultrasonic probe"
#define LBL_START_SAMPLE        "Start depth"
#define TOOLTIP_START_SAMPLE    "select start depth in mm"
#define LBL_END_SAMPLE          "End depth"
#define TOOLTIP_END_SAMPLE      "select start depth in mm"
//#define LBL_END_SAMPLE          "Values"
//#define TOOLTIP_END_SAMPLE      "select the amount of values "
#define LBL_GATE                "Gate Length:"
#define TOOLTIP_GATE            "CoreClock/(value+2)"
#define LBL_SAMPLEVOLUMES       "Samplevolume Length:"
#define TOOLTIP_SV              "Define number of Gates in 1 Sample Volume"



#define QUOTE(x) QT_TR_NOOP(x)

using namespace USB;

class Menu : public QObject
{
    Q_OBJECT
public:
    explicit Menu(QWidget* uiContext, QObject *parent = 0);
    ~Menu();

    QMenu* menu()                   { return _menu; }
    QToolBar* toolBar()             { return _toolbar; }
    QDockWidget* settings()         { return _settings; }
    QString currentDeviceName(void) { return device->name(); }
    Mmode* mmodeGraph(void)         { return _mmode; }
    Spectrogram* spectromGraph(void) { return _spectro; }

    usdDevice* device;

    void SetupStart();
    void setupGate();
    void setupSV();
public slots:
    void burstRateChanged(int index);
    void prfRateChanged(int index);
    void handleDeviceChanged(usbDevice *activeDevice);
    void debug(const char*msg);
    void modeChanged(void);
    void readyforData(void);
    void initSingleShot(void);
    void setDeepth(quint16 value);

    void rxChanged(void);
    void txChanged(void);
    void resetDevice(void);

private:
    QDockWidget *_settings;
    QWidget* _ctx;
    QMenu* _menu;
    QToolBar* _toolbar;
    QComboBox* _burstRateBox;
    QComboBox* _prfRateBox;
    QSpinBox* _burstStart;
    QSpinBox* _burstStop;
    QSpinBox* _sampleStart;
    QSpinBox* _sampleStop;
    Mmode*  _mmode;
    Spectrogram* _spectro;

    QPushButton* _changeRunMode;
    QPushButton* _singleShot;
    QPushButton* _rxOn;
    QPushButton* _txOn;
    QAction* _action_changeRunMode;
    QAction* _action_singleShot;
    QSlider* _gateslider;
    QSlider* _svslider;
    QSpinBox* _gatespinner;
    QSpinBox* _svspinner;

    QSlider* _startslider;
    QSpinBox* _startspinner;
    QLabel* _deepth;

    void createMenu(void);
    void setActions(bool enable);
    void createToolBar(void);
    void setupValues(usdDevice* device);


};

#endif // USDAPP_H
