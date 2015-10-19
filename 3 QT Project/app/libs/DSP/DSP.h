#ifndef QDSP_H
#define QDSP_H

#include <QObject>
#include <QVector>
#include <math.h>

class FFTPrivate;

namespace DSP {
    const float  PI=3.14159265358979f;
    const float RADIANT = PI/180;

    class FFT : QObject {
        Q_OBJECT
        Q_DECLARE_PRIVATE(FFT)
        Q_CLASSINFO("Author", "Sebastiano Galazzo")
        Q_CLASSINFO("Email", "sebastiano.galazzo@gmail.com")

    public:
        /**
         * @brief Constructor
         *
         * @param length
         * @param parent
         */
        explicit FFT(const long length, QObject *parent = 0);

        /**
         * @brief Constructor
         *
         * @param width
         * @param height
         * @param parent
         */
        explicit FFT(const long width, const long height, QObject *parent = 0);

        /**
         * @brief Destructor
         */
        virtual ~FFT();

        /**
         * @brief Compute the 1D FFT
         *
         * @param source
         * @param result
         */
        Q_INVOKABLE void compute(const float source [], float result []);

        /**
         * @brief Compute the inverse 1D FFT
         *
         * @param source
         * @param result
         */
        Q_INVOKABLE void inverse(const float source [], float result []);

        /**
         * @brief Rescale values after forward FFT
         *
         * @param source
         * @param result
         */
        Q_INVOKABLE void rescale(float source []) const;

        /**
         * @brief Compute the 2D FFT
         *
         * @param source
         * @param result
         */
        Q_INVOKABLE void compute2d(const float source [], float result []);

        /**
         * @brief Compute the inverse 2D FFT
         *
         * @param source
         * @param result
         */
        Q_INVOKABLE void inverse2d(const float source [], float result []);

    protected:

        /**
         * @variable Private implementation of the FFT
         */
        FFTPrivate* const d_ptr;

    private:
        /**
         * @variable Matrix width for 2D FFT
         */
          long width;

        /**
        * @variable Matrix height for 2D FFT
        */
        long height;

    };

    class MFCC : QObject {
        Q_OBJECT
        Q_CLASSINFO("Author", "Sebastiano Galazzo")
        Q_CLASSINFO("Email", "sebastiano.galazzo@gmail.com")

    public:
        static int numMelFilters(int Nyquist);
        static void initMelFrequenciesRange(int Nyquist);
        static float* compute(float* signal);
        static float mel(float value);
        static float melinv(float value);
    //private:
        static QVector<float> melWorkingFrequencies; // { 10.0, 20.0, 90.0, 300.0, 680.0, 1270.0, 2030.0, 2970.0, 4050.0, 5250.0, 6570.0 };

    };

    class Filters
    {
    public:
        static float Triangular(float value, float samples)
        {
            return (2 / (samples + 1)) * (((samples + 1) / 2) - abs(value - ((samples - 1) / 2)));
        }

        /**
         * @brief EnhanceHighFrequencies
         *
         * @param signal
         * @param length
         */
        static float* EnhanceHighFrequencies(float* signal, int length)
        {
            float* result = new float[length];

            for (int i = 1; i < length; i++)
            {
                result[i] = signal[i] - 0.95 * signal[i - 1];
            }

            return result;
        }
    };

    /*class Utilities
    {
        public:
        static float MSE(float* signal_1, float* signal_2, int SizeToCompare)
        {
            float result = 0;

            if (signal_1.Length < SizeToCompare) return -1;
            if (signal_2.Length < SizeToCompare) return -1;

            for (int i = 0; i < signal_1.Length; i++)
            {
                result += Math.Pow(signal_1[i] - signal_2[i], 2);
            }

            return (result / signal_1.Length);
        }
    };*/
}

#endif // QDSP_H#ifndef DSP_H

