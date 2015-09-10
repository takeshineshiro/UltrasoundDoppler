#ifndef USDMODEL_H
#define USDMODEL_H

#include <QObject>
#include <QList>
#include "libs/Contract/IDeviceInterface.h"
//#include <QChart>

using namespace std;

class USDModel : public QObject
{

public:
    explicit USDModel(IDeviceInterface *dev, QObject *parent = 0);

    static QList<int> supportedBurstFrequencyRates();
    static QList<int> supportedPRFRates();

    typedef enum { SingleShot, Doppler, Halt } state;

    bool IsDeviceConnected() const { return device->deviceHandle() >= 0; }

    int GetFrequencyValue(void);
    void SetFrequencyValue(int value);

    int GetPRFValue(void);
    void SetPRFValue(int value);

    quint16 GetBurstValue(void);
    void SetBurstalue(uint16_t value);

    quint16 GetSampleValue(void);
    void SetSampleValue(uint16_t value);

    quint16 GetDepthValue(void);
    void SetDepthValue(uint16_t value);

    state GetStateValue(void);
    void SetStateValue(state value);

private:
    IDeviceInterface *device;

    int _frequencyValue;
    int _prfValue;
    quint16 _burstValue;
    quint16 _sampleValue;
    quint16 _depthValue;
    state _state;
};
#endif // USDMODEL_H
