#include "qtBSmain.h"
#include "ui_qtBSmain.h"
#include <QtDebug>
#include <dbt.h>

QtBeamScannerMain::QtBeamScannerMain(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::QTbsMain)
{

    ui->setupUi(this);
//    msgBox.setText("ERROR");

    // QCP //////////////////////////////////////////////////////////////////
    // generate some data:
    time.resize(PLOT_SAMPLES);
    data.resize(PLOT_SAMPLES);
    for (int i = 0; i < PLOT_SAMPLES; i++){
        time[i] = i;
        data[i] = (int)(i/10);
    }
    // create graph and assign data to it:
    ui->customPlot->addGraph();
    ui->customPlot->graph(0)->setData(time,data);
    // give the axes some labels:
    ui->customPlot->xAxis->setLabel("x");
    ui->customPlot->yAxis->setLabel("y");
    // set axes ranges, so we see all data:
    ui->customPlot->xAxis->setRange(0, PLOT_SAMPLES);
    ui->customPlot->yAxis->setRange(-5, PLOT_SAMPLES/10);
    ui->customPlot->replot();

    ui->customPlot->setInteractions(QCP::iRangeDrag | QCP::iRangeZoom);//, true);
//    ui->customPlot->setInteraction(QCP::iRangeZoom, true);
    ui->customPlot->axisRect()->setRangeZoom(Qt::Vertical);

    // Register for device connect notification
    DEV_BROADCAST_DEVICEINTERFACE devInt;
    ZeroMemory( &devInt, sizeof(devInt) );
    devInt.dbcc_size        = sizeof(DEV_BROADCAST_DEVICEINTERFACE);
    devInt.dbcc_devicetype  = DBT_DEVTYP_DEVICEINTERFACE;
    devInt.dbcc_classguid   = GUID_DEVINTERFACE;
    //
    HDEVNOTIFY m_hDeviceNotify =
            RegisterDeviceNotification((HANDLE)winId(),&devInt, DEVICE_NOTIFY_WINDOW_HANDLE );
    //
    if(m_hDeviceNotify == NULL)
    {
        qDebug() << "Error: Failed to register device notification!";
        qApp->quit();
    }

    device = new BeamScannerHW(this);
    dev = new USD(this);
    dop = new UltrasonicDoppler(this);

    connect(ui->btnList, SIGNAL(clicked()), SLOT(on_btnList()));
    connect(ui->btnConnect, SIGNAL(clicked()), SLOT(on_btnConnect()));
    connect(ui->btnDisconnect, SIGNAL(clicked()), SLOT(on_btnDisconnect()));
    connect(ui->btnSendCtrl, SIGNAL(clicked()), SLOT(on_btnSendCtrl()));
    connect(ui->btnRunDevice, SIGNAL(clicked()), SLOT(on_btnRunDevice()));
    connect(ui->btnRdData, SIGNAL(clicked()), SLOT(on_btnRdData()));
    connect(ui->btnWrData, SIGNAL(clicked()), SLOT(on_btnWrData()));




}

//------------------------------------------------------------------------------
QtBeamScannerMain::~QtBeamScannerMain(){
    delete device;
    dev->Disconnect();
    delete dev;
    delete ui;
}

bool QtBeamScannerMain::nativeEvent(const QByteArray& eventType, MSG *msg, long *result){
    Q_UNUSED( eventType );
    Q_UNUSED( result );
    if(msg->message == WM_DEVICECHANGE){
        switch(msg->wParam){
        case DBT_DEVICEARRIVAL:
            qDebug() << "wuhu!!!";
            //getDriveLetterFromMsg(msg);
            //getMoreDriveInfosFromLetter(DriveLetter);
        break;

        case DBT_DEVICEREMOVECOMPLETE:
        qDebug() << "disco disco..";
        //getDriveLetterFromMsg(msg);
        break;
        }
    }
    return false;
}

