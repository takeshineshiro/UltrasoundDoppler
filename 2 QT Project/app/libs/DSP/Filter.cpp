#include <string.h>
#include <math.h>
#include "Filter.h"


/***********************************************************************
    Filterfunktionen zur Detektion des QRS Komplexes im EKG
************************************************************************/

int LowPassFilter (int data){
    static int y1 = 0, y2 = 0, x[26], n = 12;
    int y0;

    x[n] = x[n+13] = data;
    y0 = (y1 << 1) - y2 + x[n] - (x[n+6] << 1) + x[n+12];
    y2 = y1;
    y1 = y0;
    y0 >>= 5;
    if (--n < 0)
        n = 12;

    return (y0);
}

int HighPassFilter (int data){
    static int y1 = 0, x[66], n = 32;
    int y0;

    x[n] = x[n+33] = data;
    y0 = y1 + x[n] - x[n+32];
    y1 = y0;

    if(--n < 0)
        n = 32;

    y0 = x [n+16] - (y0 >> 5);

    return (y0);
}

int Derivative(int data){
    int y, i;
    static int x_derv[4];

    y = (data << 1) + x_derv[3] - x_derv[1] - (x_derv[0] << 1);
    y >>= 3;
    for (i = 0; i < 3; i++)
        x_derv[i] = x_derv[i+1];
    x_derv[3] = data;

    return(y);
}

int MovingWindowIntegral (int data){
    static int x[32], ptr = 0;
    static long sum = 0;
    long ly;
    int y;

    if (++ptr == 32)
        ptr = 0;
    sum -= x[ptr];
    sum += data;
    x[ptr] = data;
    ly = sum >> 5;
    if (ly > 32400)
        y = 32400;
    else
        y = (int) ly;

    return(y);
}

int QRSFilter(int data){

    int y;

    y = LowPassFilter(data);
    y = HighPassFilter(y);
    y = Derivative(y);
    y = y * y;
    y = MovingWindowIntegral(y);

    return (y);
}

/***********************************************************************
    PIC Filterfunktionen zur Detektion des QRS Komplexes
************************************************************************/

signed int16 lpfilt (signed int16 datum, int init ){
            static signed int16 y1 = 0, y2 = 0 ;
            static signed int16 d0,d1,d2,d3,d4,d5,d6,d7,d8,d9 ;
            signed int16 y0 ;
            signed int16 output ;

            if(init)
                    {
                    d0=d1=d2=d3=d4=d5=d6=d7=d8=d9=0 ;
                    y1 = y2 = 0 ;
                    }

            y0 = (y1 << 1) - y2 + datum - (d4<<1) + d9 ;
            y2 = y1;
            y1 = y0;
            if(y0 >= 0) output = y0 >> 5;
            else output = (y0 >> 5) | 0xF800 ;

            d9=d8 ;
            d8=d7 ;
            d7=d6 ;
            d6=d5 ;
            d5=d4 ;
            d4=d3 ;
            d3=d2 ;
            d2=d1 ;
            d1=d0 ;
            d0=datum ;

            return(output) ;
}

#define HPBUFFER_LGTH	32

signed int16 hpfilt( signed int16 datum, int init )
        {
        static signed int16 y=0 ;
        static signed int16 data[HPBUFFER_LGTH] ;
        static int ptr = 0 ;
        signed int16 z ;
        int halfPtr ;

        if(init)
                {
                for(ptr = 0; ptr < HPBUFFER_LGTH; ++ptr)
                        data[ptr] = 0 ;
                ptr = 0 ;
                y = 0 ;
                return(0) ;
                }

        y += datum - data[ptr];

        halfPtr = ptr-(HPBUFFER_LGTH/2) ;
        halfPtr &= 0x1F ;


        z = data[halfPtr] ;		// Compensate for CCS shift bug.
        if(y >= 0) z -= (y>>5) ;
        else z -= (y>>5)|0xF800 ;


        data[ptr] = datum ;
        ptr = (ptr+1) & 0x1F ;

        return( z );
        }

signed int16 deriv1( signed int16 x0, int init )
        {
        static signed int16 x1, x2, x3, x4 ;
        signed int16 output;
        if(init)
                x1 = x2 = x3 = x4 = 0 ;

        output = x1-x3 ;
        if(output < 0) output = (output>>1) | 0x8000 ;	// Compensate for shift bug.
        else output >>= 1 ;

        output += (x0-x4) ;
        if(output < 0) output = (output>>1) | 0x8000 ;
        else output >>= 1 ;


        x4 = x3 ;
        x3 = x2 ;
        x2 = x1 ;
        x1 = x0 ;
        return(output);
        }

