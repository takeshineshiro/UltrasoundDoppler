#include "Menu.h"

Menu::Menu(QWidget *uiContext, QObject *parent) :
    QObject(parent)
{
    _ctx = uiContext;
    _mmode = new Mmode(SAMPLES);
    _spectro = new Spectrogram(SAMPLES);
    device = new usdDevice(this);
    QObject::connect(device, SIGNAL(availableStatusChanged(usbDevice*)), this, SLOT(handleDeviceChanged(usbDevice*)));
    connect(device, SIGNAL(connectionMessageChanged(const char*)), this, SLOT(debug(const char*)));
    _menu = NULL;
    createMenu();
    createToolBar();
    setActions(false);

    //connect(device, SIGNAL(frequencyChanged(quint32)), _spectro, SLOT(on_SampleFreqChanged(quint32)));
    connect(device, SIGNAL(NewData(uint16_t*,int)), _spectro, SLOT(on_NewData(uint16_t*,int)));
    //connect(device, SIGNAL(NewData(int32_t*,int)), _mmode, SLOT(on_NewData(int32_t*,int)));
    connect(_mmode,   SIGNAL(graphChanged()), this, SLOT(readyforData()));
    connect(_spectro, SIGNAL(graphChanged()), this, SLOT(readyforData()));
#ifdef QT_DEBUG
    connect(device, SIGNAL(connectionMessageChanged(const char*)), SLOT(debug(const char*)));
#endif

    this->menu()->setToolTipsVisible(true);
    setActions(false);
}

Menu::~Menu()
{
    delete device;
    device = NULL;
}

void Menu::modeChanged(void)
{
    //disconnect(device, SIGNAL(NewData(int32_t*,int)), _mmode, SLOT(on_NewData(int32_t*,int)));
    //disconnect(device, SIGNAL(NewData(int16_t*,int)), _mmode, SLOT(on_NewData(int16_t*,int)));
    //connect(device, SIGNAL(NewData(int32_t*,int)), _mmode, SLOT(on_NewData(int32_t*,int)));
    switch(device->mode()){
        case usdDevice::Mode::Run:
            _changeRunMode->setText(QUOTE(LBL_CAPUTURE_TRUE));
            _action_changeRunMode->setText(QUOTE(LBL_CAPUTURE_TRUE));
            _action_changeRunMode->setToolTip(QUOTE(TOOLTIP_CAPUTURE_TRUE));
            _changeRunMode->setToolTip(QUOTE(TOOLTIP_CAPUTURE_TRUE));
            device->setMode(usdDevice::Mode::Stop);
        break;
        case usdDevice::Mode::Stop:
            _changeRunMode->setText(QUOTE(LBL_CAPUTURE_FALSE));
            _action_changeRunMode->setText(QUOTE(LBL_CAPUTURE_FALSE));
            _action_changeRunMode->setToolTip(QUOTE(TOOLTIP_CAPUTURE_FALSE));
            _changeRunMode->setToolTip(QUOTE(TOOLTIP_CAPUTURE_FALSE));
            device->setMode(usdDevice::Mode::Run);
        break;
    }
}

void Menu::readyforData()
{
    if(device->mode() == usdDevice::Mode::Run)
        device->on_ModeChanged(device->mode());
}

void Menu::initSingleShot()
{
    if(device->transmitter() == 1){
        device->settransmitter(0);
        _singleShot->setText("Deactive");
    }
    else{
        device->settransmitter(1);
        _singleShot->setText("Active");
    }
}

void Menu::setDeepth(quint16 value)
{
    _deepth->setText(QString("Tiefe: %1 mm").arg(value));
}



void Menu::burstRateChanged(int index)
{
    int rate = _burstRateBox->itemData(index).toInt();
    device->setFrequency(rate);
    qDebug() << rate;
}

void Menu::prfRateChanged(int index)
{
    int rate = _prfRateBox->itemData(index).toInt();
    device->setPrf(rate);
    qDebug() << rate;
}

void Menu::handleDeviceChanged(usbDevice *activeDevice)
{
    setupValues((usdDevice*)activeDevice);
}

void Menu::debug(const char * msg)
{
    qDebug() << msg;
}

