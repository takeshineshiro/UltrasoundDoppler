/**
 * @file usbwatcher.h
 * @author Andreas Rehn (rehn.andreas86@gmail.com)
 * @date 03 11 2014
 *
 * @brief Function prototypes for the watcher driver
 *
 *  This contains the prototypes for the watcher
 *  driver and eventually any macros, constants,
 *  or global variables you will need.
 *
 * @bug No known bugs.
 *
 */

#ifndef USBWATCHER_H
#define USBWATCHER_H

#include <QThread>
#include "usbdevice.h"

/*!
 *  \addtogroup USB
 *  @{
 */

//! Generic USB interfaces and abstractions
namespace USB {

//! Describes the USB Device interface
class usbDevice;

/**
 * @brief handles the connection of an device in an new thread
 * this class is an extention for watching devices and their connections
 * so
 *
 */
class usbWatcher : public QThread
{
    Q_OBJECT
public:
    /**
     * @brief instanciate a new Instance
     * @code
     * usbWatcher* _watcher = new usbWatcher(this);
     * @endcode
     *
     * @param parent Instance, which handles the delete control
     */
    explicit usbWatcher(QObject *parent = 0);

    /**
     * @brief permit the Device for watching
     * The Watcher needs an Device, so they can use the device functions to get the status
     *
     * @code
     * _watcher->device(this);
     * @endcode
     *
     * @param dev Device to watching
     * @return usbWatcher returns this instance
     */
    class usbWatcher * device(usbDevice* dev) { _dev = dev; return this; }

    /**
     * @brief instanitate the watcher thread
     * start whatching for device connection and changes
     *
     * @code
     * _watcher->device(this);
     * _watcher->start();
     * @endcode
     */
    void run(void);
    /**
     * @brief stops the thread
     * automaticly called, if parent object is deleted.
     *
     */
    void stop(void);
    /**
     * @brief reconnect the target Device
     * is called internally but can called for special uses
     *
     */
    void reconnectToTarget(void);
    /**
     * @brief get Device connection status
     *
     * @retval true Device is connected
     * @retval false Device is disconnected
     */
    bool isConnected(void) { return _connected; }

signals:
    /**
     * @brief Signals new Deviceconnection
     * Signals the new Connectionstatus of the watching Device
     * only fired, if the Status changes
     *
     * @param[out] value device connection status
     */
    void connectionChanged(bool value);

private:
    usbDevice* _dev; /**< Devicepointer for Watcher */
    bool _isRunning; /**< Running State - is the Device still Running? */
    bool _reconnect; /**< reconnect State - is an reconnect requiered? */
    bool _connected; /**< connected State - The Device is connected */

    /**
     * @brief Connect the Device and emit Signal
     *
     * Check if the Device can be connected and emit the result throuth
     *
     * @retval true Device is connected
     * @retval false Device is disconnected
     */
    bool connectToDevice(void);
};

} // End namespace USB

/*! @} End of Doxygen Groups*/

#endif // USBWATCHER_H

