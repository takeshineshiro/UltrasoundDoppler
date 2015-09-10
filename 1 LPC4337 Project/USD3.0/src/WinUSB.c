/*
 * @brief USB Band Width and WCID example descriptors.
 */

#include "app_usbd_cfg.h"
#include "chip.h"
#include "Descriptors.h"
#include <stdio.h>

/*****************************************************************************
 * Private types/enumerations/variables
 ****************************************************************************/

/*****************************************************************************
 * Public types/enumerations/variables
 ****************************************************************************/


/**
 * USB Standard Device Descriptor
 */
__attribute__ ((aligned (4))) const USB_DEVICE_DESCRIPTOR USB_DeviceDescriptor =
{
  .bLength            = USB_DEVICE_DESC_SIZE,
  .bDescriptorType    = USB_DEVICE_DESCRIPTOR_TYPE,
  .bcdUSB             = 0x0200,
  .bDeviceClass       = 0xFF,
  .bDeviceSubClass    = 0x00,
  .bDeviceProtocol    = 0x00,
  .bMaxPacketSize0    = USB_MAX_PACKET0,
  .idVendor           = 0x1FC9,
  .idProduct          = WCID_VENDOR_CODE,
  .bcdDevice          = 0x0100,
  .iManufacturer      = 0x01,
  .iProduct           = 0x02,
  .iSerialNumber      = 0x03,
  .bNumConfigurations = 0x01
};

/**
 * USB Device Qualifier
 */
__attribute__ ((aligned (4))) const USB_DEVICE_QUALIFIER_DESCRIPTOR USB_DeviceQualifier =
{
	.bLength 		 	= USB_DEVICE_QUALI_SIZE,
	.bDescriptorType 	= USB_DEVICE_QUALIFIER_DESCRIPTOR_TYPE,
	.bcdUSB			 	= 0x0200,
	.bDeviceClass 	 	= 0x00,
	.bDeviceSubClass 	= 0x00,
	.bDeviceProtocol 	= 0x00,
	.bMaxPacketSize0 	= USB_MAX_PACKET0,
	.bNumConfigurations	= 0x01,
	.bReserved			= 0x00
};

/* USB FSConfiguration Descriptor */
/*   All Descriptors (Configuration, Interface, Endpoint, Class, Vendor */
__attribute__ ((aligned (4))) USB_CONFIG_DESCRIPTOR USB_FsConfigDescriptor = {
	.Config = {
		.bLength             = USB_CONFIGURATION_DESC_SIZE,
		.bDescriptorType     = USB_CONFIGURATION_DESCRIPTOR_TYPE,
		.wTotalLength        = sizeof(USB_CONFIG_DESCRIPTOR) - 1, // exclude termination
		.bNumInterfaces      = 0x01,

		.bConfigurationValue = 0x01,
		.iConfiguration      = 0x00,
		.bmAttributes        = USB_CONFIG_BUS_POWERED,
		.bMaxPower           = USB_CONFIG_POWER_MA(100)
	},
    .Custom_Interface = {
        .bLength            = USB_INTERFACE_DESC_SIZE,
        .bDescriptorType    = USB_INTERFACE_DESCRIPTOR_TYPE,
        .bInterfaceNumber   = 0x00,
        .bAlternateSetting  = 0x00,
        .bNumEndpoints      = 0x02, //0x04,
        .bInterfaceClass    = 0xFF,
        .bInterfaceSubClass = 0xF0,
        .bInterfaceProtocol = 0x00,
        .iInterface         = 0x04
    },
	/*.BulkOUT1 = {
		.bLength          = USB_ENDPOINT_DESC_SIZE,
		.bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
		.bEndpointAddress = USB_ENDPOINT_OUT(1),
		.bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
		.wMaxPacketSize   = USB_FS_MAX_BULK_PACKET,
		.bInterval		  = 0,
	},*/
    .BulkIN1 = {
        .bLength          = USB_ENDPOINT_DESC_SIZE,
        .bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
        .bEndpointAddress = USB_ENDPOINT_IN(1),
        .bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
        .wMaxPacketSize   = USB_FS_MAX_BULK_PACKET,
        .bInterval		  = 0,
    },
	/*.BulkOUT2 = {
		.bLength          = USB_ENDPOINT_DESC_SIZE,
		.bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
		.bEndpointAddress = USB_ENDPOINT_OUT(2),
		.bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
		.wMaxPacketSize   = USB_FS_MAX_BULK_PACKET,
		.bInterval		  = 0,
	},*/
    .BulkIN2 = {
        .bLength          = USB_ENDPOINT_DESC_SIZE,
        .bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
        .bEndpointAddress = USB_ENDPOINT_IN(2),
        .bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
        .wMaxPacketSize   = USB_FS_MAX_BULK_PACKET,
        .bInterval		  = 0,
    },
    .ConfigDescTermination = 0,
};

