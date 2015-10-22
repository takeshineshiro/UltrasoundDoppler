#ifndef DIGIDOPHW_H
#define DIGIDOPHW_H

#include "usb.h"		// libUsb.lib
//#include <QtCore>
#include <QThread>
#include <QObject>


//** DOPPLER CTRL COMMANDS VIA REQUEST ****************************************

typedef enum
{
    DOPPLER_REQU_SET_FREQUENCY 	   = 0,
    DOPPLER_REQU_SET_DATARATE,
    DOPPLER_REQU_SET_RUN,
    DOPPLER_REQU_SET_CONFIGURATION,
    DOPPLER_REQU_GET_CONFIGURATION,
    DOPPLER_REQU_GET_VERSION,
    DOPPLER_REQU_GET_STRVERSION,
    DOPPLER_REQU_GET_ERROR,
    USB_DOPPLER_REQUESTS
}USB_DOPPLER_REQUEST;

typedef enum
{
    VAL_RUN_STOP			= 0,
    VAL_RUN_RUN				= 1
}USB_DOPPLER_VALUE;


// ####################################### doppler hardware definitions ########
//###TODO###
#define F_OSCILLATOR        64000000    // frequency - doppler board oscillator
#define HP_FILTER_IX        5           // IIR highpass filter index (for 5kHz initial PRF)
#define VELOCITY            1500000        // ultrasonic sound velocity in tissue in mm/s
#define AUDIO_BUFFER_SIZE   512 //256 //1024 // size of doppler (audio) samples package
#define ADCDELAY            8
#define TIMEOUT             1000
#define PACKET_SIZE          17 // size of full FPGA FIFO package (AA + 4 channels)

//##############################################################################

struct USB_DEV{                 // USB device struct
  unsigned short    idVendor;
  unsigned short    idProduct;
  char              strManufacturer[128];
  char              strProduct[128];
  char              strSerialNumber[128];
};

struct DOP_CTRL{                    // doppler control structure
    unsigned short  dopFrequency;
    unsigned short  PRF;            // puls repetition freq.
    unsigned short  BurstS;         // (burst start in mm - not used "0")
    unsigned short  BurstE;         // burst volume (lenght*2) in mm
//    unsigned short  GateS;          // open receiver gate[mm]
//    unsigned short  GateE;          // close receiver gate [mm]

    unsigned short  SampleV1S;	// SV1 start [mm]
    unsigned short  SampleV1E; // SV1 end [mm]
    unsigned short  SampleV2S; // SV2 start [mm]
    unsigned short  SampleV2E; // SV2 end [mm]
};


//##############################################################################

class IsoDataMonitor : public QObject
{
    Q_OBJECT
public:
    explicit IsoDataMonitor(QObject *parent = 0);

    usb_dev_handle *hDevice;                // handle for device
    unsigned int dataInEp;                  // data endpoint number
    unsigned int dataInEpSize;              // data endpoint size
    unsigned char *pDataBuffer;
    bool dataMonitoring;    				// thread control flag

public slots:
    void Read();

signals:
    void sigEPData(unsigned int nrContext);//, unsigned int nrData);
    void ended();

};

//##############################################################################

class DigiDopHW : public QObject
{
  Q_OBJECT

public:
    explicit DigiDopHW(QObject *parent = 0);
    DigiDopHW();//FuncCallBack DataCallBack);
    ~DigiDopHW();

    USB_DEV rgDeviceList[128];	            // ->CreateDeviceList()
    int	CreateDeviceList(void);             // creata a list of all usb devices
    bool Connect(int iDevice);              // connect a device identified by index in list above
    bool Disconnect(void);                  // disconnect the device

    bool Control(struct DOP_CTRL* mmDop);   // all doppler settings
    bool SetFrequency(int value);           // set the doppler freq. in [Hz] (2-4-8 MHz)

    bool Start(void);                       // start doppler hardware
    bool Stop(void);                        // stop doppler hardware

    bool ActivateDataMonitoring(void);      // start data aquisition thread
    bool DeactivateDataMonitoring(void);	// stop data aquisition thread

    unsigned int callcnt_NewData;
    unsigned int callcnt_NewEpData;



public slots:
    void NewEP_Data(unsigned int nrContext);// (organize) new data, called via Monitor signal

signals:
    void sigNewSVData(int32_t*, int32_t*, int32_t*, int32_t*);

private:
    QThread *monitorThread;                 // isochr. data EP handler thread
    IsoDataMonitor *Monitor;

    usb_dev_handle *hDevice;                // handle for device
    unsigned int dataInEp;                  // data endpoint number
    unsigned int dataInEpSize;              // data endpoint size
    unsigned char* pDataBuffer;             // data buffer for incomming data


    uint64_t fpgaCtrlFreq;                  // FPGA hardware control counter freq.
    struct DOP_CTRL pDopCtrl;               // doppler control counter values

    void NewData(unsigned char* ptrData); // process new data, called by NewEP_Data()

    float HpFilter_I(float NewSample);      // IIR High Pass - Butterworth - 2. order (2-12kHz)
    float HpFilter_Q(float NewSample);      // ...
    unsigned int iFilter;                   // index Filter coefficient table


    bool dataMonitoring;                    // thread control flag
    bool runMode;                           // doppler RUN/STOP flag

    double audioData[3*AUDIO_BUFFER_SIZE];  // doppler (audio) data
    unsigned int audioDataIndex;            // ... pointer
//    FuncCallBack AudioData;                 // callback function to pass doppler data

};

#endif // DIGIDOPHW_H
