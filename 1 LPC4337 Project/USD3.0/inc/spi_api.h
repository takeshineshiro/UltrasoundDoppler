/*
 * spi_api.h
 *
 *  Created on: 24.06.2015
 *      Author: Andreas
 */

#ifndef SPI_SPI_API_H_
#define SPI_SPI_API_H_

#include "chip.h"

#define SSP_DATA_BITS                       (SSP_BITS_8)
#define SSP_DATA_BIT_NUM(databits)          (databits+1)
#define SSP_DATA_BYTES(databits)            (((databits) > SSP_BITS_8) ? 2:1)
#define SSP_LO_BYTE_MSK(databits)           ((SSP_DATA_BYTES(databits) > 1) ? 0xFF:(0xFF>>(8-SSP_DATA_BIT_NUM(databits))))
#define SSP_HI_BYTE_MSK(databits)           ((SSP_DATA_BYTES(databits) > 1) ? (0xFF>>(16-SSP_DATA_BIT_NUM(databits))):0)

typedef struct SPI_API_T* SPI_API_PTR;
struct SPI_API_T{
	uint32_t (*write16bit)(uint16_t *txbuff, uint32_t transferSize);
	uint32_t (*transfer16bit)(uint16_t *txbuff, uint16_t *rxbuff, uint32_t transferSize);
};

SPI_API_PTR SPI_API_CREATE();
void SPI_API_DESTROY(SPI_API_PTR);

#endif /* SPI_SPI_API_H_ */
