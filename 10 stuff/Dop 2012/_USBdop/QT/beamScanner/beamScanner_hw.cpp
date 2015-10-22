
#include "beamScanner_hw.h"


#define ID_VENDOR  0x1FC9// 0x04D8     //0x0703  //
#define ID_PRODUCT 0xBBBB //  0x0081
//#define STR_MANU      "HS-ULM"
//#define STR_PROD      "Beam-Scanner"
//#define STR_SERIAL    "00000001"

void BeamScannerHW::FindDevice(int vid, int pid){
    libusb_device **devs; //pointer to pointer of device, used to retrieve a list of devices
    libusb_device_handle *dev_handle; //a device handle
    libusb_context *ctx = NULL; //a libusb session
    int r; //for return values
    ssize_t cnt; //holding number of devices in list
    r = libusb_init(&ctx); //initialize the library for the session we just declared
    if(r < 0) {
        qDebug() << "Init Error " << r; //there was an error
        return;
    }
    libusb_set_debug(ctx, 3); //set verbosity level to 3, as suggested in the documentation
    cnt = libusb_get_device_list(ctx, &devs); //get the list of devices
    if(cnt < 0) {
        qDebug() << "Get Device Error" ; //there was an error
        return;
    }
    qDebug() << cnt<<" Devices in list.";
    dev_handle = libusb_open_device_with_vid_pid(ctx, vid, pid); //these are vendorID and productID I found for my usb device
    if(dev_handle == NULL){
        qDebug() << "Cannot open device";
        return;
    }
    else
        qDebug() << "Device Opened";
    libusb_free_device_list(devs, 1); //free the list, unref the devices in it

    if(libusb_kernel_driver_active(dev_handle, 0) == 1) { //find out if kernel driver is attached
        qDebug() << "Kernel Driver Active";
        if(libusb_detach_kernel_driver(dev_handle, 0) == 0) //detach it
            qDebug() << "Kernel Driver Detached!";
    }
    r = libusb_claim_interface(dev_handle, 0); //claim interface 0 (the first) of device (mine had jsut 1)
    if(r < 0) {
        qDebug() << "Cannot Claim Interface";
        return;
    }
    qDebug() << "Claimed Interface";
    int actual = 0; //used to find out how many bytes were written
    unsigned char *data = new unsigned char[4]; //data to write
    data[0]=0x01 ;data[1]=0x01;data[2]='c';data[3]='d'; //some dummy values

    qDebug() << "Writing Data...";
    r = libusb_interrupt_transfer(dev_handle, (1 | LIBUSB_ENDPOINT_OUT), data, 4, &actual, 0); //my device's out endpoint was 2, found with trial- the device had 2 endpoints: 2 and 129
    if(r == 0 && actual > 0) //we wrote the 4 bytes successfully
        qDebug() << "Writing Successful!";
    else
        qDebug() << "Write Error";
    r = libusb_release_interface(dev_handle, 0); //release the claimed interface
    if(r!=0) {
        qDebug() << "Cannot Release Interface";
        return;
    }
    qDebug() << "Released Interface";
    libusb_close(dev_handle); //close the device we opened
    libusb_exit(ctx); //needs to be called to end the
}

