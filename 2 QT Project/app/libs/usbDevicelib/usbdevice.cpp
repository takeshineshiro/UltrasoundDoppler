#include "usbdevice.h"
#include <cstdio>

char _msgbuffer[256];
namespace USB {
    const char* makeMassageHelper(const char *format, ...){
        va_list args;
        va_start( args, format );
        vsprintf( _msgbuffer, format, args );
        va_end( args );
        return _msgbuffer;
    }

    usbDevice::usbDevice(QObject *parent) :
        QObject(parent){
        _isConnected = false;
        _watcher = new usbWatcher(this);
        _watcher->device(this);
        const struct libusb_version* version = libusb_get_version();
        emit connectionMessageChanged(makeMassageHelper("Using libusbx v%d.%d.%d.%d", version->major, version->minor, version->micro, version->nano));

        int r = libusb_init(&_devCtx);
        if (r != LIBUSB_SUCCESS){
            emit connectionMessageChanged(makeMassageHelper("Failed to initialize libusb, got error %s", libusb_error_name(r)));
            //return false;
        }
        QObject::connect(this, SIGNAL(connectionStatus(bool)), this, SLOT(handleConnectionStatus(bool)));
        QObject::connect(_watcher, SIGNAL(connectionChanged(bool)), this, SLOT(handleConnectionStatus(bool)));
        _watcher->start();

    }

    usbDevice::~usbDevice(){
        _watcher->stop();
        _watcher->wait(4000);
        delete _watcher;
        disconnectFromDevice();
        if (_devCtx != NULL)
        {
            libusb_exit(_devCtx);
            _devCtx = NULL;
        }
    }

    bool usbDevice::connectToDevice(bool quiet){
        _devHandle = libusb_open_device_with_vid_pid(NULL, _vid, _pid);
        if (_devHandle == NULL) {
            emit connectionMessageChanged(makeMassageHelper("Failed to open device %04X:%04X", _vid, _pid));
            return false;
        }

        int r = libusb_claim_interface(_devHandle, _interface);
        if (r != LIBUSB_SUCCESS) {
            emit connectionMessageChanged(makeMassageHelper("Failed to claim device %04X:%04X, got error %s", _vid, _pid, libusb_error_name(r)));
            libusb_close(_devHandle);
            _devHandle = NULL;
            return false;
        }
        emit connectionMessageChanged(makeMassageHelper("Opened device %04X:%04X", _vid, _pid));
        getDeviceInformations(quiet);
        return true;
    }

    void usbDevice::disconnectFromDevice(){
        if (!_isConnected) return;
        _isConnected = false;
        if (_devHandle != NULL){
            /* make sure other programs can still access this device */
            /* release the interface and close the device */
            //emit connectionMessageChanged(makeMassageHelper("Releasing interface %d...", _interface);
            libusb_release_interface(_devHandle, _interface);
            libusb_close(_devHandle);
            _devHandle = NULL;
        }
    }

    bool usbDevice::pingDevice(){
        if(!_isConnected) return false;
        int ret = libusb_control_transfer(_devHandle, LIBUSB_ENDPOINT_OUT|LIBUSB_REQUEST_TYPE_VENDOR|LIBUSB_RECIPIENT_INTERFACE,
                    REQ_PING, 0, _interface, NULL, 0, 100);
        if(ret != LIBUSB_SUCCESS)
            emit connectionStatus(false);
        return ret;
    }

    void usbDevice::handleConnectionStatus(bool value){
        if(_isConnected != value){
            _isConnected = value;
            if(value){
                emit availableStatusChanged(this);
            }
            else{
                _watcher->reconnectToTarget();
                emit availableStatusChanged(this);
            }
        }
    }

