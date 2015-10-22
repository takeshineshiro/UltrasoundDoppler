
#include "digidophw.h"


#define ID_VENDOR       0x04D8
//#define ID_PRODUCT    0xaaaa
//#define STR_MANU      "HS-ULM"
//#define STR_PROD      "DigiDop"
//#define STR_SERIAL    "00000001"


// Configuration Descriptor (USB_audio_10 4.2)----------------------------------
struct pwd_config_descriptor {
    unsigned char  c_bLength;                   // 0x09
    unsigned char  c_bDescriptorType;           // 0x02 (CONFIGURATION)
    unsigned short c_wTotalLength;              // word alligned !
    unsigned char  c_bNumInterfaces;            // number
    unsigned char  c_bConfigurationValue;       // ID
    unsigned char  c_iConfiguration;            // string descriptor index
    unsigned char  c_bmAttributes;              // 0b1xx00000
    unsigned char  c_MaxPower;                  // number

// AudioControl Interface Descriptors (USB_audio_10 4.3 )-----------------------
    // (Micro.) Standard AC Interface Descriptor
    unsigned char  stdac_bLength;               // 0x09
    unsigned char  stdac_bDescriptorType;       // 0x04 (INTERFACE)
    unsigned char  stdac_bInterfaceNumber;      // 0x00
    unsigned char  stdac_bAlternateSetting;     // 0x00
    unsigned char  stdac_bNumEndpoints;         // 0x00
    unsigned char  stdac_bInterfaceClass;       // 0x01 (AUDIO)
    unsigned char  stdac_bInterfaceSubClass;    // 0x01 (AUDIOCONTROL)
    unsigned char  stdac_bInterfaceProtocol;    // number
    unsigned char  stdac_iInterface;            // index of stringdescriptor
    // (Micro.) Class-Specific AC  Interface Descriptor
    unsigned char  csac_bLength;                // 0x09
    unsigned char  csac_bDescriptorType;        // 0x24 (CS_INTERFACE)
    unsigned char  csac_bDescriptorSubtype;     // 0x01 (HEADER)
    unsigned char  csac_bcdADC_L;               // 00
    unsigned char  csac_bcdADC_H;               // 01.
    unsigned char  csac_wTotalLengt_L;          // number
    unsigned char  csac_wTotalLengt_H;          // ..
    unsigned char  csac_bInCollection;          // 0x01 (one in AS interface)
    unsigned char  csac_baInterfaceNr;          // interface number
    // (Microphone) Input Terminal Descriptor
    unsigned char  it_bLength;                  // 0x0C
    unsigned char  it_bDescriptorType;          // 0x (CS_INTERFACE)
    unsigned char  it_bDescriptorSubType;       // 0x (INPUT_TERMINAL)
    unsigned char  it_bTerminalID;              //
    unsigned char  it_wTerminalType_L;          //
    unsigned char  it_wTerminalType_H;          // ..
    unsigned char  it_bAssocTerminal;           // ID of associated outputT
    unsigned char  it_NrChannels;               //
    unsigned char  it_wChannelConfig_L;         //
    unsigned char  it_wChannelConfig_H;         // ..
    unsigned char  it_iChannelNames;            // index of stringdescriptor
    unsigned char  it_iTerminal;                // index of stringdescriptor
    // (Microphone) Output Terminal Descriptor
    unsigned char  ot_bLength;                  // 0x09
    unsigned char  ot_bDescriptorType;          // 0x (CS_INTERFACE)
    unsigned char  ot_bDescriptorSubType;       // 0x (OUPUT_TERMINAL)
    unsigned char  ot_bTerminalID;              //
    unsigned char  ot_wTerminalType_L;          //
    unsigned char  ot_wTerminalType_H;          // ..
    unsigned char  ot_bAssocTerminal;           // ID of associated outputT
    unsigned char  ot_bSourceID;                //
    unsigned char  ot_iTerminal;                // index of stringdescriptor

// AudioStreaming Interface Descriptor (USB_audio_10 4.5) ----------------------
    // Standard AS Interface Descriptor (alternate setting 0)
    unsigned char  stdas_a0_bLength;            // 0x09
    unsigned char  stdas_a0_bDescriptorType;    // INTERFACE
    unsigned char  stdas_a0_bInterfaceNumber;   //
    unsigned char  stdas_a0_bAlternateSetting;  //
    unsigned char  stdas_a0_bNumEndpoints;      //
    unsigned char  stdas_a0_bInterfaceClass;    // AUDIO
    unsigned char  stdas_a0_bInterfaceSubClass; // AUDIO_STREAMING
    unsigned char  stdas_a0_bInterfaceProtocol; // 0x00 (not used)
    unsigned char  stdas_a0_iInterface;         // index of stringdescriptor
    // Standard AS Interface Descriptor (alternate setting 1)
    unsigned char  stdas_a1_bLength;            // 0x09
    unsigned char  stdas_a1_bDescriptorType;    // INTERFACE
    unsigned char  stdas_a1_bInterfaceNumber;   //
    unsigned char  stdas_a1_bAlternateSetting;  //
    unsigned char  stdas_a1_bNumEndpoints;      //
    unsigned char  stdas_a1_bInterfaceClass;    // AUDIO
    unsigned char  stdas_a1_bInterfaceSubClass; // AUDIO_STREAMING
    unsigned char  stdas_a1_bInterfaceProtocol; // 0x00 (not used)
    unsigned char  stdas_a1_iInterface;         // index of stringdescriptor
    // Class-Specific AS Interface Descriptor
    unsigned char  csas_bLength;                // 0x07
    unsigned char  csas_bDescriptorType;        // 0x24 (CS_INTERFACE)
    unsigned char  csas_bDescriptorSubtype;     //
    unsigned char  csas_bTerminalLink;          //
    unsigned char  csas_bDelay;                 //
    unsigned char  csas_wFormatTag_L;           //
    unsigned char  csas_wFormatTag_H;           // ..
    // CS AS Format Type Descriptor  (USB Audio Data Formats)
    unsigned char  asft_bLength;                // 0x0B
    unsigned char  asft_bDescriptorType;        // 0x (CS_INTERFACE)
    unsigned char  asft_bDescriptorSubType;     // 0x (FORMAT_TYPE)
    unsigned char  asft_bFormatType;            // FORMAT_TYPE_I
    unsigned char  asft_bNrChannels;            //
    unsigned char  asft_bSubframeSize;          //
    unsigned char  asft_BitResolution;          //
    unsigned char  asft_SamFreqType;            //
    unsigned char  asft_tLowerSamFreq_L;        //
    unsigned char  asft_tLowerSamFreq_H;        // ..
    unsigned char  asft_tLowerSamFreq_U;        // ..
// Audio Streaming Endpoint Deskriptor
    // Standard AS Endpoint Descriptor
    unsigned char  stdep_bLength;               // 0x09
    unsigned char  stdep_bDescriptorType;       // ENDPOINT
    unsigned char  stdep_bEndpointAddress;
    unsigned char  stdep_bmAttributes;
    unsigned char  stdep_wMaxPacketSize_LB;
    unsigned char  stdep_wMaxPacketSize_HB;     // ..
    unsigned char  stdep_bInterval;
    unsigned char  stdep_bRefresh;
    unsigned char  stdep_bSynchAddress;
    // CS AS Endpoint Descriptor
    unsigned char  csep_bLength;                // 0x07
    unsigned char  csep_bDescriptorType;        // CS_ENDPOINT
    unsigned char  csep_bDescriptorSubtype;     // EP_GENERAL
    unsigned char  csep_bmAtributes;            //
    unsigned char  csep_bLockDelayUnits;        //
    unsigned char  csep_wLockDelay_L;           //
    unsigned char  csep_wLockDelay_H;           // ..