// Configuration Descriptor ---------------------------------
struct bs_config_descriptor {
    uint8_t  c_bLength;               // 0x09
    uint8_t  c_bDescriptorType;       // 0x02 (CONFIGURATION)
    uint16_t c_wTotalLength;          // word alligned !
    uint8_t  c_bNumInterfaces;        // number
    uint8_t  c_bConfigurationValue;   // ID
    uint8_t  c_iConfiguration;        // string descriptor index
    uint8_t  c_bmAttributes;          // 0b1xx00000
    uint8_t  c_MaxPower;              // number
// Interface Descriptors -----------------------
    uint8_t  i_bLength;               // 0x09
    uint8_t  i_bDescriptorType;       // 0x04 (INTERFACE)
    uint8_t  i_bInterfaceNumber;      // 0x00
    uint8_t  i_bAlternateSetting;     // 0x00
    uint8_t  i_bNumEndpoints;         // 0x02
    uint8_t  i_bInterfaceClass;       // 0xFF
    uint8_t  i_bInterfaceSubClass;    //
    uint8_t  i_bInterfaceProtocol;    //
    uint8_t  i_iStrDesc;              // index of stringdescriptor
// Endpoint Descriptor
    uint8_t  eo_bLength;              // 0x07
    uint8_t  eo_bDescriptorType;      // ENDPOINT
    uint8_t  eo_bEndpointAddress;
    uint8_t  eo_bmAttributes;
    uint8_t  eo_wMaxPacketSize_LB;
    uint8_t  eo_wMaxPacketSize_HB;    // ..
    uint8_t  eo_bInterval;
// Endpoint Descriptor
    uint8_t  ei_bLength;              // 0x07
    uint8_t  ei_bDescriptorType;      // ENDPOINT
    uint8_t  ei_bDescriptorSubtype;   // EP_GENERAL
    uint8_t  ei_bmAtributes;          //
    uint8_t  ei_wMaxPacketSize_LB;
    uint8_t  ei_wMaxPacketSize_HB;    // ..
    uint8_t  ei_bInterval;

    uint8_t extra[45];
};

//##############################################################################
//##############################################################################
/*******************************************************************************
 * Class:           DigiDopHW
 *
 * Overview:        Implements the USB PulsWaweDoppler HW
 *
 * Note:            Subclass isoDataMonitor is needed to perform isochrounous
 *                  read of doppler data !
*
 ******************************************************************************/
//##############################################################################
//##############################################################################
BeamScannerHW::BeamScannerHW(QObject *parent) :
    QObject(parent)
{
//    AudioData = DataCallBack;   // pointer to callback function

    hDevice = NULL;
    pDataBuffer = NULL;

//    libusb_set_debug(255);         // libUsb.lib
    libusb_init(NULL);              // TODO -> error handling
//    libusb_set_debug(255);         // libUsb.lib

    /* Just like the name implies, usb_init sets up some internal structures.
       usb_init must be called before any other libusb functions.*/

    fpgaCtrlFreq = F_BASE_HW;     // doppler device clock - needed for control counter calculations
    runMode = false;

}
//##############################################################################
BeamScannerHW::~BeamScannerHW()
{
    Disconnect();
}

/******************************************************************************
 * Function:        CreateDeviceList()
 *
 * PreCondition:    None
 * Input:           None
 * Output:          Number of devices found
 * Side Effects:
 *
 * Overview:        fills the rgDeviceList[] structure
 *
 * Note:            None
 *****************************************************************************/
int BeamScannerHW::CreateDeviceList(){
    FindDevice(0x1FC9,0x0081);
    libusb_device **devs;
    libusb_device *dev;
    libusb_device_descriptor desc;
    unsigned char string[128];
    int iDevice = 0;
    int r;

    libusb_get_device_list(NULL, &devs);
    while((dev = devs[iDevice])!= NULL){
        /* Open the device */
        rgDeviceList[iDevice].idVendor = 0;
        rgDeviceList[iDevice].idProduct = 0;
        rgDeviceList[iDevice].strManufacturer = "";
        rgDeviceList[iDevice].strProduct = "";
        rgDeviceList[iDevice].strSerialNumber = "";

        libusb_get_device_descriptor(dev, &desc);   // TODO -> error handling
        rgDeviceList[iDevice].idVendor = desc.idVendor;
        rgDeviceList[iDevice].idProduct = desc.idProduct;
        rgDeviceList[iDevice].strManufacturer = desc.iManufacturer;
        rgDeviceList[iDevice].strProduct[0] = desc.idProduct;
        rgDeviceList[iDevice].strSerialNumber[0] = desc.iSerialNumber;
        if (libusb_open(dev,&hDevice) == 0) {
            r = libusb_get_string_descriptor_ascii(hDevice, desc.iManufacturer,string,128);
            if(r > 0) rgDeviceList[iDevice].strManufacturer = QString((const char *)string);
            r = libusb_get_string_descriptor_ascii(hDevice, desc.iProduct,string,128);
            if(r > 0) rgDeviceList[iDevice].strProduct = QString((const char *)string);
            r = libusb_get_string_descriptor_ascii(hDevice, desc.iSerialNumber,string,128);
            if(r > 0) rgDeviceList[iDevice].strSerialNumber = QString((const char *)string);
            libusb_close(hDevice);

//http://comments.gmane.org/gmane.comp.lib.libusbx.devel/1705 ???
        }
        iDevice++;
    }

    hDevice = NULL;
    return iDevice;
}