    void usbDevice::getDeviceInformations(bool quiet){
        static bool alreadyProbed = false; // prevents printing everyting everytime
        libusb_device *dev;
        struct libusb_config_descriptor *conf_desc;
        const struct libusb_endpoint_descriptor *endpoint;
        const struct libusb_interface_descriptor *altsetting;
        int i, j, k, r;
        int nb_ifaces;
        unsigned char string_index[3];         // indexes of the string descriptors
        unsigned char mEndpointIn = 0, mEndpointOut = 0;  // default IN and OUT endpoints

        dev = libusb_get_device(_devHandle);
        if (!alreadyProbed) {
            unsigned char bus, port_path[8];
            struct libusb_device_descriptor dev_desc;
            const char* speed_name[5] = { "Unknown", "1.5 Mbit/s (USB LowSpeed)", "12 Mbit/s (USB FullSpeed)",
                "480 Mbit/s (USB HighSpeed)", "5000 Mbit/s (USB SuperSpeed)"};
            if(quiet){
                bus = libusb_get_bus_number(dev);
                r = libusb_get_port_numbers(dev, port_path, sizeof(port_path));
                if (r > 0) {
                    emit connectionMessageChanged(makeMassageHelper("[Device] bus: %d, port path from HCD: %d", bus, port_path[0]));
                    for (i=1; i<r; i++) {
                        emit connectionMessageChanged(makeMassageHelper("->%d", port_path[i]));
                    }
                }
            }
            r = libusb_get_device_speed(dev);
            if ((r<0) || (r>4)) r=0;
            _deviceSpeed = QString::fromUtf8(speed_name[r]);


            // emit connectionMessageChanged(makeMassageHelper("[Device] Reading device descriptor:"));
            r = libusb_get_device_descriptor(dev, &dev_desc);
            if (r != LIBUSB_SUCCESS) {
                emit connectionMessageChanged(makeMassageHelper("Failed to get device descriptor, got error %s", libusb_error_name(r)));
                return;
            }
            // Copy the string descriptors for easier parsing
            string_index[0] = dev_desc.iManufacturer;
            string_index[1] = dev_desc.iProduct;
            string_index[2] = dev_desc.iSerialNumber;
            if(quiet){
                emit connectionMessageChanged(makeMassageHelper("[Device]             length: %d", dev_desc.bLength));
                emit connectionMessageChanged(makeMassageHelper("[Device]       device class: %d", dev_desc.bDeviceClass));
                emit connectionMessageChanged(makeMassageHelper("[Device]                S/N: %d", dev_desc.iSerialNumber));
                emit connectionMessageChanged(makeMassageHelper("[Device]            VID:PID: %04X:%04X", dev_desc.idVendor, dev_desc.idProduct));
                emit connectionMessageChanged(makeMassageHelper("[Device]          bcdDevice: %04X", dev_desc.bcdDevice));
                emit connectionMessageChanged(makeMassageHelper("[Device]    iMan:iProd:iSer: %d:%d:%d", dev_desc.iManufacturer, dev_desc.iProduct, dev_desc.iSerialNumber));
                emit connectionMessageChanged(makeMassageHelper("[Device]           nb confs: %d", dev_desc.bNumConfigurations));
                emit connectionMessageChanged(makeMassageHelper("\n[Device] Reading configuration descriptors:"));
            }
        }

        r = libusb_get_config_descriptor(dev, 0, &conf_desc);
        if (r != LIBUSB_SUCCESS) {
            emit connectionMessageChanged(makeMassageHelper("[Device] Failed to get device descriptor, got error %s", libusb_error_name(r)));
            return;
        }
        if(quiet){
            nb_ifaces = conf_desc->bNumInterfaces;
            if (!alreadyProbed) {
                emit connectionMessageChanged(makeMassageHelper("[Device]              nb interfaces: %d", nb_ifaces));
            }
            for (i=0; i<nb_ifaces; i++) {
                if (!alreadyProbed) {
                    emit connectionMessageChanged(makeMassageHelper("[Device]               interface[%d]: id = %d", i,
                        conf_desc->interface[i].altsetting[0].bInterfaceNumber));
                }
                for (j=0; j<conf_desc->interface[i].num_altsetting; j++) {
                    altsetting = &conf_desc->interface[i].altsetting[j];
                    if (!alreadyProbed) {
                        emit connectionMessageChanged(makeMassageHelper("[Device] interface[%d].altsetting[%d]: num endpoints = %d",
                            i, j, altsetting->bNumEndpoints));
                        emit connectionMessageChanged(makeMassageHelper("[Device]    Class.SubClass.Protocol: %02X.%02X.%02X",
                            altsetting->bInterfaceClass,
                            altsetting->bInterfaceSubClass,
                            altsetting->bInterfaceProtocol));
                    }
                    for (k=0; k<altsetting->bNumEndpoints; k++) {
                        endpoint = &altsetting->endpoint[k];
                        if (!alreadyProbed) {
                            emit connectionMessageChanged(makeMassageHelper("[Device]        endpoint[%d].address: %02X", k, endpoint->bEndpointAddress));
                        }

                        // Use the first interrupt or bulk IN/OUT endpoints as default for testing
                        if ((endpoint->bmAttributes & LIBUSB_TRANSFER_TYPE_MASK) & (LIBUSB_TRANSFER_TYPE_BULK | LIBUSB_TRANSFER_TYPE_INTERRUPT)) {
                            _max_packet_sizes.insert(make_pair(endpoint->bEndpointAddress, libusb_get_max_iso_packet_size(dev, endpoint->bEndpointAddress)));
                            if (endpoint->bEndpointAddress & LIBUSB_ENDPOINT_IN) {
                                emit connectionMessageChanged(makeMassageHelper("[Device]      endpoint[%d].Direction: IN", k));
                                if (!mEndpointIn) {
                                    mEndpointIn = endpoint->bEndpointAddress;
                                }
                            } else {
                                emit connectionMessageChanged(makeMassageHelper("[Device]      endpoint[%d].Direction: OUT", k));
                                if (!mEndpointOut) {
                                    mEndpointOut = endpoint->bEndpointAddress;
                                }
                            }
                        }
                        if (!alreadyProbed) {
                            emit connectionMessageChanged(makeMassageHelper("[Device]            max packet size: %d bytes", endpoint->wMaxPacketSize));
                            if(endpoint->bInterval != 0)
                                emit connectionMessageChanged(makeMassageHelper("[Device]           polling interval: %d ms", endpoint->bInterval));
                            else
                                emit connectionMessageChanged(makeMassageHelper("[Device]           polling interval: ignored"));
                        }
                    }
                }
            }
        }

        libusb_free_config_descriptor(conf_desc);
        if (alreadyProbed) return;

        char string[128];
        if(quiet)
            emit connectionMessageChanged(makeMassageHelper("\n[Device] Reading string descriptors:"));
        for (i=0; i<3; i++) {
            if (string_index[i] == 0) {
                continue;
            }
            if (libusb_get_string_descriptor_ascii(_devHandle, string_index[i], (unsigned char*)string, 128) >= 0) {
                _Descriptors[i] = QString::fromUtf8(string);
                if(quiet){
                    emit connectionMessageChanged(makeMassageHelper("[Device]    String (0x%02X): \"%s\"", string_index[i], string));
                }
            }
        }
        // Read the OS String Descriptor
        if (libusb_get_string_descriptor_ascii(_devHandle, 0xEE, (unsigned char*)string, 128) >= 0) {
            _Descriptors[3] = QString::fromUtf8(string);
            if(quiet){
                emit connectionMessageChanged(makeMassageHelper("[Device]    String (0x%02X): \"%s\"", 0xEE, string));
            }
        }

        // Get some info from target. This is just an example
        unsigned int speed = 0;
        r = libusb_control_transfer(_devHandle, LIBUSB_ENDPOINT_IN|LIBUSB_REQUEST_TYPE_VENDOR|LIBUSB_RECIPIENT_INTERFACE,
                REQ_GET_PLL_SPEED, 0, _interface, (unsigned char*)&speed, sizeof(speed), 100);
        if (r == sizeof(speed)) {
            _PLL_Speed = QString::fromUtf8(makeMassageHelper("%u MHz", speed/1000000));
            if(quiet)
                emit connectionMessageChanged(makeMassageHelper("[Device] MCU PLL is running at %u MHz", speed/1000000));
        } else
            emit connectionMessageChanged(makeMassageHelper("[Device] Failed to get speed, error %s (%d)", libusb_error_name(r), r));
        unsigned char manufactor[20];
        r = libusb_control_transfer(_devHandle, LIBUSB_ENDPOINT_IN|LIBUSB_REQUEST_TYPE_VENDOR|LIBUSB_RECIPIENT_INTERFACE,
                REQ_MANUFACTOR, 0, _interface, (unsigned char*)&manufactor, sizeof(manufactor), 100);
        if (r == sizeof(manufactor)) {
            qDebug() << manufactor;
        }
        alreadyProbed = true;
    }
}