/* USB FSConfiguration Descriptor */
/*   All Descriptors (Configuration, Interface, Endpoint, Class, Vendor */
__attribute__ ((aligned (4))) USB_CONFIG_DESCRIPTOR USB_HsConfigDescriptor = {
	.Config = {
		.bLength             = USB_CONFIGURATION_DESC_SIZE,
		.bDescriptorType     = USB_CONFIGURATION_DESCRIPTOR_TYPE,
		.wTotalLength        = sizeof(USB_CONFIG_DESCRIPTOR) - 1, // exclude termination
		.bNumInterfaces      = 0x01,

		.bConfigurationValue = 0x01,
		.iConfiguration      = 0x00,
		.bmAttributes        = USB_CONFIG_BUS_POWERED,
		.bMaxPower           = USB_CONFIG_POWER_MA(100)
	},
    .Custom_Interface = {
        .bLength            = USB_INTERFACE_DESC_SIZE,
        .bDescriptorType    = USB_INTERFACE_DESCRIPTOR_TYPE,
        .bInterfaceNumber   = 0x00,
        .bAlternateSetting  = 0x00,
        .bNumEndpoints      = 0x02, //0x04,
        .bInterfaceClass    = 0xFF,
        .bInterfaceSubClass = 0xF0,
        .bInterfaceProtocol = 0x00,
        .iInterface         = 0x04
    },
	/*.BulkOUT1 = {
		.bLength          = USB_ENDPOINT_DESC_SIZE,
		.bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
		.bEndpointAddress = USB_ENDPOINT_OUT(1),
		.bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
		.wMaxPacketSize   = USB_HS_MAX_BULK_PACKET,
		.bInterval		  = 0,
	},*/
    .BulkIN1 = {
        .bLength          = USB_ENDPOINT_DESC_SIZE,
        .bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
        .bEndpointAddress = USB_ENDPOINT_IN(1),
        .bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
        .wMaxPacketSize   = USB_HS_MAX_BULK_PACKET,
        .bInterval		  = 0,
    },
	/*.BulkOUT2 = {
		.bLength          = USB_ENDPOINT_DESC_SIZE,
		.bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
		.bEndpointAddress = USB_ENDPOINT_OUT(2),
		.bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
		.wMaxPacketSize   = USB_HS_MAX_BULK_PACKET,
		.bInterval		  = 0,
	},*/
    .BulkIN2 = {
        .bLength          = USB_ENDPOINT_DESC_SIZE,
        .bDescriptorType  = USB_ENDPOINT_DESCRIPTOR_TYPE,
        .bEndpointAddress = USB_ENDPOINT_IN(2),
        .bmAttributes     = USB_ENDPOINT_TYPE_BULK, //USB_ENDPOINT_TYPE_ISOCHRONOUS, //
        .wMaxPacketSize   = USB_HS_MAX_BULK_PACKET,
        .bInterval		  = 0,
    },
    .ConfigDescTermination = 0,
};