/*******************************************************************************
 * Function:        Connect(int iDevice)
 *
 * PreCondition:    The device list must be created previousley
 * Input:           Device index in rgDeviceList[i]
 * Output:          Success
 * Side Effects:    Calls GetInterface()
 *
 * Overview:        Connect device and create handles for control and data
 *                  interfaces
 *
 * Note:            None
 ******************************************************************************/
bool BeamScannerHW::Connect(int iDevice)
{
    libusb_device **devs;
    libusb_device *dev;
    libusb_device_descriptor desc;
    struct bs_config_descriptor conf_desc;
    unsigned char string[128];
    QString SerialNumber;
    int r,configuration;

    if(rgDeviceList[iDevice].idVendor != ID_VENDOR){
        return false;       //throw(0);
    }
    if(hDevice){
        if (!Disconnect())
            throw(0);       //return false;
    }
    if(iDevice < 0){
        return false;       //throw(0);
    }

    libusb_get_device_list(NULL, &devs);
    while((dev = devs[iDevice])!= NULL){
        libusb_get_device_descriptor(dev, &desc);   // TODO -> error handling
        if (desc.idVendor == rgDeviceList[iDevice].idVendor
                && desc.idProduct == rgDeviceList[iDevice].idProduct ) {

            if (libusb_open(dev,&hDevice) == 0) {
                r = libusb_get_string_descriptor_ascii(hDevice, desc.iSerialNumber,string,128);
                if(r>0) SerialNumber = QString((const char *)string);
                if (rgDeviceList[iDevice].strSerialNumber.contains(SerialNumber) == 0){
                    throw(0);
                }

                r = libusb_get_descriptor(hDevice, LIBUSB_DT_CONFIG, 0,
                                          (unsigned char*)&conf_desc,//(unsigned char*)&devDescriptor,
                                          sizeof(conf_desc));
                if(r<0){
                    libusb_set_configuration(hDevice, 0);
                    libusb_close(hDevice);
                    hDevice = NULL;
                    return false;
                }

//                dataInEp = devDescriptor.stdep_bEndpointAddress;
                dataInEpSize = conf_desc.ei_wMaxPacketSize_HB *256;
                dataInEpSize += conf_desc.ei_wMaxPacketSize_LB;
                // set configuration
                //###TODO### remove the magic numbers
                r = libusb_get_configuration(hDevice, &configuration);
                if(configuration != 1){
                    r = libusb_set_configuration(hDevice, 1);
                    if(r<0){
                        libusb_close(hDevice);
                        hDevice = NULL;
                        return false;
                    }
                }
                r = libusb_claim_interface(hDevice,0);// devDescriptor.stdac_bInterfaceNumber) < 0) {
                    if(r<0){
                    libusb_set_configuration(hDevice, 0);
                    libusb_close(hDevice);
                    hDevice = NULL;
                    return false;
                }

                pDataBuffer = new unsigned char[3*dataInEpSize];    //???
                return true;		// found device !
            }//if (hDevice = usb_open(dev))
        }//if (desc.idVendor...
    }//while((dev = devs[...

    hDevice = NULL;
    return false;
}