    char extra[45];
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
DigiDopHW::DigiDopHW(QObject *parent) :
    QObject(parent)
{
//    AudioData = DataCallBack;   // pointer to callback function

    hDevice = NULL;

    monitorThread = NULL;       // data monitor thread


    usb_set_debug(255);         // libUsb.lib
    usb_init();                 // libUsb.lib
    usb_set_debug(255);         // libUsb.lib

    /* Just like the name implies, usb_init sets up some internal structures.
       usb_init must be called before any other libusb functions.*/

    fpgaCtrlFreq = F_OSCILLATOR;     // doppler device clock - needed for control counter calculations
    iFilter = HP_FILTER_IX;         // IIR highpass filter index

    callcnt_NewData = 0;
    callcnt_NewEpData = 0;
}
//##############################################################################
DigiDopHW::~DigiDopHW()
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
int DigiDopHW::CreateDeviceList(){
    struct usb_bus *bus;
    struct usb_device *dev;
    int iDevice = -1;

    usb_find_busses();
    usb_find_devices();

    for (bus = usb_busses; bus; bus = bus->next) {
        //in usb.h #define usb_busses usb_get_busses()

        iDevice = 0;
        for (dev = bus->devices; dev; dev = dev->next) {
            rgDeviceList[iDevice].idVendor = dev->descriptor.idVendor;
            rgDeviceList[iDevice].idProduct = dev->descriptor.idProduct;

            if (hDevice = usb_open(dev)) {
                usb_get_string_simple(hDevice, dev->descriptor.iManufacturer,
                                      rgDeviceList[iDevice].strManufacturer, 128);
                usb_get_string_simple(hDevice, dev->descriptor.iProduct,
                                      rgDeviceList[iDevice].strProduct, 128);
                usb_get_string_simple(hDevice, dev->descriptor.iSerialNumber,
                                      rgDeviceList[iDevice].strSerialNumber, 128);
                usb_close(hDevice);
            }
            else{
                rgDeviceList[iDevice].strManufacturer[0] = 0;
                rgDeviceList[iDevice].strProduct[0] = 0;
                rgDeviceList[iDevice].strSerialNumber[0] = 0;
                return 0;
            }
            iDevice++;
        }
    }
    rgDeviceList[iDevice].idVendor = 0x0000;
    rgDeviceList[iDevice].idProduct = 0x0000;
    rgDeviceList[iDevice].strManufacturer[0] = 0;
    rgDeviceList[iDevice].strProduct[0] = 0;
    rgDeviceList[iDevice].strSerialNumber[0] = 0;

    hDevice = NULL;
    return iDevice;
}

/******************************************************************************
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
 *****************************************************************************/
bool DigiDopHW::Connect(int iDevice)
{
    struct usb_bus *bus;
    struct usb_device *dev;
    struct pwd_config_descriptor devDescriptor;
    char SerialNumber[128];

    if(iDevice < 0){
        return false;       //throw(0);
    }

    if(rgDeviceList[iDevice].idVendor != ID_VENDOR){
        return false;       //throw(0);
    }

    if(hDevice){
        if (!Disconnect())
            throw(0);       //return false;
    }

    for (bus = usb_busses; bus; bus = bus->next) {
        //usb.h #define usb_busses usb_get_busses()

        for (dev = bus->devices; dev; dev = dev->next) {
            if (dev->descriptor.idVendor == rgDeviceList[iDevice].idVendor
                    && dev->descriptor.idProduct == rgDeviceList[iDevice].idProduct ) {

                if (hDevice = usb_open(dev)) {
                    usb_get_string_simple(hDevice,dev->descriptor.iSerialNumber,
                                          SerialNumber, 128);
                    if (strcmp(SerialNumber,rgDeviceList[iDevice].strSerialNumber)!=0){
                        throw(0);
                    }

                    if (usb_get_descriptor(hDevice, USB_DT_CONFIG, 0,
                                           (void*)&devDescriptor,
                                           sizeof(devDescriptor))<0){
                        usb_set_configuration(hDevice, 0);
                        usb_close(hDevice);
                        hDevice = NULL;
                        return false;
                    }
                    dataInEp = devDescriptor.stdep_bEndpointAddress;
                    dataInEpSize = devDescriptor.stdep_wMaxPacketSize_HB *256;
                    dataInEpSize += devDescriptor.stdep_wMaxPacketSize_LB;
                    // set configuration
                    //###TODO### remove the magic numbers
                    if (usb_set_configuration(hDevice, 1) < 0) {
                        usb_close(hDevice);
                        hDevice = NULL;
                        return false;
                    }
                    if (usb_claim_interface(hDevice,1)<0){// devDescriptor.stdac_bInterfaceNumber) < 0) {
                        usb_set_configuration(hDevice, 0);
                        usb_close(hDevice);
                        return false;
                    }
                    if (usb_set_altinterface(hDevice,1)<0){
                        usb_set_configuration(hDevice, 0);
                        usb_close(hDevice);
                        return false;
                    }
                    pDataBuffer = new unsigned char[3*dataInEpSize];
                    return true;		// found device !
                }//if (hDevice = usb_open(dev))
            }//if (dev->descriptor.idVendor...
        }//for (dev...
    }//for (bus...
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
bool DigiDopHW::Disconnect()
{
    if (dataMonitoring) {
        DeactivateDataMonitoring();   //###TODO###
    }

    if(hDevice){
        if (runMode == true){
            Stop();
        }
        usb_release_interface(hDevice, 1);
        usb_set_configuration(hDevice, 0);
        usb_close(hDevice);
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
bool DigiDopHW::SetFrequency(int value)
{
    if ( (value != 2)&&(value != 4)&&(value != 8) )
        return false;

    pDopCtrl.dopFrequency = value;

    if(!hDevice) return false;
    if (usb_control_msg(hDevice,
                        USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT,
                        DOPPLER_REQU_SET_FREQUENCY, pDopCtrl.dopFrequency,
                        0, NULL, 0, TIMEOUT) < 0)
        throw(0);
    return true;
}

/******************************************************************************
 * Function:        bool Control(struct DOP_CTRL* mmDop)
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
bool DigiDopHW::Control(struct DOP_CTRL* mmDop)
{
    uint64_t intDummy;   // to prevent overflows in short int's

 //### TODO ! check all the parameters -------------------------------------------------
    if ( (mmDop->dopFrequency != 2)&&(mmDop->dopFrequency != 4)
         &&(mmDop->dopFrequency != 8) )         return false;
    if ( (mmDop->BurstE >= (mmDop->SampleV1S - 3)) )   return false; //To be sure that Gate & SV1S don't begin
                                                                     //before burst ends
    if ( (mmDop->BurstE >= mmDop->SampleV2S))   return false;
    if ((mmDop->SampleV1S > mmDop->SampleV2S))  return false;

    float dephtmax = (((1/((float)mmDop->PRF))*1E6)*1.5/2);     //To be sure that SV-End is located inside
    if ( (float)mmDop->SampleV1E > dephtmax) return false;      //of one PRF-Periode
    if ( (float)mmDop->SampleV2E > dephtmax) return false;

//### calculate the control counter values--------------------------------------
    if (hDevice != NULL) {
        pDopCtrl.dopFrequency = mmDop->dopFrequency;
 // PRF
        intDummy = fpgaCtrlFreq / mmDop->PRF;
        pDopCtrl.PRF = intDummy;
        iFilter = (mmDop->PRF+500)/1000;        // index HP_filter coefficients (next 1k)
 // Burst
        intDummy = (fpgaCtrlFreq) * mmDop->BurstS / VELOCITY;
        pDopCtrl.BurstS =  intDummy;
        intDummy = (fpgaCtrlFreq) * mmDop->BurstE / VELOCITY;
        pDopCtrl.BurstE = intDummy;
 // Samples
        intDummy = (fpgaCtrlFreq) * 2 * mmDop->SampleV1S / VELOCITY;
  //      pDopCtrl.GateS = intDummy;
        pDopCtrl.SampleV1S =  intDummy + ADCDELAY;
        intDummy = (fpgaCtrlFreq) * 2 * mmDop->SampleV1E / VELOCITY;
        pDopCtrl.SampleV1E = intDummy + ADCDELAY;
        intDummy = (fpgaCtrlFreq) * 2 * mmDop->SampleV2S / VELOCITY;
        pDopCtrl.SampleV2S =  intDummy + ADCDELAY;
        intDummy = (fpgaCtrlFreq) * 2 * mmDop->SampleV2E / VELOCITY;
  //      pDopCtrl.GateE = intDummy;
        pDopCtrl.SampleV2E = intDummy + ADCDELAY;

   }

    if(!hDevice) return false;
    if (usb_control_msg(hDevice,
                        USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT,
                        DOPPLER_REQU_SET_CONFIGURATION, 0,
                        0, (char*)&pDopCtrl, sizeof(DOP_CTRL), TIMEOUT) < 0)
        throw(0);

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
bool DigiDopHW::Start(void)
{
    audioDataIndex = 0;

    //    if (runMode)  ??? ###TODO###

    //    if (SetControl()){

    if(!hDevice) return false;
    if (usb_control_msg(hDevice,
                        USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT,
                        DOPPLER_REQU_SET_RUN, VAL_RUN_RUN,
                        0, NULL, 0, TIMEOUT) < 0)
        throw(0);
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
bool DigiDopHW::Stop(void)
{
    if(!hDevice)
        return false;

    if(dataMonitoring)
        DeactivateDataMonitoring();

    if (usb_control_msg(hDevice,
                        USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT,
                        DOPPLER_REQU_SET_RUN, VAL_RUN_STOP,
                        0, NULL, 0, TIMEOUT) < 0)
        throw(0);

    return true;
}

/******************************************************************************
 * Function:        ActivateDataMonitoring(void)
 *
 * PreCondition:    None
 * Input:
 * Output:          Success
 * Side Effects:    None
 *
 * Overview:        Activate (create) data thread
 *
 * Note:            None
 *****************************************************************************/
bool DigiDopHW::ActivateDataMonitoring(void)
{
    if (monitorThread)     // exception ???
        return true;

    if (!runMode){
        if (!Start())
            return false;
    }
    monitorThread = new QThread();

    Monitor = new IsoDataMonitor();
    Monitor->hDevice = hDevice;             // handle for device
    Monitor->dataInEp = dataInEp;           // data endpoint number
    Monitor->dataInEpSize = dataInEpSize;   // data endpoint size
    Monitor->pDataBuffer = pDataBuffer;     // pointer to a data buffer
    Monitor->dataMonitoring = true;

    connect(Monitor, SIGNAL(sigEPData(uint)), this, SLOT(NewEP_Data(uint)));

    connect(monitorThread, SIGNAL(started()),Monitor, SLOT(Read()));

    connect(Monitor, SIGNAL(ended()), Monitor, SLOT(deleteLater()));
    connect(Monitor, SIGNAL(destroyed()), monitorThread, SLOT(quit()));
    connect(monitorThread, SIGNAL(finished()), monitorThread, SLOT(deleteLater()));
    connect(monitorThread, SIGNAL(terminated()), monitorThread, SLOT(deleteLater()));


    Monitor->moveToThread(monitorThread);
    monitorThread->start();
    dataMonitoring = true;

    return true;
}

 /******************************************************************************
 * Function:        DeactivateDataMonitoring(void)
 *
 * PreCondition:    None
 * Input:
 * Output:          Success
 * Side Effects:    None
 *
 * Overview:        Deactivate (destruct) data thread
 *
 * Note:            None
 *****************************************************************************/
bool DigiDopHW::DeactivateDataMonitoring(void)
{
    if (monitorThread == NULL)     // exception ???
        return true;

    Monitor->dataMonitoring = false;

    monitorThread = NULL;           // see Activate...
    dataMonitoring = false;

    return true;
}

/******************************************************************************
 * Function:        NewEP_Data(...)
 *
 * PreCondition:    is called by Monitor Signal sigEPData()
 *
 * Input:           Pointer to new data memory
 *
 * Output:          Success
 *
 * Side Effects:    Calls NewData()
 *
 * Overview:        (organize) new data -> 16 Byte;
 *                  search for a AA, and a second AA in a intervall of 17 Byte;
 *                  4 channels a 4 Byte;
 *
 *                   order: MSB_I_SV1,...,...,LSB_I_SV1
 *                          MSB_Q_SV1,...,...,LSB_Q_SV1
 *                          MSB_I_SV2,...,...,LSB_I_SV2
 *                          MSB_Q_SV2,...,...,LSB_Q_SV2
 *
 * Note:            None
 *****************************************************************************/
void DigiDopHW::NewEP_Data(unsigned int nrContext)
{
    unsigned char* ptrData;
    static unsigned char waiting_bytes[PACKET_SIZE] = {0};    // hold the incomplete sample at last function call //
                                                                                   // [1]-[16] -->data waiting bytes / [0] ==> number of waiting bytes
    int first_syncbyte_pos = -1;
    static int errorcnt = 0;
    int32_t testvar;




    ptrData = pDataBuffer + (nrContext * dataInEpSize);

    callcnt_NewEpData++;


    if (waiting_bytes[0] > 0)
    {
        if (ptrData[(PACKET_SIZE - 1 - waiting_bytes[0])] == 0xAA)
        {
            for (int wbyte = waiting_bytes[0]; wbyte < (PACKET_SIZE - 1); wbyte++)               //kompletten Kanal in "waiting_bytes" schreiben
            {
                waiting_bytes[wbyte + 1] = ptrData[wbyte - waiting_bytes[0]];
            }
            NewData(&waiting_bytes[1]);                                     //Daten aus "waiting_bytes" übertragen
            //emit sigNewSVData((int32_t*)(&waiting_bytes[1]));
            for (int i = 0; i < PACKET_SIZE; i++)
            {
                waiting_bytes[i] = 0;
            }

        }
        else
        {
                errorcnt++;//TODO ERROR
                for (int i = 0; i < PACKET_SIZE; i++)
                {
                    waiting_bytes[i] = 0;
                }
        }
    }

    for (int bcnt = 0; bcnt < dataInEpSize; bcnt++)                                                  // find first sync byte
    {

            if (ptrData[bcnt] == 0xAA)                                                      //suche nach erstem AA im entsprechen Drittel von pDataBuffer
            {
                testvar = ptrData[bcnt];
                first_syncbyte_pos = bcnt;
                if (first_syncbyte_pos < (dataInEpSize - PACKET_SIZE))                                               //letztes Sample komplett vorhanden?
                {
                    if (ptrData[first_syncbyte_pos + PACKET_SIZE] != 0xAA)

                        errorcnt++;//TODO ERROR

                    else
                    {
                        NewData((ptrData + first_syncbyte_pos + 1));
                        //emit sigNewSVData((int32_t*)(ptrData+(first_syncbyte_pos + 1))); //kompletten Kanal übertragen
                        bcnt = first_syncbyte_pos + (PACKET_SIZE - 1);                                   // übertragene Bytes überspringen
                    }
                }
                else
                {
                    waiting_bytes[0] = dataInEpSize - 1 - first_syncbyte_pos;
                    for (int wbyte = 1; wbyte <= waiting_bytes[0]; wbyte++)
                    {
                        waiting_bytes[wbyte] = ptrData[(first_syncbyte_pos + wbyte)];           //daten merken
                        bcnt = dataInEpSize;                                                             //schleife benden
                    }
                }
            }
    }



    return;

}
/******************************************************************************
 * Function:        NewData(...)
 *
 * PreCondition:    called by NewEP_Data()
 *
 * Input:           Pointer to new data memory
 *
 * Output:          Success
 *
 * Side Effects:    None
 *
 * Overview:        Write 16 incoming bytes into a 10000 Byte Register.
 *                  It restarts on ArrayIndex 0, when Register is full.
 *
 * Note:            None
 *****************************************************************************/
void DigiDopHW::NewData(unsigned char* ptrData) // process new data, called by NewEP_Data()
{
    //emit sigNewData((int32_t*)ptrData);

    static int32_t dataArraySV1_I[1000] = {0};
    static int32_t dataArraySV1_Q[1000] = {0};
    static int32_t dataArraySV2_I[1000] = {0};
    static int32_t dataArraySV2_Q[1000] = {0};
    static unsigned int ArrayIndex = 0;
    static unsigned int errorcnt;


    int32_t* ptrArraySV1_I;
    int32_t* ptrArraySV1_Q;
    int32_t* ptrArraySV2_I;
    int32_t* ptrArraySV2_Q;

    ptrArraySV1_I = dataArraySV1_I;
    ptrArraySV1_Q = dataArraySV1_Q;
    ptrArraySV2_I = dataArraySV2_I;
    ptrArraySV2_Q = dataArraySV2_Q;

    callcnt_NewData++;

    if (ArrayIndex < 500)
    {
        for (int i = 0; (i < 13) && (ArrayIndex < 500); i+=4)
        {
            if (i == 0)
            {
                dataArraySV1_I[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 4)
            {
                dataArraySV1_Q[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 8)
            {
                dataArraySV2_I[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 12)
            {
                dataArraySV2_Q[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
        }
        ArrayIndex++;
    }
    else if (ArrayIndex == 500)
    {
        for (int i = 0; (i < 13) && (ArrayIndex == 500); i+=4)
        {
            if (i == 0)
            {
                dataArraySV1_I[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 4)
            {
                dataArraySV1_Q[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 8)
            {
                dataArraySV2_I[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 12)
            {
                dataArraySV2_Q[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
        }

        emit sigNewSVData(ptrArraySV1_I,
                          ptrArraySV1_Q,
                          ptrArraySV2_I,
                          ptrArraySV2_Q);
        ArrayIndex++;
    }

    else if (ArrayIndex < 1000)
    {
        for (int i = 0; (i < 16) && (ArrayIndex < 1000); i+=4)
        {
            if (i == 0)
            {
                dataArraySV1_I[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 4)
            {
                dataArraySV1_Q[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 8)
            {
                dataArraySV2_I[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
            else if (i == 12)
            {
                dataArraySV2_Q[ArrayIndex] = *((int32_t*) (ptrData + i));
            }
        }
        ArrayIndex++;
    }
    else if (ArrayIndex == 1000)
    {
        emit sigNewSVData(ptrArraySV1_I + 500,
                          ptrArraySV1_Q + 500,
                          ptrArraySV2_I + 500,
                          ptrArraySV2_Q + 500);
        ArrayIndex = 0;
    }
    else
        errorcnt++;

return;
}

/**************************************************************
WinFilter version 0.8
http://www.winfilter.20m.com
akundert@hotmail.com

Filter type: IIR High Pass
Filter model: Butterworth
Filter order: 2
Sampling Frequency: 2-12 KHz
Cut Frequency: 0.200000 KHz
Coefficents Quantization: float

Z domain Zeros
z = 1.000000 + j 0.000000
z = 1.000000 + j 0.000000

Z domain Poles
z = 0.911347 + j -0.081409
z = 0.911347 + j 0.081409
***************************************************************/
#define NCoef 2

float DigiDopHW::HpFilter_I(float NewSample) {
   float ACoef[13][NCoef+1] =
    { 	0,0,0,
        0,0,0,
        0.63894570401230244000,-1.27789140802460490000,0.63894570401230244000,//2
        0.74308283559531441000,-1.48616567119062880000,0.74308283559531441000,//3
        0.80048017285468775000,-1.60096034570937550000,0.80048017285468775000,//4
        0.83664272103311699000,-1.67328544206623400000,0.83664272103311699000,//5
        0.86232433179985546000,-1.72464866359971090000,0.86232433179985546000,//6
        0.88208185308457976000,-1.76416370616915950000,0.88208185308457976000,//7
        0.89479834409153958000,-1.78959668818307920000,0.89479834409153958000,//8
        0.90580704306700810000,-1.81161408613401620000,0.90580704306700810000,//9
        0.91473569176421465000,-1.82947138352842930000,0.91473569176421465000,//10
        0.99202511419562178000,-1.98405022839124360000,0.99202511419562178000,//11
        0.99275549989825684000,-1.98551099979651370000,0.99275549989825684000, //12
    };

    float BCoef[13][NCoef+1] =
    { 	0,0,0,
        0,0,0,
        1.00000000000000000000,-1.14298050259086390000,0.41280159812692763000,//2
        1.00000000000000000000,-1.41898265225711670000,0.55326988971633251000,//3
        1.00000000000000000000,-1.56101807583196690000,0.64135153808160994000,//4
        1.00000000000000000000,-1.64745998110296020000,0.70089678120942300000,//5
        1.00000000000000000000,-1.70555214556628990000,0.74365519506744815000,//6
        1.00000000000000000000,-1.74725311154080680000,0.77579080026073877000,//7
        1.00000000000000000000,-1.77863177784176000000,0.80080264668071199000,//8
        1.00000000000000000000,-1.80309328806302440000,0.82081331810739333000,//9
        1.00000000000000000000,-1.82269492521029950000,0.83718165126857014000,//10
        1.00000000000000000000,-1.98384440922924840000,0.98397386922445307000,//11
        1.00000000000000000000,-1.98519065789750290000,0.98529951312944486000//12
    };

    static float y[NCoef+1]; //output samples
    static float x[NCoef+1]; //input samples
    int n;

    //shift the old samples
    for(n=NCoef; n>0; n--) {
       x[n] = x[n-1];
       y[n] = y[n-1];
    }

    //Calculate the new output
    x[0] = NewSample;
    y[0] = ACoef[iFilter][0] * x[0];
    for(n=1; n<=NCoef; n++)
        y[0] += ACoef[iFilter][n] * x[n] - BCoef[iFilter][n] * y[n];

    return y[0];
}

float DigiDopHW::HpFilter_Q(float NewSample) {
   float ACoef[13][NCoef+1] =
    { 	0,0,0,
        0,0,0,
        0.63894570401230244000,-1.27789140802460490000,0.63894570401230244000,//2
        0.74308283559531441000,-1.48616567119062880000,0.74308283559531441000,//3
        0.80048017285468775000,-1.60096034570937550000,0.80048017285468775000,//4
        0.83664272103311699000,-1.67328544206623400000,0.83664272103311699000,//5
        0.86232433179985546000,-1.72464866359971090000,0.86232433179985546000,//6
        0.88208185308457976000,-1.76416370616915950000,0.88208185308457976000,//7
        0.89479834409153958000,-1.78959668818307920000,0.89479834409153958000,//8
        0.90580704306700810000,-1.81161408613401620000,0.90580704306700810000,//9
        0.91473569176421465000,-1.82947138352842930000,0.91473569176421465000,//10
        0.99202511419562178000,-1.98405022839124360000,0.99202511419562178000,//11
        0.99275549989825684000,-1.98551099979651370000,0.99275549989825684000 //12
    };

    float BCoef[13][NCoef+1] =
    { 	0,0,0,
        0,0,0,
        1.00000000000000000000,-1.14298050259086390000,0.41280159812692763000,//2
        1.00000000000000000000,-1.41898265225711670000,0.55326988971633251000,//3
        1.00000000000000000000,-1.56101807583196690000,0.64135153808160994000,//4
        1.00000000000000000000,-1.64745998110296020000,0.70089678120942300000,//5
        1.00000000000000000000,-1.70555214556628990000,0.74365519506744815000,//6
        1.00000000000000000000,-1.74725311154080680000,0.77579080026073877000,//7
        1.00000000000000000000,-1.77863177784176000000,0.80080264668071199000,//8
        1.00000000000000000000,-1.80309328806302440000,0.82081331810739333000,//9
        1.00000000000000000000,-1.82269492521029950000,0.83718165126857014000,//10
        1.00000000000000000000,-1.98384440922924840000,0.98397386922445307000,//11
        1.00000000000000000000,-1.98519065789750290000,0.98529951312944486000//12
    };
    static float y[NCoef+1]; //output samples
    static float x[NCoef+1]; //input samples
    int n;

    //shift the old samples
    for(n=NCoef; n>0; n--) {
       x[n] = x[n-1];
       y[n] = y[n-1];
    }

    //Calculate the new output
    x[0] = NewSample;
    y[0] = ACoef[iFilter][0] * x[0];
    for(n=1; n<=NCoef; n++)
        y[0] += ACoef[iFilter][n] * x[n] - BCoef[iFilter][n] * y[n];

    return y[0];
}
//##############################################################################
//##############################################################################
//##############################################################################
//##############################################################################
//##############################################################################
//##############################################################################
//##############################################################################



IsoDataMonitor::IsoDataMonitor(QObject *parent) :
    QObject(parent)
{
    dataMonitoring = 0;
}
/*
IsoDataMonitor::~IsoDataMonitor()
{
    return;
}*/

/******************************************************************************
 * Function:        Read()
 *
 * PreCondition:    None
 * Input:           None
 * Output:          Success
 * Side Effects:    None
 *
 * Overview:        First trial to get data from the isocronous ...
 *
 * Note:            None
 *****************************************************************************/
void IsoDataMonitor::Read(void)
{
    int data_cnt;               //

    // ### use three context running in a loop
    void *context0 = NULL;
    void *context1 = NULL;
    void *context2 = NULL;

    // ### setup isochronous -in- connections
    usb_isochronous_setup_async(hDevice, &context0, dataInEp, dataInEpSize);
    usb_isochronous_setup_async(hDevice, &context1, dataInEp, dataInEpSize);
    usb_isochronous_setup_async(hDevice, &context2, dataInEp, dataInEpSize);

    //### start of reading data ####################################################
    // do not add time hungry functions !!!
    // the queue must never become discharged !!!

    usb_submit_async(context0, (char*)pDataBuffer, dataInEpSize);
    usb_submit_async(context1, (char*)(pDataBuffer+dataInEpSize), dataInEpSize);
    usb_submit_async(context2, (char*)(pDataBuffer+2*dataInEpSize), dataInEpSize);

    while(dataMonitoring)
    {
        data_cnt = usb_reap_async(context0, 5000);          // context 0
        if (data_cnt > 0){// == dataInEpSize)
            emit sigEPData(0);//,data_cnt);
        }
        usb_submit_async(context0, (char*)pDataBuffer, dataInEpSize);

        data_cnt = usb_reap_async(context1, 5000);          // context 1
        if (data_cnt > 0){// == dataInEpSize)
            emit sigEPData(1);//,data_cnt);
        }
        usb_submit_async(context1, (char*)(pDataBuffer+dataInEpSize), dataInEpSize);

        data_cnt = usb_reap_async(context2, 5000);          // context 2
        if (data_cnt > 0){// == dataInEpSize)
            emit sigEPData(2);//,data_cnt);
        }
        usb_submit_async(context2, (char*)(pDataBuffer+2*dataInEpSize), dataInEpSize);
    }

    data_cnt = usb_reap_async(context0, 5000);              // context 0
    if (data_cnt > 0){// == dataInEpSize)
        emit sigEPData(0);//,data_cnt);
    }

    data_cnt = usb_reap_async(context1, 5000);              // context 1
    if (data_cnt > 0){// == dataInEpSize)
        emit sigEPData(1);//,data_cnt);
    }


    data_cnt = usb_reap_async(context2, 5000);              // context 2
    if (data_cnt > 0){// == dataInEpSize)
        emit sigEPData(2);//,data_cnt);
    }

    usb_free_async(&context0);
    usb_free_async(&context1);
    usb_free_async(&context2);

    emit ended();   //connect(iDM, SIGNAL(ended()), iDM, SLOT(deleteLater()));


 //   return;
}




