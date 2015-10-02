#ifndef USDDEVICE_H
#define USDDEVICE_H

#ifdef QT_DEBUG

#endif
#include "libs/usbDevicelib/usbdevice.h"
#include <QtDebug>
#define DEVICENAME "Ultrasonic Doppler beta"

#define SAMPLES 4096
#define Multiply 2

using namespace USB;

enum ErrorCode32_t{
    OK,
    FAIL
};

class usdDevice : public usbDevice
{
    // if static -> comment out Q_OBJECT..
    Q_OBJECT
    //für QT Quick
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged)
    Q_PROPERTY(quint16 frequency READ frequency WRITE setFrequency NOTIFY frequencyChanged)
    Q_PROPERTY(quint16 prf READ prf WRITE setPrf NOTIFY prfChanged)
    Q_PROPERTY(quint16 burst READ burst WRITE setBurst NOTIFY burstChanged)
    Q_PROPERTY(quint16 sample READ sample WRITE setSample NOTIFY sampleChanged)
    Q_PROPERTY(quint16 depth READ depth WRITE setDepth NOTIFY depthChanged)
    Q_PROPERTY(quint8 gateLength READ gateLength WRITE setGateLength NOTIFY gateLengthChanged)
    Q_PROPERTY(quint8 svLength READ svLength WRITE setSvLength NOTIFY svLengthChanged)
    Q_PROPERTY(quint8 tx READ transmitter WRITE settransmitter NOTIFY transmitterChanged)
    Q_PROPERTY(quint8 rx READ receiver WRITE setreceiver NOTIFY receiverChanged)
    Q_ENUMS(usdDevice::Mode)
public:
    explicit usdDevice(QObject *parent = 0);

    enum Mode { Stop = 0x00, Run = 0x01 };

    QString name() const { return QT_TR_NOOP(DEVICENAME); }

    static short adcRange() { return 2000; }         //!< in mV */
    static short adcResolution() { return 16384; }   //!< 2^14 bit */
    static short LNA() { return 20; }   //!< Faktor 20 */
    static double valueToVolt(short value){
        return ((double)value)*adcRange()/adcResolution()/LNA();
    }

    static QList<int> supportedBurstFrequencyRates()
    {
        //in Hz
        return QList<int>()
                <<   8000000
                <<   4000000
                <<   2000000;
    }

    static QList<int> supportedPRFRates()
    {
        //in Hz
        return QList<int>()
                <<   12000
                <<   11000
                <<   10000
                <<    9000
                <<    8000
                <<    7000
                <<    6000
                <<    5000
                <<    4000
                <<    3000
                <<    2000;
    }

    QString GetDeviceInfo(void);

    /* Mode */
    Mode mode() const { return _mode; }
    void setMode(const Mode& value){
        if(!this->isAvailable()){
            _mode = Stop;
            emit modeChanged(_mode);
            return;
        }
        if(_mode != value){
            _mode = value;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(MODE, value, 0, 0) >= 0)
                emit modeChanged(value);
        }
    }

    /* Frequency */
    quint32 frequency() const { return _frequency; }
    void setFrequency(const quint32& value){
        if(_frequency != value && value != 0 && this->isAvailable()){
            _frequency = value;
            qDebug() << this->isAvailable();
            ctx.devHandle(this->_devHandle);
            switch(value){
            case 2000000:
                ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(FREQUENCY, 0x01, 0, 0);
                break;
            case 4000000:
                ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(FREQUENCY, 0x02, 0, 0);
                break;
            case 8000000:
                ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(FREQUENCY, 0x03, 0, 0);
                break;
            }
            _recalculateDepth();
            emit frequencyChanged(value);
        }
    }

    /* PRF */
    quint16 prf() const { return _prf; }
    void setPrf(const quint16& value){
        if(_prf != value && value != 0 && this->isAvailable()){
            _prf = value;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(PRF, (64000000/value), 0, 0) >= 0)
                emit prfChanged(value);
        }
    }

    /* Burst */
    quint16 burst() const { return _burst; }
    void setBurst(const quint16 value){
        if(_burst != value && value != 0 && this->isAvailable()){
            _burst = value;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(BURST, value, 0, 0) >= 0)
                emit burstChanged(value);
        }
    }

    /* Sample */
    quint16 sample() const { return _sample; }
    void setSample(const quint16& value){
        if(_sample != value && value != 0){
            _sample = value;
            if(!this->isAvailable()) return;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(SAMPLE, value, 0, 0) >= 0){
                _recalculateDepth();
                emit sampleChanged(value);
            }
        }
    }

    /* Depth */
    quint16 depth() const { return _depth; }
    void setDepth(const quint16& value){
        if(_depth != value && value != 0){
            _depth = value;
            if(!this->isAvailable()) return;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(DEPTH, value, 0, 0) >= 0)
                emit depthChanged(value);
        }
    }

    /* GateLength */
    quint8 gateLength() const { return _gateLength; }
    void setGateLength(const quint8& value){
        if(_gateLength != value){
            _gateLength = value;
            qDebug() << value;
            if(!this->isAvailable()) return;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(GATE, value, 0, 0) >= 0){
                _recalculateDepth();
                emit gateLengthChanged(value);
            }
        }
    }

    /* SVLength */
    quint16 svLength() const { return _svLength; }
    void setSvLength(const quint16& value){
        if(_svLength != value && value != 0){
            _svLength = value;
            if(!this->isAvailable()) return;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(14, value, 0, 0) >= 0){
                _recalculateDepth();
                emit svLengthChanged(value);
            }
        }
    }

    /* Transmitter */
    quint8 transmitter() const { return _tx; }
    void settransmitter(const quint8& value){
        if(_tx != value){
            _tx = value;
            if(!this->isAvailable()) return;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(TX_ON, value, 0, 0) >= 0){
                _recalculateDepth();
                emit transmitterChanged(value);
            }
        }
    }

    /* Receiver */
    quint8 receiver() const { return _rx; }
    void setreceiver(const quint8& value){
        if(_rx != value){
            _rx = value;
            if(!this->isAvailable()) return;
            ctx.devHandle(this->_devHandle);
            if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(RX_ON, value, 0, 0) >= 0){
                emit receiverChanged(value);
            }
        }
    }

    /* RESET CPLD */
    void resetDevice(void){
        if(!this->isAvailable()) return;
        ctx.devHandle(this->_devHandle);
        if(ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(RESET, 0, 0, 0) >= 0){
            emit Devicereseted();
        }
    }

    //int32_t data32[SAMPLES*Multiply*2];// = {0};
    int16_t data16[SAMPLES*Multiply];// = {0};

