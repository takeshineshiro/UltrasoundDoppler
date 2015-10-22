#ifndef USD_H
#define USD_H

#include <QWidget>
#include <libs/libusbx/libusb.h>
#include <stdint.h>


static const uint16_t VENDOR_ID  = 0x1FC9;
static const uint16_t PRODUCT_ID = 0x0081;

typedef struct{                 // USB device struct
  quint16   VID;
  quint16   PID;
  QString   strManufacturer;
  QString   strProduct;
  QString   strSerialNumber;
}USB_DEVICE_INFO;

typedef enum {
    OK,
    FAIL
}ErrorCode_t;

typedef enum{
    RUN = 0,
    STOP = 1
}Mode;

typedef enum{
    SET_FREQUENCY = 0,
    SET_BURST,
    SET_SAMPLE,
    SET_DEPTH,
    SET_DATARATE,
    SET_RUN,
    SCAN,
    SET_CONFIGURATION,
}Request;

typedef enum{
    RUN1 = 0,
    STOP1
}USD_STATE;

typedef struct{
    unsigned char  Frequency;
    unsigned short  PRF;        // puls repetition freq. (not used)
    unsigned short  Burst;      // burst volume [nr of periods]
    unsigned short  Sample;     // sample volume [nr of periods]
    unsigned short  Depth;      // middle sample position [mm]
}USD_CONFIG_T;

typedef struct USD_HW_API{
    const static int HW_Frequency = 64000000;  // frequency - scaner board base frequency
    const static int PHY_VELOCITY = 1500000;   // ultrasonic sound velocity in tissue in mm/s
    const static int HW_ADC_DELAY = 8;         // ADC pipeline delay
    const static int USB_TIMEOUT = 100;        // used by requests (ms)
}USD_HW_API_T;

class USD : public QWidget
{
    Q_OBJECT
public:
    explicit USD(QWidget *parent = 0);
    bool Connect(void);
    bool Disconnect(void);
    ErrorCode_t SetConfig(void);
    ErrorCode_t SetFrequency(int value);
    ErrorCode_t SetPRF(int value);
    ErrorCode_t SetBurst(int value);
    ErrorCode_t SetSample(int value);
    ErrorCode_t SetDepth(int value);
    ErrorCode_t SetOperationMode(Mode mode);
    ErrorCode_t SingleShot(unsigned char* ptrData, uint16_t nrData);
    ErrorCode_t Read(unsigned char* ptrData, uint16_t nrData);
    Mode GetOperationMode(void){return _operationMode;}

    USD_CONFIG_T Config;
    libusb_device_handle* _devHandle;

signals:
    void signal_DevicesChanged(void);
public slots:

private:
    ErrorCode_t TransmitControl(Request req);

    Mode _operationMode;
    USB_DEVICE_INFO _devInfo;

    libusb_context *ctx;

    unsigned char TransmitBuffer[64] = {0};
private slots:
    void _devicesChanged(void);
};

#endif // USD_H
