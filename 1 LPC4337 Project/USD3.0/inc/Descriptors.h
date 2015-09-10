/*
 * Descriptors.h
 *
 *  Created on: 24.06.2015
 *      Author: Andreas
 */

#ifndef USB_DESCRIPTORS_H_
#define USB_DESCRIPTORS_H_


#include "usbd/usbd_rom_api.h"
#include "lpc_types.h"
#include "usbd/usbd.h"

/* USB descriptor arrays defined *_desc.c file */
const USB_DEVICE_DESCRIPTOR USB_DeviceDescriptor;
const USB_DEVICE_QUALIFIER_DESCRIPTOR USB_DeviceQualifier;

typedef struct
{
  USB_CONFIGURATION_DESCRIPTOR                Config;
  USB_INTERFACE_DESCRIPTOR                    Custom_Interface;
  USB_ENDPOINT_DESCRIPTOR                     BulkIN1;
  //USB_ENDPOINT_DESCRIPTOR                     BulkOUT1;
  USB_ENDPOINT_DESCRIPTOR                     BulkIN2;
  //USB_ENDPOINT_DESCRIPTOR                     BulkOUT2;
  unsigned char                               ConfigDescTermination;
} USB_CONFIG_DESCRIPTOR;

extern USB_CONFIG_DESCRIPTOR USB_HsConfigDescriptor;
extern USB_CONFIG_DESCRIPTOR USB_FsConfigDescriptor;
extern const uint8_t USB_StringDescriptor[];

/* WCID USB: Microsoft String Descriptor */
typedef PRE_PACK struct POST_PACK _OS_STRING{
	uint8_t bLength;
	uint8_t bDescriptorType;
	uint16_t qwSignature[7];
	uint8_t bMS_VendorCode;
	uint8_t bPad;
} OS_STRING;

// Extended Properties OS Feature Descriptor Header
typedef PRE_PACK struct POST_PACK _OS_DESC_COMPACTID_H{
	uint32_t dwLength;
	uint16_t bcdVersion;
	uint16_t wIndex;
	uint8_t bCount;
	uint8_t Reserved[7];
} OS_DESC_COMPACTID_H;

typedef PRE_PACK struct POST_PACK _OS_DESC_COMPACTID_F{
	uint8_t bFirstInterfaceNumber;
	uint8_t RESERVED;
	uint8_t compatibleID[8];
	uint8_t subCompatibleID[8];
	uint8_t Reserved[6];
}OS_DESC_COMPACTID_F;

typedef PRE_PACK struct POST_PACK _OS_DESC_COMPACTID{
	OS_DESC_COMPACTID_H Header;
	OS_DESC_COMPACTID_F Function0;
} OS_DESC_COMPACTID;

// Extended Properties OS Feature Descriptor Header
typedef PRE_PACK struct POST_PACK _EXT_P_OS_FD_H{
	uint32_t Length;
	uint16_t bcdVersion;
	uint16_t wIndex;
	uint16_t wCount;
} EXT_P_OS_HEADER;

typedef PRE_PACK struct POST_PACK _EXT_P_OS_FD_INTERFACEGUID{
	EXT_P_OS_HEADER Header;
	uint32_t wSize;
	uint32_t wPropertyDataType;
	uint16_t wPropertyNameLength;
	uint16_t bPropertyName[20];
	uint32_t wPropertyDataLength;
	uint16_t bPropertyData[39];
} EXT_P_OS_Feature_Desc;

extern const OS_STRING WCID_String_Descriptor;
extern const OS_DESC_COMPACTID WCID_CompatID_Descriptor;
extern const EXT_P_OS_Feature_Desc WCID_ExtProp_Descriptor;

#endif /* USB_DESCRIPTORS_H_ */