//------------------------------------------------------------------------------
void QtBeamScannerMain::on_btnList()
{
    int nDevices = device->CreateDeviceList();

    ui->tblDevices->clearContents();
    for (int i=0; i<nDevices;i++){
        ui->tblDevices->setItem(i,0,new QTableWidgetItem(QString("0x%1").arg(device->rgDeviceList[i].idVendor,4,16,(QChar)'0')));
        ui->tblDevices->setItem(i,1,new QTableWidgetItem(QString("0x%1").arg(device->rgDeviceList[i].idProduct,4,16,(QChar)'0')));
        ui->tblDevices->setItem(i,2,new QTableWidgetItem(device->rgDeviceList[i].strManufacturer));
        ui->tblDevices->setItem(i,3,new QTableWidgetItem(device->rgDeviceList[i].strProduct));
        ui->tblDevices->setItem(i,4,new QTableWidgetItem(device->rgDeviceList[i].strSerialNumber));
    }
    ui->tblDevices->resizeColumnsToContents();
}

//------------------------------------------------------------------------------
void QtBeamScannerMain::on_btnConnect()
{
    bool result = 0;
    result = device->Connect(ui->tblDevices->currentRow());

    /*NEW*/
    //result = dev->Connect();
    if (result == true)
    {
        dev->_devHandle = device->hDevice;
        ui->conStatus->setText("connected");
        qApp->processEvents();      // prompt updating of GUI
 //       Sleep(1000);
        ui->tabWidget->setCurrentWidget(ui->tabControl);
        ui->btnRunDevice->setDisabled(true);
    }
}

//------------------------------------------------------------------------------
void QtBeamScannerMain::on_btnDisconnect()
{
    bool result = 0;

    result = device->Disconnect();
    /*NEW*/
    //result = dev->Disconnect();
    if (result == true)
        ui->conStatus->setText("disconnected");


}

//------------------------------------------------------------------------------
void QtBeamScannerMain::on_btnSendCtrl(){
//    this->Disable(); ###TODO###
    SCANNERCONFIG Config;
    if (ui->btnRunDevice->text() == "STOP"){
        this->on_btnRunDevice();
    }
    Config.frequency = (ui->rbtn2MHz->isChecked()) ? 2 : (ui->rbtn4MHz->isChecked()) ? 4 : (ui->rbtn8MHz->isChecked()) ? 8 : 0;
    Config.PRF = 1000*ui->spbPRFkHz->value() + ui->spbPRFHz->value();
    Config.burst = ui->spbBurst->value();
    Config.sample = ui->spbSample->value();
    Config.depht = ui->spbDepht->value();

    if(device->Control(&Config) == false){
        QMessageBox msgBox;
        msgBox.setText("Parameter & Device Control failed");
        msgBox.setIcon(QMessageBox::Critical);
        msgBox.setInformativeText("Please check connection or change Parameters to correct values!");
        ui->btnRunDevice->setDisabled(true);
        msgBox.exec();
        //throw(0);
    }
    else {
        //QMessageBox msgBox;
        //msgBox.setIcon(QMessageBox::Warning);
        //msgBox.setText("Parameter Control OK");
        //msgBox.setInformativeText("To run device please press START");
        ui->btnRunDevice->setEnabled(true);
        //msgBox.exec();

    }
//    msgBox.setInformativeText("bulk error");
//    msgBox.exec();
//    this->Enable();
}

//------------------------------------------------------------------------------
void QtBeamScannerMain::on_btnRunDevice()
{
    if (ui->btnRunDevice->text() == "START"){
        if (device->Start()){
            ui->btnRunDevice->setText("STOP");
//            ui->tabWidget->setCurrentWidget(ui->tabData);
        }
    }
    else {
        if (device->Stop()){
//            if (device->DeactivateDataMonitoring()){
//                ui->btnData->setText("Read Data");
                ui->btnRunDevice->setText("START");
//            }
        }
    }
}


//------------------------------------------------------------------------------
void QtBeamScannerMain::on_btnRdData()
{
    //dev->SingleShot((unsigned char*)scanData,PLOT_SAMPLES*2);
    device->NewScan((unsigned char*)scanData,PLOT_SAMPLES*2);

    for(int i = 0; i< PLOT_SAMPLES; i++){
        data[i] = scanData[i];
    }
    ui->customPlot->graph(0)->setData(time, data);
    ui->customPlot->replot();
}

//------------------------------------------------------------------------------
void QtBeamScannerMain::on_btnWrData()
{
    device->WriteTest();
}

