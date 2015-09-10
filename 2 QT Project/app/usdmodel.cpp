#include "usdmodel.h"

#define VID 0x1FC9
#define PID 0x85

void LIBUSB_CALL cb_mode_changed(struct libusb_transfer *transfer)
{
    if (transfer->status != LIBUSB_TRANSFER_COMPLETED) {
#ifdef QT_DEBUG
        qDebug() << "mode change transfer not completed! " << transfer->actual_length;
#endif
    }
    usdDevice* ddt = ((usdDevice*)transfer->user_data);
    emit ddt->NewData(ddt->data16, SAMPLES * Multiply);
}

usdDevice::usdDevice(QObject *parent) :
    usbDevice(parent)
{
    ctx.timeout(100);
    async.endpoint(0x81)
        ->timeout(1500)
        ->data((unsigned char*)data16, SAMPLES * Multiply)
        ->attach_cb(cb_mode_changed);
    this
        ->pid       (PID)
        ->vid       (VID)
        ->interface (0);
    connect(this, SIGNAL(modeChanged(usdDevice::Mode)), this, SLOT(on_ModeChanged(usdDevice::Mode)));
}

QString usdDevice::GetDeviceInfo()
{
    return "";
}

void usdDevice::on_ModeChanged(usdDevice::Mode mode)
{
    if(mode == usdDevice::Run){
          async.userdata(this)
              ->devHandle(this->_devHandle)
              ->submitAsyncTransfer();
    }
    else{
        ctx.TransmitSetupPackage<LIBUSB_REQUEST_TYPE_VENDOR>(MODE, usdDevice::Stop, 0, 0);
    }
}

void usdDevice::_recalculateDepth()
{
    short value = 0;
    switch(frequency()){
        case 2000000: value = 64*svLength()*2+16;
            break;
        case 4000000: value = 32*svLength()*2+8;
            break;
    default:
        case 8000000: value = 32*svLength()*2+4;
            break;
    }

    setDepth(sample()+value);
#ifdef QT_DEBUG
    qDebug() << value;
#endif
}
