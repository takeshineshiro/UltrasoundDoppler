#include "DSP.h"
#include "fftprivate.h"

DSP::FFT::FFT(const long length, QObject *parent):
        QObject(parent)
      ,d_ptr(new FFTPrivate(length, this))
{

}

DSP::FFT::FFT(const long width, const long height, QObject *parent):
    QObject(parent)
  ,d_ptr(new FFTPrivate(width, this))
{
        this->width = width;
        this->height = height;
}

DSP::FFT::~FFT()
{
        delete d_ptr;
}

void DSP::FFT::compute(const float source [], float result [])
{
    Q_D(FFT);
        d->do_fft(result, source);
}

void DSP::FFT::inverse(const float source [], float result [])
{
    Q_D(FFT);
    d->do_ifft(source, result);
}

void DSP::FFT::rescale(float source []) const
{
    const Q_D(FFT);
    d->rescale(source);
}

void DSP::FFT::compute2d(const float source [], float result []){
    const Q_D(FFT);
    float row[this->width];
    float column[this->height];

    float fftrow[this->width];
    float fftcolumn[this->height];

    for( int y = 0 ; y < this->height ; y++) {
        for( int x = 0 ; x < this->width ; x++ ) row[x] = source[x+(y*this->width)];
        d->do_fft(fftrow, row);
        for( int x = 0 ; x < this->width ; x++ ) result[x+(y*this->width)] = fftrow[x];
    }

    for( int x = 0 ; x < this->width ; x++) {
        for( int y = 0 ; y < this->height ; y++ ) column[y] = result[x+(y*this->width)];
        d->do_fft(fftcolumn,column);
        for( int y = 0 ; y < this->height ; y++ ) result[x+(y*this->width)] = fftcolumn[y];
    }
}

void DSP::FFT::inverse2d(const float source [], float result []){
    const Q_D(FFT);
    float row[this->width];
    float column[this->height];

    float ifftrow[this->width];
    float ifftcolumn[this->height];

    for( int y = 0 ; y < this->height ; y++) {
        for( int x = 0 ; x < this->width ; x++ ) row[x] = source[x+(y*this->width)];
        d->do_ifft(row, ifftrow);
        d->rescale(ifftrow);
        for( int x = 0 ; x < this->width ; x++ ) result[x+(y*this->width)] = ifftrow[x];
    }

    for( int x = 0 ; x < this->width ; x++) {
        for( int y = 0 ; y < this->height ; y++ ) column[y] = result[x+(y*this->width)];
        d->do_ifft(column, ifftcolumn);
        d->rescale(ifftcolumn);
        for( int y = 0 ; y < this->height ; y++ ) result[x+(y*this->width)] = ifftcolumn[y];
    }

}

QVector<float> DSP::MFCC::melWorkingFrequencies;

int DSP::MFCC::numMelFilters(int Nyquist)
{
    //System.Diagnostics.Debug.WriteLine("Nyquist:" + Convert.ToString(Nyquist));
    float frequency = Nyquist;
    float delta = mel(frequency);

    int numFilters = 0;

    while (frequency > 10)
    {
        ++numFilters;
        frequency -= (delta / 2);
        delta = DSP::MFCC::mel(frequency);

        //System.Diagnostics.Debug.WriteLine("Frequency:" + Convert.ToString(frequency));
    }

    return numFilters;
}

void DSP::MFCC::initMelFrequenciesRange(int Nyquist)
{
   //System.Diagnostics.Debug.WriteLine("Nyquist:" + Convert.ToString(Nyquist));
   float frequency = Nyquist;
   float delta = mel(frequency);

   int numFilters = numMelFilters(Nyquist);

   DSP::MFCC::melWorkingFrequencies.clear();

   //DSP::MFCC::melWorkingFrequencies = new float[numFilters];
   DSP::MFCC::melWorkingFrequencies.reserve(numFilters);
    DSP::MFCC::melWorkingFrequencies.fill(0,numFilters);

   frequency = Nyquist;
   delta = mel(frequency);
   int i = 0;
   float cFreq = 0;

   while (frequency > 10)
   {
       frequency -= (delta / 2);
       delta = mel(frequency);
       cFreq = round(frequency);

       DSP::MFCC::melWorkingFrequencies[numFilters-1-i] = 10;
      while (DSP::MFCC::melWorkingFrequencies[numFilters-1-i] < (cFreq - 10)) DSP::MFCC::melWorkingFrequencies[numFilters-1-i] += 10;

       ++i;
   }

}

float* DSP::MFCC::compute( float* signal)
{
   float* result = new float[DSP::MFCC::melWorkingFrequencies.count()];
   float* mfcc = new float[DSP::MFCC::melWorkingFrequencies.count()];

   int segment = 0;
   int start = 0;
   int end = 0;

   for (int i = 0; i < DSP::MFCC::melWorkingFrequencies.count(); i++)
   {
       result[i] = 0;
       segment = (int) round(mel( DSP::MFCC::melWorkingFrequencies[i] ) / 10 );

       start = (segment - (int)floor((float)segment / 2));
       end = (segment + (segment / 2));

       for (int j = start; j < end; j++)
       {
           result[i] += signal[j] * DSP::Filters::Triangular(j, segment);
       }
       result[i] = (result[i] > 0)  ? log10( abs(result[i]) ) : 0;
   }

   for (int i = 0; i < DSP::MFCC::melWorkingFrequencies.count(); i++)
   {
       for (int j = 0; j < DSP::MFCC::melWorkingFrequencies.count(); j++)
      {
           mfcc[i] += result[i] * cos(((DSP::PI * i) / DSP::MFCC::melWorkingFrequencies.count()) * (j - 0.5));
       }
       mfcc[i] *= sqrt(2.0 / (float) DSP::MFCC::melWorkingFrequencies.count());
   }

   return mfcc;
}

float DSP::MFCC::mel(float value)
{
   return (2595.0 * (float)log10(1.0 + value / 700.0));
}

float DSP::MFCC::melinv(float value)
{
   return (700.0 * ((float)pow(10.0, value / 2595.0) - 1.0));
}