/******************************************************************************
 * Function:        Disconnect()
 *
 * PreCondition:    a device should be connected / not a must ;-)
 * Input:           None
 * Output:          Success
 * Side Effects:    None
 *
 * Overview:        stop device and release the handles for device
 *
 * Note:            None
 *****************************************************************************/
bool BeamScannerHW::Disconnect()
{
    if(hDevice){
        if (runMode == true){
            Stop();
        }
        int r = libusb_release_interface(hDevice, 0);
        r = libusb_set_configuration(hDevice, 0);
        libusb_close(hDevice);
        hDevice = NULL;
        return true;
    }
    if (pDataBuffer != NULL){
        delete[] pDataBuffer;
        pDataBuffer = NULL;
    }

    return false;
}

/******************************************************************************
 * Function:        bool SetFrequency(int value)
 *
 * PreCondition:    None
 * Input:           Doppler Carrier Frequency in [MHz] (2-4-8 MHz)
 * Output:          Success
 * Side Effects:
 *
 * Overview:
 *
 * Note:            None
 ******************************************************************************/
bool BeamScannerHW::SetFrequency(int value)
{
    if ( (value != 2)&&(value != 4)&&(value != 8) )
        return false;

    pScannerCfg.frequency = value;

    if(!hDevice) return false;
    int r = libusb_control_transfer(hDevice,
                        LIBUSB_REQUEST_TYPE_VENDOR,
                        BS_REQU_SET_FREQUENCY, pScannerCfg.frequency,
                        0, NULL, 0, TIMEOUT);
    if(r < 0){
        throw(0);
    }
    return true;
}

/******************************************************************************
 * Function:        bool SetBurst(int value)
 *
 * PreCondition:    None
 * Input:           Burts length [nr of periods]
 * Output:          Success
 * Side Effects:
 *
 * Overview:
 *
 * Note:            None
 ******************************************************************************/
bool BeamScannerHW::SetBurst(int value)
{
    pScannerCfg.burst = value;

    if(!hDevice) return false;
    int r = libusb_control_transfer(hDevice,
                        LIBUSB_REQUEST_TYPE_VENDOR,
                        BS_REQU_SET_BURST, pScannerCfg.burst,
                        0, NULL, 0, TIMEOUT);
    if(r < 0){
        throw(0);
    }
    return true;
}

/******************************************************************************
 * Function:        bool SetGate(int value)
 *
 * PreCondition:    None
 * Input:           Gate length [nr of periods]
 * Output:          Success
 * Side Effects:
 *
 * Overview:
 *
 * Note:            None
 ******************************************************************************/
bool BeamScannerHW::SetSample(int value)
{
    pScannerCfg.sample = value;

    if(!hDevice) return false;
    int r = libusb_control_transfer(hDevice,
                        LIBUSB_REQUEST_TYPE_VENDOR,
                        BS_REQU_SET_SAMPLE, pScannerCfg.sample,
                        0, NULL, 0, TIMEOUT);
    if(r < 0){
        throw(0);
    }
    return true;
}
/******************************************************************************
 * Function:        bool SetDepht(int value)
 *
 * PreCondition:    None
 * Input:           Depth value for receiver gate [mm]
 * Output:          Success
 * Side Effects:
 *
 * Overview:
 *
 * Note:            None
 ******************************************************************************/
bool BeamScannerHW::SetDepht(int value)
{
    pScannerCfg.depht = value;

    if(!hDevice) return false;
    int r = libusb_control_transfer(hDevice,
                        LIBUSB_REQUEST_TYPE_VENDOR,
                        BS_REQU_SET_DEPHT, pScannerCfg.depht,
                        0, NULL, 0, TIMEOUT);
    if(r < 0){
        throw(0);
    }
    return true;
}

