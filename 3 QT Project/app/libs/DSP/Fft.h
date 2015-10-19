//---------------------------------------------------------------------------
#ifndef FFTH
#define FFTH

#include <QtWidgets/QMainWindow>
#include "qcustomplot.h"
#include <qdatetime.h>

#include "qextserialport.h"
#include "../../../_QT_Libs/HS-ULM/qhsuprot.h"

//---------------------------------------------------------------------------

void __fastcall fft_func(QVector<double> *realbuffi, QVector<double> *imagbuffi, unsigned short FFTPunkte, short richtung);
void __fastcall betrag_ber (QVector<double> *realbuffi, QVector<double> *imagbuffi, QVector<double> *betragbuffi, unsigned short FFTPunkte);
void __fastcall phasen_ber (QVector<double> *realbuffi, QVector<double> *imagbuffi, QVector<double> *phasenbuffi, unsigned short FFTPunkte);
void __fastcall RechneFFT(QVector<double> *real_buf, QVector<double> *imag_buf, QVector<double> *betrag_buf, unsigned short FFTPunkte);

#endif
