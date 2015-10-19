//---------------------------------------------------------------------------
//#include <vcl\vcl.h>
#include <stdlib.h>
#include <math.h>

#include "FFT.h"


//---------------------------------------------------------------------------
void __fastcall fft_func(QVector<double> *realbuffi, QVector<double> *imagbuffi, unsigned short FFTPunkte, short richtung)
{
     double wr,wi,tr,ti;
     unsigned short i,j,l,step,m,mr;
     double temp;
     div_t x;
     QVector<double> realbuf, imagbuf;

     realbuf.resize(FFTPunkte);
     imagbuf.resize(FFTPunkte);

     realbuf = *realbuffi;
     imagbuf = *imagbuffi;

     mr = 0;

     for(i = 0; i <FFTPunkte; i++)
     {
         //Hamming-Fensterung
         realbuf[i] = realbuf[i]*(1.-1.*cos(2.* M_PI *i /(double)FFTPunkte))/2.;
         imagbuf[i]=0;
     }


     // Bit Reversed  Vertauschung
     for (m = 1 ; m < FFTPunkte ; m++)
     {
         l = FFTPunkte;
         l = l / 2;
         while (mr + l > FFTPunkte-1)
              l = l / 2;
         x = div(mr,l);
         mr = x.rem + l;
         if (mr > m)
         {
             temp = realbuf[m];
             realbuf[m] = realbuf[mr];
             realbuf[mr]= temp;
             temp = imagbuf[m];
             imagbuf[m] = imagbuf[mr];
             imagbuf[mr] = temp;
         }
     }
     // Ende der Vertauschung und Beginn der eigentlichen FFT
     l=1;

     while (l < FFTPunkte)
     {
         step = 2 * l;
         for (m = 0 ; m < l ; m++)
         {
             wr = cos( M_PI * (double)m /(double)l );
             // Beim Imaginärteil bestimmt die Richtung das Vorzeichen
             wi = sin( (double)richtung * M_PI * (double)m / (double)l );
             for (i = m ; i < FFTPunkte ; i = i + step)
             {
                 j = i + l;
                 tr = realbuf[j] * wr - imagbuf[j] * wi;
                 ti = realbuf[j] * wi + imagbuf[j] * wr;
                 realbuf[j] = realbuf[i] - tr;
                 imagbuf[j] = imagbuf[i] - ti;
                 realbuf[i] = realbuf[i] + tr;
                 imagbuf[i] = imagbuf[i] + ti;
             }
         }
         l = step;
     }

  // Falls vom Frequenz- in den Zeitbereich transformiert wurde, müssen
  // alle F(k) noch durch die Anzahl der Punkte dividiert werden
  if (richtung == 1)
  {
      for (i=0 ; i < FFTPunkte ; i++)
      {
          realbuf[i] = realbuf[i] / (double)FFTPunkte;
          imagbuf[i] = imagbuf[i] / (double)FFTPunkte;
      }
  }

  *realbuffi= realbuf;
  *imagbuffi = imagbuf;
}

//---------------------------------------------------------------------------
/* Funktion zur Berechnung des Betrags */
void __fastcall betrag_ber (QVector<double> *realbuffi, QVector<double> *imagbuffi, QVector<double> *betragbuffi, unsigned short FFTPunkte)
{
     unsigned short i;
     double real;
     double imag;
     double betrag;

     QVector<double> realbuf, betragbuf, imagbuf;

     realbuf.resize(FFTPunkte);
     betragbuf.resize(FFTPunkte);
     imagbuf.resize(FFTPunkte);

     realbuf = *realbuffi;
     betragbuf = *betragbuffi;
     imagbuf = *imagbuffi;

     for (i = 0 ; i < FFTPunkte ; i++)
     {
         real = realbuf[i];
         imag = imagbuf[i];
         betrag = sqrt(real*real + imag*imag);
         betragbuf[i] = betrag / (double)FFTPunkte;
     }

     *realbuffi = realbuf;
     *betragbuffi = betragbuf;
     *imagbuffi = imagbuf;
}

//---------------------------------------------------------------------------
/* Funktion zur Berechnung der Phase */
void __fastcall phasen_ber (QVector<double> *realbuffi, QVector<double> *imagbuffi, QVector<double> *phasebuffi, unsigned short FFTPunkte)
{
   unsigned short i;
   double real,imag,phase;

   QVector<double> realbuf, phasebuf, imagbuf;

   realbuf.resize(FFTPunkte);
   phasebuf.resize(FFTPunkte);
   imagbuf.resize(FFTPunkte);

   realbuf = *realbuffi;
   phasebuf = *phasebuffi;
   imagbuf = *imagbuffi;

   for (i = 0 ; i < FFTPunkte ; i++)
   {
      real = realbuf[i] / (double)FFTPunkte;
      imag = imagbuf[i] / (double)FFTPunkte;
      /* Bei der Phasenberechnung darf nicht durch Null dividiert werden */
      if (real == 0.)
      {
         if (imag < 0.)
            phase = -90.;
         if (imag > 0.)
            phase =  90.;
         if (imag == 0.)
            phase = 0.;
     }
     else
     {
    	 phase = atan(imag/real);
     }
     phasebuf[i] = phase;


     *realbuffi = realbuf;
     *phasebuffi = phasebuf;
     *imagbuffi = imagbuf;
   }
}
//---------------------------------------------------------------------------
void __fastcall RechneFFT(QVector<double> *real_buf, QVector<double> *imag_buf, QVector<double> *betrag_buf, unsigned short FFTPunkte)
{
   unsigned short i;
   short richtung;

   unsigned short AnzPunkte;
   AnzPunkte = FFTPunkte;

   QVector<double> imag_buffer;

   imag_buffer.resize(FFTPunkte);

   imag_buffer = *imag_buf;

   for (i=0 ; i < AnzPunkte ; i++)
   {
          // real_buf[i] = (double)OrigSignalBuf[i];
           imag_buffer[i] = 0.;
   }

   *imag_buf = imag_buffer;

   richtung = -1;

   // Jetzt wird die DFT dieser Zeitfunktion berechnet
   fft_func(real_buf, imag_buf, AnzPunkte, richtung);

   // Jetzt wird der Betrag berechnet
   betrag_ber(real_buf, imag_buf, betrag_buf, AnzPunkte);
}

