#include "usd.h"
#include <dbt.h>
#include <QtCore>
#include <QtGui>
#include <qwidget.h>
#include <QtDebug>

USD::USD(QWidget *parent) :
    QWidget(parent){
    _devInfo.VID = 0x1FC9;//VENDOR_ID;
    _devInfo.PID = 0x2020; // PRODUCT_ID;
}

bool USD::Connect(){
    libusb_device **devs; //pointer to pointer of device, used to retrieve a list of devices
    int r; //for return values
    ssize_t cnt; //holding number of devices in list
    r = libusb_init(&ctx); //initialize the library for the session we just declared
    if(r < 0) {
        qDebug() << "Init Error " << r; //there was an error
        return false;
    }
    libusb_set_debug(ctx, 3); //set verbosity level to 3, as suggested in the documentation
    cnt = libusb_get_device_list(ctx, &devs); //get the list of devices
    if(cnt < 0) {
        qDebug() << "Get Device Error" ; //there was an error
        return false;
    }
    qDebug() << cnt<<" Devices in list.";
    _devHandle = libusb_open_device_with_vid_pid(ctx, VENDOR_ID, PRODUCT_ID); //these are vendorID and productID I found for my usb device
    if(_devHandle == NULL){
        qDebug() << "Cannot open device";
        return false;
    }
    else
        qDebug() << "Device Opened";
    libusb_free_device_list(devs, 1); //free the list, unref the devices in it

    if(libusb_kernel_driver_active(_devHandle, 0) == 1) { //find out if kernel driver is attached
        qDebug() << "Kernel Driver Active";
        if(libusb_detach_kernel_driver(_devHandle, 0) == 0) //detach it
            qDebug() << "Kernel Driver Detached!";
    }
    r = libusb_claim_interface(_devHandle, 0); //claim interface 0 (the first) of device (mine had jsut 1)
    if(r < 0) {
        qDebug() << "Cannot Claim Interface";
        return false;
    }
    qDebug() << "Claimed Interface";

    return true;
}

ErrorCode_t USD::TransmitControl(Request req){
    int bytesRead = 0;
    if(!_devHandle) return FAIL;
    int r;
    if(req != SET_CONFIGURATION)
        r = libusb_interrupt_transfer(_devHandle, (1 | LIBUSB_ENDPOINT_OUT), TransmitBuffer, 4, &bytesRead, 0);
    else r = libusb_interrupt_transfer(_devHandle, (1 | LIBUSB_ENDPOINT_OUT), TransmitBuffer, 1, &bytesRead, 0);
    return(r == 0 && bytesRead > 0) ? OK : FAIL;
}

void USD::_devicesChanged(void){
    // List storing all detected devices
    libusb_device **devs;
    // Get all devices connected to system
    if (libusb_get_device_list(NULL, &devs) < 0){
        qDebug() << "Failed to get devices list";
        return;
    }
    // Scan for  VID & PID
    libusb_device *dev;
    // retdev stores the first device detected
    libusb_device *retdev = NULL;
    int i = 0;
    int count = 0;
    struct libusb_device_descriptor desc;
    while ( (dev = devs[i++]) != NULL ){
        if (libusb_get_device_descriptor(dev, &desc) < 0){
            qDebug() << "failed to get device descriptor";
            continue;
        }
        // Is this device the one we are looking for?
        if ( (desc.idVendor == _devInfo.VID) && (desc.idProduct == _devInfo.PID) ){
            count++;
            //if ( retdev == NULL )
                retdev = dev;
        }
    }

    if (count <= 0)
    {
        qDebug() << "Warning! No device found";
        return;
    }

    if (count > 1 )
    {
        qDebug() << "Warning! More than one device found. Using first on the list";
    }

    if (libusb_open(retdev, &this->_devHandle) < 0)
    {
        qDebug() << "Error! Failed to open device";
        return;
    }

    libusb_free_device_list(devs, 1);

    // now connect to interface //

    if (libusb_claim_interface(this->_devHandle, 0) != LIBUSB_SUCCESS)
    {
        qDebug() << "Error! Failed to claim interface";
        return;
    }

    qDebug() << "DeviceConnected";
}

bool USD::Disconnect(void){
    qDebug() << "DeviceDisconnected";

    if(this->_devHandle != NULL){
        libusb_release_interface(this->_devHandle, 0);
        libusb_close(this->_devHandle);
    }
    if(this->ctx != NULL){
        libusb_exit(ctx); //needs to be called to end the
        this->_devHandle=NULL;
        return true;
    }
    return false;
}