int16 mvwint(signed int16 datum, int init)
        {
        static unsigned int16 sum = 0 ;
        static unsigned int d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15 ;

        if(init)
                {
                d0=d1=d2=d3=d4=d5=d6=d7=d8=d9=d10=d11=d12=d13=d14=d15=0 ;
                sum = 0 ;
                }
        sum -= d15 ;

        d15=d14 ;
        d14=d13 ;
        d13=d12 ;
        d12=d11 ;
        d11=d10 ;
        d10=d9 ;
        d9=d8 ;
        d8=d7 ;
        d7=d6 ;
        d6=d5 ;
        d5=d4 ;
        d4=d3 ;
        d3=d2 ;
        d2=d1 ;
        d1=d0 ;
        if(datum >= 0x0400) d0 = 0x03ff ;
        else d0 = (datum>>2) ;
        sum += d0 ;

        return(sum>>2) ;
        }

/***********************************************************************
    PIC QRS Detektion
************************************************************************/

// Global values for QRS detector.

int16 Q0 = 0, Q1 = 0, Q2 = 0, Q3 = 0, Q4 = 0, Q5 = 0, Q6 = 0, Q7 = 0 ;
int16 N0 = 0, N1 = 0, N2 = 0, N3 = 0, N4 = 0, N5 = 0, N6 = 0, N7 = 0 ;
int16 RR0=0, RR1=0, RR2=0, RR3=0, RR4=0, RR5=0, RR6=0, RR7=0 ;
int16 QSum = 0, NSum = 0, RRSum = 0 ;
int16 det_thresh, sbcount ;

int16 tempQSum, tempNSum, tempRRSum ;

int16 QN0=0, QN1=0 ;
int Reg0=0 ;

/**************************************************************
* peak() takes a datum as input and returns a peak height
* when the signal returns to half its peak height, or it has been
* 95 ms since the peak height was detected.
**************************************************************/
signed int16 Peak( signed int16 datum, int init )
        {
        static signed int16 max = 0, lastDatum ;
        static int timeSinceMax = 0 ;
        signed int16 pk = 0 ;

        if(init)        // Initialisierung, Variablen zurück setzen
                {
                max = 0 ;
                timeSinceMax = 0 ;
                return(0) ;
                }

        if(timeSinceMax > 0)
                ++timeSinceMax ;

        if((datum > lastDatum) && (datum > max))    // ist der aktuelle Wert größer als der Vorherige?
                {
                max = datum ;                       // dann ist der aktuelle Wert ein Maximum
                if(max > 2)
                        timeSinceMax = 1 ;
                }

        else if(datum < (max >> 1)) // ist der aktuelle Wert größer als die Hälfte, max/2?
                {
                pk = max ;
                max = 0 ;
                timeSinceMax = 0 ;
                }

        else if(timeSinceMax > MS95)
                {
                pk = max ;
                max = 0 ;
                timeSinceMax = 0 ;
                }
        lastDatum = datum ; // der aktuelle Wert ist für den nächsten Durchgang der vorherige Wert
        return(pk) ;
        }

/**************************************************************************
*  UpdateQ takes a new QRS peak value and updates the QRS mean estimate
*  and detection threshold.
**************************************************************************/
void UpdateQ(int16 newQ)
        {

        QSum -= Q7 ;
        Q7=Q6; Q6=Q5; Q5=Q4; Q4=Q3; Q3=Q2; Q2=Q1; Q1=Q0;
        Q0=newQ ;
        QSum += Q0 ;

        det_thresh = QSum-NSum ;
        det_thresh = NSum + (det_thresh>>1) - (det_thresh>>3) ;

        det_thresh >>= 3 ;
        }

/**************************************************************************
*  UpdateRR takes a new RR value and updates the RR mean estimate
**************************************************************************/

void UpdateRR(int16 newRR)
        {
        RRSum -= RR7 ;
        RR7=RR6; RR6=RR5; RR5=RR4; RR4=RR3; RR3=RR2; RR2=RR1; RR1=RR0 ;
        RR0=newRR ;
        RRSum += RR0 ;

        sbcount=RRSum+(RRSum>>1) ;
        sbcount >>= 3 ;
        sbcount += WINDOW_WIDTH ;
        }

/**************************************************************************
*  UpdateN takes a new noise peak value and updates the noise mean estimate
*  and detection threshold.
**************************************************************************/

void UpdateN(int16 newN)
        {
        NSum -= N7 ;
        N7=N6; N6=N5; N5=N4; N4=N3; N3=N2; N2=N1; N1=N0; N0=newN ;
        NSum += N0 ;

        det_thresh = QSum-NSum ;
        det_thresh = NSum + (det_thresh>>1) - (det_thresh>>3) ;

        det_thresh >>= 3 ;
        }