/******************************************************************************
 * Function:        bool Control(SCANNERCFG* mmDop)
 *
 * PreCondition:    None
 * Input:           Doppler Control Structure
 * Output:          Success
 * Side Effects:    also the IIR HP filter coefficient will be set
 *
 * Overview:        Calculate the "timing" based on the depth values and the
 *                  control counter frequency
 *                  This function is used to pass a new doppler setting
 *                  Transmitter - Samples - Amplification
 *
 * Note:            None
 ******************************************************************************/
bool BeamScannerHW::Control(SCANNERCONFIG* scanparameters)
{
    quint64 intDummy;   // to prevent overflows in short int's

    if(!hDevice) return false;

 //### TODO ! check all the parameters -----------------------------------------
    if ( (scanparameters->frequency != 2)&&(scanparameters->frequency != 4)
         &&(scanparameters->frequency != 8) )
        return false;

//    if ( (scanparmeters->burst >= (scanparmeters->sample.start - 3)) )
//        return false; //To be sure that Gate & SV1S don't begin before burst end

//    float dephtmax = (((1/((float)scanparmeters->PRF))*1E6)*1.5/2);
//    if ( (float)scanparmeters->sample.end > dephtmax)
//        return false; //To be sure that SV-End is located inside of  PRF-Periode

//### calculate the control counter values--------------------------------------
    pScannerCfg.frequency = scanparameters->frequency;
// PRF
    pScannerCfg.PRF = fpgaCtrlFreq / scanparameters->PRF;
// Burst
    intDummy = (fpgaCtrlFreq) * scanparameters->burst/(scanparameters->frequency*1E6);
    pScannerCfg.burst =  intDummy;
// Sample
    intDummy = (fpgaCtrlFreq) * scanparameters->sample/(scanparameters->frequency*1E6);
    pScannerCfg.sample =  intDummy;
// Depht
    intDummy = (fpgaCtrlFreq) * scanparameters->depht / VELOCITY;   // calc. -> PIC
    pScannerCfg.depht =  intDummy;

// 2MHz synchronisation ;-)
    if(scanparameters->frequency == 4){
        pScannerCfg.depht = (pScannerCfg.depht +1) & 0xFFFE;
        pScannerCfg.PRF = (pScannerCfg.PRF +1) & 0xFFFE;
    }
    else if(scanparameters->frequency == 2){
        pScannerCfg.depht = (pScannerCfg.depht +2) & 0xFFFC;
        pScannerCfg.PRF = (pScannerCfg.PRF +2) & 0xFFFC;
    }
// send to device
    int r = libusb_control_transfer(hDevice,
                LIBUSB_REQUEST_TYPE_VENDOR,
                BS_REQU_SET_FREQUENCY, pScannerCfg.frequency,
                0, NULL, 0, TIMEOUT);
    if (r < 0) return false;
    r = libusb_control_transfer(hDevice,
                LIBUSB_REQUEST_TYPE_VENDOR,
                BS_REQU_SET_PRF, pScannerCfg.PRF,
                0, NULL, 0, TIMEOUT);
    if (r < 0) return false;
    r = libusb_control_transfer(hDevice,
                LIBUSB_REQUEST_TYPE_VENDOR,
                BS_REQU_SET_BURST, pScannerCfg.burst,
                0, NULL, 0, TIMEOUT);
    if (r < 0) return false;
    r = libusb_control_transfer(hDevice,
                LIBUSB_REQUEST_TYPE_VENDOR,
                BS_REQU_SET_SAMPLE, pScannerCfg.sample,
                0, NULL, 0, TIMEOUT);
    if (r < 0) return false;
    r = libusb_control_transfer(hDevice,
                LIBUSB_REQUEST_TYPE_VENDOR,
                BS_REQU_SET_DEPHT, pScannerCfg.depht,
                0, NULL, 0, TIMEOUT);
    if (r < 0) return false;
    r = libusb_control_transfer(hDevice,
                LIBUSB_REQUEST_TYPE_VENDOR,
                BS_REQU_SET_CONFIGURATION, 0,
                0, NULL, 0, TIMEOUT);

    /*int r = libusb_control_transfer(hDevice,
                        LIBUSB_REQUEST_TYPE_VENDOR,
                        BS_REQU_SET_CONFIGURATION, 0,
                        0, (unsigned char*)&pScannerCfg, sizeof(SCANNERCONFIG), TIMEOUT);*/
    if (r < 0){
        //throw(0);
    }
    return true;
}


