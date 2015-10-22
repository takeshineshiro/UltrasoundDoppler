#include "qtdopmain.h"
#include "ui_qtdopmain.h"


QTdopMain::QTdopMain(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::QTdopMain)
{

    ui->setupUi(this);



/*//QWT PLOT  ////////////////////////////////////////////////////////////////*/

    pltData1 = new QwtPlot();
    pltData2 = new QwtPlot();
    pltData3 = new QwtPlot();
    pltData4 = new QwtPlot();

    ui->Data1->addWidget(pltData1);
    ui->Data2->addWidget(pltData2);
    ui->Data3->addWidget(pltData3);
    ui->Data4->addWidget(pltData4);

    pltData1->setTitle(QString::fromUtf8("Sample Volume 1 InPhase"));
    pltData2->setTitle(QString::fromUtf8("Sample Volume 1 QuadraturePhase"));
    pltData3->setTitle(QString::fromUtf8("Sample Volume 2 InPhase"));
    pltData4->setTitle(QString::fromUtf8("Sample Volume 2 QuadraturePhase"));


//    pltData1->setAxisScale(QwtPlot::yLeft,0, 70000,5000);   // kein auto-scrolling, Axe mit fixen Werten
//    pltData2->setAxisScale(QwtPlot::yLeft,0, 70000,5000);
//    pltData3->setAxisScale(QwtPlot::yLeft,-10e+6, 10e+6,10e+5);
//    pltData4->setAxisScale(QwtPlot::yLeft,0, 70000,5000);

    pltData1->setAxisTitle(QwtPlot::xBottom,"Samples");
    pltData2->setAxisTitle(QwtPlot::xBottom,"Samples");
    pltData3->setAxisTitle(QwtPlot::xBottom,"Samples");
    pltData4->setAxisTitle(QwtPlot::xBottom,"Samples");

    pltData1->setAxisTitle(QwtPlot::yLeft,"Amplitude");
    pltData2->setAxisTitle(QwtPlot::yLeft,"Amplitude");
    pltData3->setAxisTitle(QwtPlot::yLeft,"Amplitude");
    pltData4->setAxisTitle(QwtPlot::yLeft,"Amplitude");

    crvData1 = new QwtPlotCurve();
    crvData2 = new QwtPlotCurve();
    crvData3 = new QwtPlotCurve();
    crvData4 = new QwtPlotCurve();

    crvData1->attach(pltData1);
    crvData2->attach(pltData2);
    crvData3->attach(pltData3);
    crvData4->attach(pltData4);



    for (int i = 0; i < PLOT_SAMPLES; i++)
    {
        timeAxis[i] = i;
    }

    device = new DigiDopHW(this);
    connect(device,SIGNAL(sigNewSVData(int32_t*,
                                       int32_t*,
                                       int32_t*,
                                       int32_t*)),this, SLOT(on_NewDataSignal(int32_t*,
                                                                              int32_t*,
                                                                              int32_t*,
                                                                              int32_t*)));
    callcnt_plot = 0;
}

QTdopMain::~QTdopMain()
{
    delete device;
    delete ui;
}


void QTdopMain::on_btnList_clicked()
{
    int nDevices = device->CreateDeviceList();

    ui->tblDevices->clearContents();
    for (int i=0; i<nDevices;i++){
        ui->tblDevices->setItem(i,0,new QTableWidgetItem(QString("0x%1").arg(device->rgDeviceList[i].idVendor,4,16,(QChar)'0')));
        ui->tblDevices->setItem(i,1,new QTableWidgetItem(QString("0x%1").arg(device->rgDeviceList[i].idProduct,4,16,(QChar)'0')));
        ui->tblDevices->setItem(i,2,new QTableWidgetItem(QString((const char*)device->rgDeviceList[i].strManufacturer)));
        ui->tblDevices->setItem(i,3,new QTableWidgetItem(QString((const char*)device->rgDeviceList[i].strProduct)));
        ui->tblDevices->setItem(i,4,new QTableWidgetItem(QString((const char*)device->rgDeviceList[i].strSerialNumber)));
    }
    ui->tblDevices->resizeColumnsToContents();
}

void QTdopMain::on_btnConnect_clicked()
{
    bool result = 0;
    result = device->Connect(ui->tblDevices->currentRow());

    if (result == true)
    {
        ui->conStatus->setText("connected");
        qApp->processEvents();      // prompt updating of GUI
        Sleep(1000);
        ui->tabWidget->setCurrentWidget(ui->tabControl);
        ui->btnRunDevice->setDisabled(TRUE);
    }
}

