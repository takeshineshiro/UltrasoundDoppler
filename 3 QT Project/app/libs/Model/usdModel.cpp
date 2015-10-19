#include "usdModel.h"

USDModel::USDModel(IDeviceInterface *dev, QObject *parent) :
    QObject(parent)
{
    this->device = dev;
}

QList<int> USDModel::supportedBurstFrequencyRates()
{
    //in Hz
    return QList<int>()
            <<   8000000
            <<   4000000
            <<   2000000;
}

QList<int> USDModel::supportedPRFRates()
{
    //in Hz
    return QList<int>()
            <<   12000
            <<   11000
            <<   10000
            <<    9000
            <<    8000
            <<    7000
            <<    6000
            <<    5000
            <<    4000
            <<    3000
            <<    2000;
}

int USDModel::GetFrequencyValue(void)
{
    return _frequencyValue;
}

void USDModel::SetFrequencyValue(int value)
{
    _frequencyValue = value;
}

int USDModel::GetPRFValue(void)
{
    return _prfValue;
}

void USDModel::SetPRFValue(int value)
{
    _prfValue = value;
}

quint16 USDModel::GetBurstValue(void)
{
    return _burstValue;
}

void USDModel::SetBurstalue(uint16_t value)
{
    _burstValue = value;
}

quint16 USDModel::GetSampleValue(void)
{
    return _sampleValue;
}

void USDModel::SetSampleValue(uint16_t value)
{
    _sampleValue = value;
}

quint16 USDModel::GetDepthValue()
{
    return _depthValue;
}

void USDModel::SetDepthValue(uint16_t value)
{
    _depthValue = value;
}

USDModel::state USDModel::GetStateValue(void)
{
    return _state;
}

void USDModel::SetStateValue(USDModel::state value)
{
    _state = value;
}