void Menu::createMenu()
{
    _menu = new QMenu(tr("&Ultrasonic Doppler"));
    _menu->setObjectName(QString::fromUtf8("DeviceMenu"));

    _action_changeRunMode = new QAction(QUOTE(LBL_CAPUTURE_TRUE), this);
    _action_changeRunMode->setToolTip(QUOTE(TOOLTIP_CAPUTURE_FALSE));
    connect(_action_changeRunMode, SIGNAL(triggered()), this, SLOT(modeChanged()));
    _menu->addAction(_action_changeRunMode);

    _action_singleShot = new QAction(QUOTE(LBL_SINGLESHOT), this);
    _action_singleShot->setToolTip(QUOTE(TOOLTIP_SINGLESHOT));
   connect(_action_singleShot, SIGNAL(triggered()), this, SLOT(initSingleShot()));
   _menu->addAction(_action_singleShot);

   _menu->addSeparator();
}

void Menu::setActions(bool enable)
{
    _prfRateBox->setDisabled(enable);
    _burstRateBox->setDisabled(enable);
    _changeRunMode->setDisabled(enable);
    _singleShot->setDisabled(enable);
    _action_changeRunMode->setDisabled(enable);
    _action_singleShot->setDisabled(enable);
    _gateslider->setDisabled(enable);
    _gatespinner->setDisabled(enable);
    _svslider->setDisabled(enable);
    _svspinner->setDisabled(enable);
}

void Menu::SetupStart()
{
    _startslider = new QSlider(Qt::Horizontal);
    _startslider->setToolTip(QUOTE(TOOLTIP_START_SAMPLE));
    _startspinner = new QSpinBox;
    _startspinner->setToolTip(QUOTE(TOOLTIP_START_SAMPLE));
    _startslider->setRange(101,3600);
    _startspinner->setRange(101,3600);
    //_startspinner->setSuffix(" mm");
    QObject::connect(_startslider, &QAbstractSlider::valueChanged, device, &usdDevice::setSample);
    QObject::connect(_startslider, SIGNAL(valueChanged(int)), _startspinner, SLOT(setValue(int)));
    QObject::connect(_startspinner, SIGNAL(valueChanged(int)), _startslider, SLOT(setValue(int)));
    _startslider->setValue(3000);
}

void Menu::setupGate()
{
    _gateslider = new QSlider(Qt::Horizontal);
    _gateslider->setToolTip(QUOTE(TOOLTIP_GATE));
    _gatespinner = new QSpinBox;
    _gateslider->setToolTip(QUOTE(TOOLTIP_GATE));
    _gateslider->setRange(0,5);
    _gatespinner->setRange(0,5);
    QObject::connect(_gateslider, &QAbstractSlider::valueChanged, device, &usdDevice::setGateLength);
    QObject::connect(_gateslider, SIGNAL(valueChanged(int)), _gatespinner, SLOT(setValue(int)));
    QObject::connect(_gatespinner, SIGNAL(valueChanged(int)), _gateslider, SLOT(setValue(int)));
    _gateslider->setValue(device->gateLength());
}

void Menu::setupSV()
{
    _svslider = new QSlider(Qt::Horizontal);
    _svslider->setToolTip(QUOTE(TOOLTIP_SV));
    _svspinner = new QSpinBox;
    _svspinner->setToolTip(QUOTE(TOOLTIP_SV));
    _svslider->setRange(1,140);
    _svspinner->setRange(1,140);
    //_startspinner->setSuffix(" µs");
    QObject::connect(_svslider, &QAbstractSlider::valueChanged, device, &usdDevice::setSvLength);
    QObject::connect(_svslider, SIGNAL(valueChanged(int)), _svspinner, SLOT(setValue(int)));
    QObject::connect(_svspinner, SIGNAL(valueChanged(int)), _svslider, SLOT(setValue(int)));
    _svslider->setValue(2);
}