ErrorCode_t USD::SetConfig(void){
    quint64 intDummy;   // to prevent overflows in short int's

    if(!_devHandle) return FAIL;

 //### TODO ! check all the parameters -----------------------------------------
    if ( (this->Config.Frequency != 2)&&(this->Config.Frequency != 4)
         &&(this->Config.Frequency != 8) )
        return FAIL;

//    if ( (scanparmeters->burst >= (scanparmeters->sample.start - 3)) )
//        return false; //To be sure that Gate & SV1S don't begin before burst end

//    float dephtmax = (((1/((float)scanparmeters->PRF))*1E6)*1.5/2);
//    if ( (float)scanparmeters->sample.end > dephtmax)
//        return false; //To be sure that SV-End is located inside of  PRF-Periode

//### calculate the control counter values--------------------------------------

// PRF
    this->Config.PRF = USD_HW_API_T::HW_Frequency / this->Config.PRF;
// Burst
    intDummy = (USD_HW_API_T::HW_Frequency) * this->Config.Burst/(this->Config.Frequency*1E6);
    this->Config.Burst =  intDummy;
// Sample
    intDummy = (USD_HW_API_T::HW_Frequency) * this->Config.Sample/(this->Config.Frequency*1E6);
    this->Config.Sample =  intDummy;
// Depht
    intDummy = (USD_HW_API_T::HW_Frequency) * this->Config.Depth / USD_HW_API_T::PHY_VELOCITY;   // calc. -> PIC
    this->Config.Depth =  intDummy;

// 2MHz synchronisation ;-)
    if(this->Config.Frequency == 4){
        this->Config.Depth = (this->Config.Depth +1) & 0xFFFE;
        this->Config.PRF = (this->Config.PRF +1) & 0xFFFE;
    }
    else if(this->Config.Frequency == 2){
        this->Config.Depth = (this->Config.Depth +2) & 0xFFFC;
        this->Config.PRF = (this->Config.PRF +2) & 0xFFFC;
    }
// send to device
    if(this->SetFrequency(this->Config.Frequency) == OK)
        if(this->SetBurst(this->Config.Burst) == OK)
            if(this->SetSample(this->Config.Sample) == OK)
                if(this->SetDepth(this->Config.Depth) == OK)
                    if(this->SetPRF(this->Config.PRF) == OK)
                        return OK;
    return FAIL;
}

ErrorCode_t USD::SetFrequency(int value){
    if ( (value != 2)&&(value != 4)&&(value != 8) && !_devHandle)
        return FAIL;
    this->Config.Frequency = value;

    this->TransmitBuffer[0]=SET_FREQUENCY;
    this->TransmitBuffer[1]=this->Config.Frequency;

    return TransmitControl(SET_FREQUENCY);
}

ErrorCode_t USD::SetPRF(int value)
{
    this->Config.Burst = value;
    if(!_devHandle) return FAIL;

    return OK;
}

ErrorCode_t USD::SetBurst(int value){
    this->Config.Burst = value;
    if(!_devHandle) return FAIL;

    this->TransmitBuffer[0]=SET_BURST;
    this->TransmitBuffer[1]=this->Config.Burst;

    return TransmitControl(SET_BURST);
}

ErrorCode_t USD::SetSample(int value){
    this->Config.Sample = value;
    if(!_devHandle) return FAIL;

    this->TransmitBuffer[0]=SET_SAMPLE;
    this->TransmitBuffer[1]=this->Config.Sample;

    return TransmitControl(SET_SAMPLE);
}

ErrorCode_t USD::SetDepth(int value){
    this->Config.Depth = value;
    if(!_devHandle) return FAIL;

    this->TransmitBuffer[0]=SET_DEPTH;
    this->TransmitBuffer[1]=this->Config.Depth;

    return TransmitControl(SET_DEPTH);
}

ErrorCode_t USD::SetOperationMode(Mode mode){
    this->_operationMode = mode;
    if(!_devHandle) return FAIL;

    this->TransmitBuffer[0] = SET_RUN;
    this->TransmitBuffer[1] = _operationMode;

    return TransmitControl(SET_RUN);
}

ErrorCode_t USD::SingleShot(unsigned char *ptrData, uint16_t nrData){
    this->TransmitBuffer[0] = SCAN;
    this->TransmitBuffer[1] = nrData/256;
    this->TransmitBuffer[2] = nrData;

    if(TransmitControl(SCAN) == OK)
        return Read(ptrData, nrData);
    else return FAIL;
}

ErrorCode_t USD::Read(unsigned char *ptrData, uint16_t nrData){
    int bytesRead;
    int r = -1;
    if (libusb_claim_interface(this->_devHandle, 1) == LIBUSB_SUCCESS)
    {
        r = libusb_bulk_transfer(_devHandle,0x82,
                                 ptrData, nrData,
                                 &bytesRead, 1000);
        if(this->_devHandle != NULL){
            //libusb_release_interface(this->_devHandle, 1);
            //libusb_claim_interface(this->_devHandle, 0);
        }
    }
    return(r == 0 && bytesRead > 0) ? OK : FAIL;
}

