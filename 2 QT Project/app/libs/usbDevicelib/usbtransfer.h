#ifndef USBTRANSFER_H
#define USBTRANSFER_H

#include "libusb/libusb.h"
#include <vector>

using namespace std;

namespace USB{

/**
 * @brief Device Transfer enum
 *
 * This enum declares the possible USB-Transfers
 */
typedef enum
{
    INTERRUPT   = 1, /**< Device Transfertype Interrupt */
    BULK        = 2, /**< Device Transfertype Bulk */
    ISOCHRON    = 3, /**< Device Transfertype Isochron */
    CONTROL     = 4  /**< Device Transfertype Control */
} device_transfers_t;

template<device_transfers_t transfertype> class usbAsyncTransfer {
public:
    usbAsyncTransfer() { _transfer = libusb_alloc_transfer(0); _callback = NULL;}
    ~usbAsyncTransfer() { libusb_free_transfer(_transfer); _transfer = NULL; }

    class usbAsyncTransfer * devHandle(libusb_device_handle* devHandle) { _devHandle = devHandle;       return this; }
    class usbAsyncTransfer * endpoint(unsigned char point)              { _ep = point;                  return this; }
    class usbAsyncTransfer * data(unsigned char* data, int size)        { _data = data; _size = size;   return this; }
    class usbAsyncTransfer * timeout(unsigned int time = 100)           { _timeout = time;              return this; }
    class usbAsyncTransfer * userdata(void * ctx)                       { _userData = ctx;              return this; }
    class usbAsyncTransfer * isoPackets(int size)                       { _isoSize = size;              return this; }
    class usbAsyncTransfer * attach_cb(libusb_transfer_cb_fn cb)        { _callback = cb;               return this; }

    unsigned char endpoint(void)            { return endpoint; }

    unsigned int timeout(void)              { return _timeout;  }

    struct libusb_transfer* transfer(void)  { return _transfer; }

    template<libusb_request_type reqtype>

    inline int TransmitSetupPackage(unsigned char bRequest,
                                    unsigned short wValue,
                                    unsigned short wIndex = 0,
                                    unsigned short wLength = 0) {
        return libusb_control_transfer(_devHandle,
                                       reqtype,
                                       bRequest,
                                       wValue,
                                       wIndex,
                                       NULL,
                                       wLength,
                                       _timeout);
    }

    void prepair(void) {
        switch(transfertype)
        {
        case INTERRUPT: libusb_fill_interrupt_transfer(_transfer, _devHandle, _ep, _data, _size, _callback, _userData, _timeout);
            break;
        case BULK:           libusb_fill_bulk_transfer(_transfer, _devHandle, _ep, _data, _size, _callback, _userData, _timeout);
            break;
        case ISOCHRON:        libusb_fill_iso_transfer(_transfer, _devHandle, _ep, _data, _size, _isoSize , _callback, _userData, _timeout);
            break;
        case CONTROL: break;
        }
    }

    const char* getAsyncTransferErrorString()
    {
        switch (_transfer->status)
        {
        case LIBUSB_TRANSFER_COMPLETED: return "LIBUSB_TRANSFER_COMPLETED";
        case LIBUSB_TRANSFER_ERROR:     return "LIBUSB_TRANSFER_ERROR";

        case LIBUSB_TRANSFER_STALL:
        case LIBUSB_TRANSFER_TIMED_OUT: return "The USB communication with the hardware timed out!\n\n" \
                    "This could be because the number of signals to capture in combination with the sample rate " \
                    "is too high (i.e. the hardware does not have time to process it all).\n\n" \
                    "Continuous attempts will be made to reestablish the connection. If the " \
                    "status hasn't changed in ca 10 seconds, unplug the USB cable " \
                    "from the hardware and then insert it again.";

        case LIBUSB_TRANSFER_CANCELLED: return "LIBUSB_TRANSFER_CANCELLED";
        case LIBUSB_TRANSFER_NO_DEVICE: return "LIBUSB_TRANSFER_NO_DEVICE";
        case LIBUSB_TRANSFER_OVERFLOW:  return "LIBUSB_TRANSFER_OVERFLOW";
        default:                        return "Unknown error code";
        }
    }

    int submitAsyncTransfer(){
        prepair();
        if(transfertype == CONTROL) return 0;
        return libusb_submit_transfer(_transfer);
    }

    operator int(){ return submitAsyncTransfer(); }

private:
    struct libusb_transfer* _transfer; /**< TODO */
    libusb_device_handle* _devHandle; /**< TODO */
    libusb_transfer_cb_fn _callback; /**< TODO */
    unsigned char* _data; /**< TODO */
    int _size; /**< TODO */
    unsigned char _ep; /**< TODO */
    unsigned int _timeout; /**< TODO */
    void * _userData = NULL; /**< TODO */
    int _isoSize; /**< TODO */
};
}

#endif // USBTRANSFER_H