signals:
    void shutingDown(void);
    //für QT Quick
    void frequencyChanged(quint32);
    void prfChanged(quint16);
    void burstChanged(quint16);
    void sampleChanged(quint16);
    void depthChanged(quint16);
    void modeChanged(usdDevice::Mode);
    void gateLengthChanged(quint8);
    void svLengthChanged(quint8);
    void transmitterChanged(quint8);
    void receiverChanged(quint8);
    void Devicereseted(void);

    void DataArrieved();
    void NewData(int32_t* data32, int size);
    void NewData(int16_t* data16, int size);
public slots:
    void on_ModeChanged(usdDevice::Mode mode);

private:
    usdDevice::Mode _mode = Stop;
    quint32 _frequency;
    quint16 _prf;
    quint16 _burst;
    quint16 _sample;
    quint16 _depth;
    quint8  _gateLength = 3;
    quint16  _svLength = 8;
    quint8  _tx = 0;
    quint8  _rx = 0;


    enum Request { FREQUENCY	= 5,		/**< write frequency to \ref USD_HW_VALUES */
                   PRF			= 6,		/**< write PRF to \ref USD_HW_VALUES */
                   BURST		= 7,		/**< write Burst to \ref USD_HW_VALUES */
                   SAMPLE		= 8,		/**< write StartSampling to \ref USD_HW_VALUES */
                   DEPTH		= 9,		/**< write Depth (Stop Sampling) to \ref USD_HW_VALUES */
                   GATE			= 10,
                   MODE			= 11,		/**< start / stop CPLD Doppler Mode */
                   TX_ON		= 12,
                   RX_ON		= 13,
                   RESET        = 14
                  };
    usbAsyncTransfer<BULK> async;
    usbAsyncTransfer<CONTROL> ctx;

    void _recalculateDepth(void);
};

#endif // USDDEVICE_H
