/**
 * @file usbdevice.h
 * @author Andreas Rehn (rehn.andreas86@gmail.com)
 * @date 03 11 2014
 *
 * @brief Function prototypes for usb devices
 *
 *  This contains the prototypes for usb devices
 *  and eventually any macros, constants,
 *  or global variables you will need.
 *
 * @bug No known bugs.
 *
 */

#ifndef USBDEVICE_H
#define USBDEVICE_H

#include <QObject>
#include <QtCore>

#include "libusb/libusb.h"
#include "usbtransfer.h"
#include "usbwatcher.h"

namespace USB {

class usbWatcher;

typedef enum
{
    REQ_PING          = 0, /*!< Ping to indicate active line */
    REQ_GET_PLL_SPEED = 1, /*!< Request for the speed of PLL */
    REQ_MANUFACTOR    = 2, /*!< Request for the device manufactor */
    REQ_VERSION       = 3, /*!< Request for the device version */

} control_requests_t;


class usbDevice : public QObject
{
    Q_OBJECT
public:
    explicit usbDevice(QObject *parent = 0);
    virtual ~usbDevice();

    virtual QString name() const = 0;
    bool isAvailable() { return _isConnected; }

    class usbDevice * vid(unsigned short vendor_id)     { _vid = vendor_id;         return this; }
    class usbDevice * pid(unsigned short product_id)    { _pid = product_id;        return this; }
    class usbDevice * interface(int interface)          { _interface = interface;   return this; }

    libusb_context* GetDeviceCtx(void)  { return _devCtx; }
    unsigned short vendor_id(void)      { return _vid; }
    unsigned short product_id(void)     { return _pid; }
    int interface(void)                 { return _interface; }
    QString DeviceSpeed(void)           { return _deviceSpeed; }
    QString PLLSpeed(void)              { return _PLL_Speed; }
    QString Descriptor(int index)       { if(index > 4) return ""; return _Descriptors[index]; }
    bool Isconnected(void)         { return _isConnected; }

    bool connectToDevice(bool quiet);
    void disconnectFromDevice(void);
    bool pingDevice();

signals:
    void availableStatusChanged(usbDevice* dev);
    void connectionMessageChanged(const char* msg);
    void connectionStatus(bool value);
public slots:
    void handleConnectionStatus(bool value);
protected:
    libusb_device_handle* _devHandle; /**< TODO */
    libusb_context* _devCtx; /**< TODO */
    usbWatcher* _watcher; /**< TODO */
    bool _isConnected = false; /**< TODO */

private:
    unsigned short _vid;
    unsigned short _pid;
    int _interface;

    QString _deviceSpeed;
    QString _Descriptors[4];
    QString _PLL_Speed;
    map<unsigned char, int> _max_packet_sizes;

    void getDeviceInformations(bool quiet);
};

}
#endif // USBDEVICE_H
