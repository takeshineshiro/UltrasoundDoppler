#ifndef FILTER_H
#define FILTER_H

#define int16 short
#define int8 short

/* PIC Detection: time interval constants bei Abtastrate = 200 Hz *****************************************/
#define MS80	16
#define MS95	19
#define MS150	30
#define MS200	40
#define MS360	72
#define MS450	90
#define MS1000	200
#define MS1500	300

#define WINDOW_WIDTH	MS80
#define FILTER_DELAY	21 + MS200

/* PIC Filterfunktionen ************************************************************************/

signed int16 lpfilt (signed int16 datum, int init);
signed int16 hpfilt (signed int16 datum, int init);
signed int16 deriv1( signed int16 x0, int init );
int16 mvwint(signed int16 datum, int init);
signed int16 PICQRSDet(signed int16 x, int init);


#endif // FILTER_H
