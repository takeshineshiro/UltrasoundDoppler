#ifndef BSHW_H
#define BSHW_H

#include <libs/libusbx/libusb.h>
#include <QObject>
#include <QDebug>


//** DOPPLER CTRL COMMANDS VIA REQUEST ****************************************

typedef enum
{
    BS_REQU_SET_FREQUENCY 		= 0,
        BS_REQU_SET_PRF				= 1,
        BS_REQU_SET_BURST 			= 2,
        BS_REQU_SET_SAMPLE 			= 3,
        BS_REQU_SET_DEPHT 			= 4,

        BS_REQU_SET_DATARATE 		= 5,
        BS_REQU_SET_RUN 			= 6,
        BS_REQU_SCAN 				= 7,
        BS_REQU_SET_CONFIGURATION 	= 8,
    //    BS_REQU_GET_CONFIGURATION = 9,
        BS_REQU_GET_VERSION 		= 10,
    //    BS_REQU_GET_STRVERSION 	= 11,
    //    BS_REQU_GET_ERROR 		= 12,
        USB_BS_REQUESTS 			= 13
}USB_BEAMSCANNER_REQUEST;

typedef enum
{
    VAL_RUN_STOP			= 0,
    VAL_RUN_RUN				= 1
}USB_SCANNER_VALUE;


// ####################################### doppler hardware definitions ########
//###TODO###
#define F_BASE_HW   64000000    // frequency - scaner board base frequency
#define VELOCITY    1500000     // ultrasonic sound velocity in tissue in mm/s
#define ADCDELAY    8           // ADC pipeline delay
#define TIMEOUT     100         // used by requests (ms)

//##############################################################################

struct USB_DEV{                 // USB device struct
  quint16   idVendor;
  quint16   idProduct;
  QString   strManufacturer;
  QString   strProduct;
  QString   strSerialNumber;
};

typedef struct
{
    unsigned short  frequency;
    unsigned short  PRF;        // puls repetition freq. (not used)
    unsigned short  burst;      // burst volume [nr of periods]
    unsigned short  sample;     // sample volume [nr of periods]
    unsigned short  depht;      // middle sample position [mm]
}SCANNERCONFIG;

//##############################################################################
class BeamScannerHW : public QObject
{
  Q_OBJECT

public:
    explicit BeamScannerHW(QObject *parent = 0);
    BeamScannerHW();
    ~BeamScannerHW();

    USB_DEV rgDeviceList[128];	            // ->CreateDeviceList()
    int	CreateDeviceList(void);             // creata a list of all usb devices
    bool Connect(int iDevice);              // connect a device identified by index in list above
    bool Disconnect(void);                  // disconnect the device

    bool Control(SCANNERCONFIG* mmDop);     // all settings
    bool SetFrequency(int value);           // set the scanner tranceducer freq. in [Hz] (2-4-8 MHz)
    bool SetBurst(int value);               // set the tranasmitter burst length [cycles]
    bool SetSample(int value);              // set the receiver sample length [cycles]
    bool SetDepht(int value);               // set the receiver depht [mm]

    bool Start(void);                       // start hardware
    bool Stop(void);                        // stop hardware
    void NewScan(unsigned char* ptrData, unsigned short nrData);
    void WriteTest();
    void FindDevice(int vid, int pid);
 libusb_device_handle *hDevice;          // handle for device
public slots:
//    void NewEP_Data(unsigned int nrContext);// (organize) new data, called via Monitor signal

signals:
//    void sigNewSVData(qint32*, qint32*, qint32*, qint32*);

private:

//    unsigned int dataInEp;                  // data endpoint number
    unsigned int dataInEpSize;              // data endpoint size
    unsigned char* pDataBuffer;             // data buffer for incomming data

    quint64 fpgaCtrlFreq;                   // FPGA hardware control counter freq.
    SCANNERCONFIG pScannerCfg;              // doppler control counter values

    void GetScan(unsigned char* ptrData, unsigned short nrData);   // called by NewScan()

    bool runMode;                           // doppler RUN/STOP flag
};

#endif // BSHW_H