/******************************************************************************
*  PICQRSDet takes 16-bit ECG samples (5 uV/LSB) as input and returns the
*  detection delay when a QRS is detected.  Passing a nonzero value for init
*  resets the QRS detector.
******************************************************************************/
signed int16 PICQRSDet(signed int16 x, int init)
        {
        static int16 tempPeak, initMax ;
        static int8 preBlankCnt=0, qpkcnt=0, initBlank=0 ;
        static int16 count, sbpeak, sbloc ;
        int16 QrsDelay = 0 ;
        int16 temp0, temp1 ;

        if(init)        // Initialisierung, Variablen weden zurück gesetzt
                {
                hpfilt(0,1) ;
                lpfilt(0,1) ;
                deriv1(0,1) ;
                mvwint(0,1) ;
                Peak(0,1) ;
                qpkcnt = count = sbpeak = 0 ;
                QSum = NSum = 0 ;

                RRSum = MS1000<<3 ;
                RR0=RR1=RR2=RR3=RR4=RR5=RR6=RR7=MS1000 ;

                Q0=Q1=Q2=Q3=Q4=Q5=Q6=Q7=0 ;
                N0=N1=N2=N3=N4=N5=N6=N7=0 ;
                NSum = 0 ;

                return(0) ;
                }

        x = lpfilt(x,0) ;   // Tiefpassfilterung
        x = hpfilt(x,0) ;   // Hochpassfilterung
        x = deriv1(x,0) ;   // Wert ableiten
        if(x < 0)      // negative Werte werden positiv ausgegeben,
            x = -x ;  // keine Quadrierung, zur vermeiden großen Rechnenaufwand
        x = mvwint(x,0) ;   // Moving Average Filter
        x = Peak(x,0) ; // Peak wird gesucht

        // Hold any peak that is detected for 200 ms
        // in case a bigger one comes along.  There
        // can only be one QRS complex in any 200 ms window.

        if(!x && !preBlankCnt)
                x = 0 ;

        else if(!x && preBlankCnt)	// If we have held onto a peak for
                {			// 200 ms pass it on for evaluation.
                if(--preBlankCnt == 0)
                        x = tempPeak ;
                else x = 0 ;
                }

        else if(x && !preBlankCnt)	// If there has been no peak for 200 ms
                {			// save this one and start counting.
                tempPeak = x ;
                preBlankCnt = MS200 ;
                x = 0 ;
                }

        else if(x)				// If we were holding a peak, but
                {				// this ones bigger, save it and
                if(x > tempPeak)		// start counting to 200 ms again.
                        {
                        tempPeak = x ;
                        preBlankCnt = MS200 ;
                        x = 0 ;
                        }
                else if(--preBlankCnt == 0)
                        x = tempPeak ;
                else x = 0 ;
                }

        // Initialize the qrs peak buffer with the first eight
        // local maximum peaks detected.

        if( qpkcnt < 8 )
                {
                ++count ;
                if(x > 0) count = WINDOW_WIDTH ;
                if(++initBlank == MS1000)
                        {
                        initBlank = 0 ;
                        UpdateQ(initMax) ;
                        initMax = 0 ;
                        ++qpkcnt ;
                        if(qpkcnt == 8)
                                {
                                RRSum = MS1000<<3 ;
                                RR0=RR1=RR2=RR3=RR4=RR5=RR6=RR7=MS1000 ;

                                sbcount = MS1500+MS150 ;
                                }
                        }
                if( x > initMax )
                        initMax = x ;
                }

        else
                {
                ++count ;

                // Check if peak is above detection threshold.

                if(x > det_thresh)
                        {
                        UpdateQ(x) ;    // updates the QRS mean estimate and detection threshold

                        // Update RR Interval estimate and search back limit

                        UpdateRR(count-WINDOW_WIDTH) ; // updates the RR mean estimate
                        count=WINDOW_WIDTH ;
                        sbpeak = 0 ;
                        QrsDelay = WINDOW_WIDTH+FILTER_DELAY ;  // QrsDelay = 77
                        }

                // If a peak is below the detection threshold.

                else if(x != 0)
                        {
                        UpdateN(x) ;    //updates the noise mean estimate and detection threshold

                        QN1=QN0 ;
                        QN0=count ;

                        if((x > sbpeak) && ((count-WINDOW_WIDTH) >= MS360))
                                {
                                sbpeak = x ;
                                sbloc = count-WINDOW_WIDTH ;
                                }

                        }

                // Test for search back condition.  If a QRS is found in
                // search back update the QRS buffer and det_thresh.

                if((count > sbcount) && (sbpeak > (det_thresh >> 1)))
                        {
                        UpdateQ(sbpeak) ;

                        // Update RR Interval estimate and search back limit

                        UpdateRR(sbloc) ;

                        QrsDelay = count = count - sbloc;
                        QrsDelay += FILTER_DELAY ;
                        sbpeak = 0 ;
                        }
                }


        return(QrsDelay) ;
        }