/* USB String Descriptor (optional) */
__attribute__ ((aligned (4))) const uint8_t USB_StringDescriptor[] = {
	/* Index 0x00: LANGID Codes */
	0x04,							/* bLength */
	USB_STRING_DESCRIPTOR_TYPE,		/* bDescriptorType */
	WBVAL(0x0407),					/* wLANGID  0x0409 = US English, 0x0407 = German (Standart)*/
	/* Index 0x01: Manufacturer */
	(9 * 2 + 2),					/* bLength (18 Char + Type + length) */
	USB_STRING_DESCRIPTOR_TYPE,		/* bDescriptorType */
	'H', 0,
	'S', 0,
	'-', 0,
	'U', 0,
	'l', 0,
	'm', 0,
	'.', 0,
	'd', 0,
	'e', 0,

	/* Index 0x02: Product */
	(18 * 2 + 2),					/* bLength (19 Char + Type + length) */
	USB_STRING_DESCRIPTOR_TYPE,		/* bDescriptorType */
	'U', 0,
	'l', 0,
	't', 0,
	'r', 0,
	'a', 0,
	's', 0,
	'o', 0,
	'n', 0,
	'i', 0,
	'c', 0,
	' ', 0,
	'D', 0,
	'o', 0,
	'p', 0,
	'p', 0,
	'l', 0,
	'e', 0,
	'r', 0,
	/* Index 0x03: Serial Number */
	(12 * 2 + 2),					/* bLength (13 Char + Type + length) */
	USB_STRING_DESCRIPTOR_TYPE,		/* bDescriptorType */
	'I', 0,
	'M', 0,
	'M', 0,
	':', 0,
	'2', 0,
	'0', 0,
	'1', 0,
	'5', 0,
	'-', 0,
	'0', 0,
	'0', 0,
	'1', 0,
	/* Index 0x04: Interface 0, Alternate Setting 0 */
	(6 * 2 + 2),					/* bLength (6 Char + Type + length) */
	USB_STRING_DESCRIPTOR_TYPE,		/* bDescriptorType */
	'S', 0,
	't', 0,
	'r', 0,
	'e', 0,
	'a', 0,
	'm', 0,
};

__attribute__ ((aligned (4))) const OS_STRING WCID_String_Descriptor = {
	.bLength = sizeof(OS_STRING),
	.bDescriptorType = USB_STRING_DESCRIPTOR_TYPE,
	.qwSignature = {'M','S','F','T','1','0','0'},
	.bMS_VendorCode = WCID_VENDOR_CODE,
	.bPad = 0
};

/* WCID USB: Microsoft Compatible ID Feature Descriptor */
__attribute__ ((aligned (4))) const OS_DESC_COMPACTID WCID_CompatID_Descriptor = {
	.Header = {
		.dwLength = sizeof(OS_DESC_COMPACTID),
		.bcdVersion = 0x0100,
		.wIndex = 0x004,
		.bCount = 0x01,
		.Reserved = {0}
	},
	.Function0 = {
		.bFirstInterfaceNumber = 0x00,
		.RESERVED = 0x01,
		.compatibleID = "WINUSB",
		.subCompatibleID = {0},
		.Reserved = {0}
	}
};

/* WCID USB: Microsoft Extended Properties Feature Descriptor */
__attribute__ ((aligned (4))) const EXT_P_OS_Feature_Desc  WCID_ExtProp_Descriptor = {
	.Header = {
		.Length =  0x0000008E,//0x000000A0, // 132 142 sizeof(EXT_P_OS_Feature_Desc), 			/* Length 246 bytes */
		.bcdVersion = 0x0100, 			/* Version 1.0 */
		.wIndex = 0x0005,				/* This is an extended property OS feature descriptor */
		.wCount = 0x0001,				/* Number of custom property sections */
	},
	.wSize = 0x00000084,				/* Length of this custom property section is 136 bytes */
	.wPropertyDataType = 0x00000001,	/* Property value stores a Unicode string */
	.wPropertyNameLength = 0x0028,		/* Length of the property name string is 42 bytes */
	.bPropertyName = {'D','e','v','i','c','e','I','n','t','e','r','f','a','c','e','G','U','I','D',0},
	.wPropertyDataLength = 0x0000004E,	/* Length of the property value string is 78 + 2 (80) bytes */
	.bPropertyData = {'{','F','7','0','2','4','2','C','7','-','F','B','2','5','-','4','4','3','B',
					  '-','9','E','7','E','-','A','4','2','6','0','F','3','7','3','9','8','2','}',0},
};