/*******************************************************************************
 * Function:        Start()
 *
 * PreCondition:    doppler should be configured ;-)
 * Input:           None
 * Output:          Success
 * Side Effects:    None
 *
 * Overview:        Start the doppler device
 *
 * Note:            None
 *****************************************************************************/
bool BeamScannerHW::Start(void)
{
    //    if (runMode)  ??? ###TODO###

    //    if (SetControl()){

    if(!hDevice) return false;
    int r = libusb_control_transfer(hDevice,
            LIBUSB_REQUEST_TYPE_VENDOR,
            BS_REQU_SET_RUN, VAL_RUN_RUN,
            0, NULL, 0, TIMEOUT);
    if (r < 0){
        throw(0);
    }
    else {
        runMode = true;
        return true;
    }
    //	}
    return false;
}

/******************************************************************************
 * Function:        Stop()
 *
 * PreCondition:    None
 * Input:           None
 * Output:          Success
 * Side Effects:    None
 *
 * Overview:        Halt the doppler device
 *
 * Note:            None
 *****************************************************************************/
bool BeamScannerHW::Stop(void)
{
    if(!hDevice)
        return false;

    int r = libusb_control_transfer(hDevice,
            LIBUSB_REQUEST_TYPE_VENDOR,
            BS_REQU_SET_RUN, VAL_RUN_STOP,
            0, NULL, 0, TIMEOUT);
    if (r < 0){
        throw(0);
    }
    else {
        runMode = false;
        return true;
    }
    //	}
    return false;
}


/******************************************************************************
 * Function:        NewScan(...)
 *
 * PreCondition:    parameters should be set !
 *
 * Input:
 *
 * Output:          Success
 *
 * Side Effects:    None
 *
 * Overview:        Returns when Scan is compleate
 *                  -> GetScan() to read the data
 *
 * Note:            None
 *****************************************************************************/
void BeamScannerHW::NewScan(unsigned char* ptrData, unsigned short nrData)
{
    int r = libusb_control_transfer(hDevice,
            LIBUSB_REQUEST_TYPE_VENDOR,
            BS_REQU_SCAN,nrData,
            0, NULL, 0, TIMEOUT);
    if (r < 0){
        throw(0);
    }
    GetScan(ptrData, nrData);
    return;
}

/*******************************************************************************
 * Function:        GetScan(...)
 *
 * PreCondition:
 *
 * Input:           Pointer to new data memory, number of bytes to read
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Write ??? incoming bytes into a 10000 Byte Register.
 *                  ...
 *
 * Note:            None
 ******************************************************************************/
void BeamScannerHW::GetScan(unsigned char* ptrData, unsigned short nrData)
{

    int bytesRead;
    int r;
    r = libusb_bulk_transfer(hDevice,0x81,
                             ptrData, nrData,
                             &bytesRead, TIMEOUT);
    qDebug() << bytesRead << " von " << nrData << " gelesen. FehlerCode: " << r;

    if (r < 0){
//        throw(0);
    }
    return;
}

//******************************************************************************
// for testing only ...
void BeamScannerHW::WriteTest(){
    unsigned char Data[64];
    int bytesWritten = 0;
    int r;

    r = libusb_bulk_transfer(hDevice,0x81,
                             Data,2048,//64,//512,//*64],64,
                             &bytesWritten, 512);
    if (r < 0){
//    throw(0);
    }
    return;
}