void Menu::createToolBar()
{
    _prfRateBox = new QComboBox();
    _prfRateBox->setToolTip(QUOTE(TOOLTIP_PRF));
    //_prfRateBox->setFixedWidth(75);
    QObject::connect(_prfRateBox, SIGNAL(currentIndexChanged(int)), this, SLOT(prfRateChanged(int)));

    _burstRateBox = new QComboBox();
    _burstRateBox->setToolTip(QUOTE(TOOLTIP_BURST));
    //_burstRateBox->setFixedWidth(75);
    QObject::connect(_burstRateBox, SIGNAL(currentIndexChanged(int)), this, SLOT(burstRateChanged(int)));

    QGroupBox* groupBox = new QGroupBox();

    QVBoxLayout* vbox = new QVBoxLayout;
    vbox->addWidget(new QLabel(QUOTE(LBL_PRF)));
    vbox->addWidget(_prfRateBox);
    vbox->addWidget(new QLabel(QUOTE(LBL_BURSTRATE)));
    vbox->addWidget(_burstRateBox);

    //start
    SetupStart();

    QHBoxLayout *start = new QHBoxLayout;
    start->addWidget(_startslider);
    start->addWidget(_startspinner);
    QGroupBox* startBox = new QGroupBox();
    vbox->addWidget(new QLabel(QUOTE(LBL_START_SAMPLE)));
    startBox->setLayout(start);
    vbox->addWidget(startBox);

    //gatelength
    setupGate();
    QHBoxLayout *gate = new QHBoxLayout;
    gate->addWidget(_gateslider);
    gate->addWidget(_gatespinner);
    QGroupBox* gateBox = new QGroupBox();
    vbox->addWidget(new QLabel(QUOTE(LBL_GATE)));
    gateBox->setLayout(gate);
    vbox->addWidget(gateBox);

    //sampleVolume length
    setupSV();
    QHBoxLayout *sv = new QHBoxLayout;
    sv->addWidget(_svslider);
    sv->addWidget(_svspinner);
    QGroupBox* svBox = new QGroupBox();
    vbox->addWidget(new QLabel(QUOTE(LBL_SAMPLEVOLUMES)));
    svBox->setLayout(sv);
    vbox->addWidget(svBox);

    _deepth = new QLabel();
    _deepth->setText(QString("Tiefe: "));
    connect(device, SIGNAL(depthChanged(quint16)), this, SLOT(setDeepth(quint16)));
    vbox->addWidget(_deepth);


    //Doppler & OSZI mode
    _changeRunMode = new QPushButton(QUOTE(LBL_CAPUTURE_TRUE));
    QObject::connect(_changeRunMode, SIGNAL(clicked()), this, SLOT(modeChanged()));
    vbox->addWidget(_changeRunMode);
    _singleShot = new QPushButton(QUOTE(LBL_SINGLESHOT));
    QObject::connect(_singleShot, SIGNAL(clicked()), this, SLOT(initSingleShot()));
    vbox->addWidget(_singleShot);

    vbox->addStretch(1);
    groupBox->setLayout(vbox);

    _settings = new QDockWidget(tr("Settings"));
    _settings->setObjectName("SettingsDockWidget");
    _settings->setWidget(groupBox);
    _settings->setAllowedAreas(Qt::LeftDockWidgetArea | Qt::RightDockWidgetArea);

    //_toolbar = new QToolBar(tr("USD toolbar"), _ctx);
    //_toolbar->setObjectName(QString::fromUtf8("usdtoolbar"));


    /*
    _toolbar->addWidget(new QLabel(tr("Burst Rate: ")));
    _toolbar->addWidget(_burstRateBox);
    _toolbar->addSeparator();
    _toolbar->setAllowedAreas(Qt::AllToolBarAreas);
*/

}

void Menu::setupValues(usdDevice *device)
{
    if(device->Isconnected()){
        _prfRateBox->clear();
        _burstRateBox->clear();

        QList<int> prfRates = device->supportedPRFRates();
        for(int i = 0; i < prfRates.size(); i++){
            _prfRateBox->addItem(StringExtentions::frequencyToString(prfRates.at(i)),
                                 QVariant(prfRates.at(i)));
        }

        QList<int> burstRates = device->supportedBurstFrequencyRates();
        for(int i = 0; i < burstRates.size(); i++){
            _burstRateBox->addItem(StringExtentions::frequencyToString(burstRates.at(i)),
                                 QVariant(burstRates.at(i)));
        }
        setActions(false);
    }
    else {
        setActions(true);
    }
}
