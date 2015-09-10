#include "usbwatcher.h"
#include <QTime>
#include <QtCore>

namespace USB {

    usbWatcher::usbWatcher(QObject *parent) :
        QThread(parent)
    {
        _reconnect = _connected = false;
        _isRunning = true;
    }

    void usbWatcher::run(void)
    {
        timeval tv;
        int error;
        QTime time;

        tv.tv_sec = 1;
        tv.tv_usec = 0;
        time.start();

        while(_isRunning){
            if(_reconnect){
                if(_dev != NULL){
                    _dev->disconnectFromDevice();
                }
                _connected = false;
                _reconnect = false;

            }
            if(!_connected){
                QThread::msleep(2000);
                _connected = connectToDevice();
            }
            if(_connected){
                error = libusb_handle_events_timeout(_dev->GetDeviceCtx(), &tv);
                if(error != LIBUSB_SUCCESS){
                    qDebug("...CommThread: got error %s", libusb_error_name(error));
                }
                if(time.elapsed() >= 3000){
                    _dev->pingDevice();
                    time.start();
                }
            }
        }
    }

    void usbWatcher::stop(void)
    {
        _isRunning = false;
    }

    void usbWatcher::reconnectToTarget(void)
    {
        _reconnect = true;
    }

    bool usbWatcher::connectToDevice(void)
    {
        if(_dev->connectToDevice(true)){
            emit connectionChanged(true);
            return true;
        }
        emit connectionChanged(false);
        return false;
    }

}