void QTdopMain::on_btnDisconnect_clicked()
{
    bool result = 0;

    result = device->Disconnect();
    if (result == true)
        ui->conStatus->setText("disconnected");


}

void QTdopMain::on_btnSendCtrl_clicked()
{
    DOP_CTRL dopParam = {0,0,0,0,0,0,0,0};

//    this->Disable(); ###TODO###

    if (ui->btnRunDevice->text() == "STOP"){
        this->on_btnRunDevice_clicked();
    }

    if (ui->rbtn2MHz->isChecked()) dopParam.dopFrequency  = 2;
    else if (ui->rbtn4MHz->isChecked()) dopParam.dopFrequency  = 4;
    else if (ui->rbtn8MHz->isChecked()) dopParam.dopFrequency  = 8;
    else dopParam.dopFrequency  = 0;

    dopParam.PRF = 1000*ui->spbPRFkHz->value() + ui->spbPRFHz->value();
    dopParam.BurstS = 0;
    dopParam.BurstE = ui->spbBurstVolume->value() + dopParam.BurstS;


    dopParam.SampleV1S =ui->spbPosSv1->value();
    dopParam.SampleV2S =ui->spbPosSv2->value();
    dopParam.SampleV1E =ui->spbPosSv1->value() + ui->spbSizeSv1->value();
    dopParam.SampleV2E =ui->spbPosSv2->value() + ui->spbSizeSv2->value();

    if (!device->Control(&dopParam)){
        QMessageBox msgBox;
        msgBox.setText("Parameter & Device Control failed");
        msgBox.setIcon(QMessageBox::Critical);
        msgBox.setInformativeText("Please check connection or change Parameters to correct values!");
        ui->btnRunDevice->setDisabled(TRUE);
        msgBox.exec();
        //throw(0);
    }
    else {
        //QMessageBox msgBox;
        //msgBox.setIcon(QMessageBox::Warning);
        //msgBox.setText("Parameter Control OK");
        //msgBox.setInformativeText("To run device please press START");
        ui->btnRunDevice->setEnabled(TRUE);
        //msgBox.exec();

    }
//    this->Enable();
}

void QTdopMain::on_btnRunDevice_clicked()
{
    if (ui->btnRunDevice->text() == "START"){
        if (device->Start()){
            ui->btnRunDevice->setText("STOP");
            ui->tabWidget->setCurrentWidget(ui->tabData);
        }//else throw(0);
    }
    else {
        if (device->Stop()){
            if (device->DeactivateDataMonitoring()){
                ui->btnData->setText("Read Data");
                ui->btnRunDevice->setText("START");
            }
        }//else throw(0);
    }
}


void QTdopMain::on_btnData_clicked()
{
    if (ui->btnData->text() == "Read Data" )
    {
        if (device->ActivateDataMonitoring())
            ui->btnData->setText("STOP");
    }
    else
    {
        if (device->DeactivateDataMonitoring())
            ui->btnData->setText("Read Data");
    }
}


void QTdopMain::on_NewDataSignal(int32_t* SV1I, int32_t* SV1Q, int32_t* SV2I, int32_t* SV2Q)
{

    for (int i = 0; i < PLOT_SAMPLES; i++)
    {
      dataSV1I[i] = *(SV1I + i);
      dataSV1Q[i] = *(SV1Q + i);
      dataSV2I[i] = *(SV2I + i);
      dataSV2Q[i] = *(SV2Q + i);
    }

//timeAxis[i] = i;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//PLOT1
        // SV 1 InPhase

    callcnt_plot++;

   crvData1->setRawSamples(&timeAxis[0],&dataSV1I[0],PLOT_SAMPLES);
   pltData1->replot();

 //  ui->lbCntPlot->setText(QString("Zähler: %1").arg(callcnt_plot));
 //  qApp->processEvents();

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//PLOT2
        //SV 1 QuadraturePhase



    crvData2->setRawSamples(&timeAxis[0],&dataSV1Q[0],PLOT_SAMPLES);
    pltData2->replot();



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////PLOT3
//        //SV 2 InPhase


    crvData3->setRawSamples(&timeAxis[0],&dataSV2I[0],PLOT_SAMPLES);
    pltData3->replot();


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////PLOT4
//        //SV 2 QuadraturePhase


    crvData4->setRawSamples(&timeAxis[0],&dataSV2Q[0],PLOT_SAMPLES);
    pltData4->replot();

}
