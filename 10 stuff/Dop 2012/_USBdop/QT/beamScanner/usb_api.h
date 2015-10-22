#ifndef USB_API_H
#define USB_API_H

#include <QObject>

class UltrasonicDoppler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint16 vid READ vid WRITE setVid NOTIFY vidChanged)
    Q_PROPERTY(quint16 pid READ pid WRITE setPid NOTIFY pidChanged)
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged)

    Q_PROPERTY(quint16 frequency READ frequency WRITE setFrequency NOTIFY frequencyChanged)
    Q_PROPERTY(quint16 prf READ prf WRITE setPrf NOTIFY prfChanged)
    Q_PROPERTY(quint16 burst READ burst WRITE setBurst NOTIFY burstChanged)
    Q_PROPERTY(quint16 sample READ sample WRITE setSample NOTIFY sampleChanged)
    Q_PROPERTY(quint16 depth READ depth WRITE setDepth NOTIFY depthChanged)

    Q_ENUMS(Mode)
public:
    explicit UltrasonicDoppler(QObject *parent = 0);
    UltrasonicDoppler();
    ~UltrasonicDoppler();

    enum Mode { Run, Stop };

    /* Vid */
    quint16 vid() const { return _vid; }
    void setVid(const quint16& value){
        if(_vid != value){
            _vid = value;
            emit vidChanged(_vid);
        }
    }

    /* Pid */
    quint16 pid() const { return _pid; }
    void setPid(const quint16& value){
        if(_pid != value){
            _pid = value;
            emit pidChanged(_pid);
        }
    }

    bool isConnected() const { return _isConnected; }

    /* Mode */
    Mode mode() const { return _mode; }
    void setMode(const Mode& value){
        if(_mode != value){
            _mode = value;
            emit modeChanged(_mode);
        }
    }

    /* Frequency */
    quint16 frequency() const { return _frequency; }
    void setFrequency(const quint16& value){
        if(_frequency != value){
            _frequency = value;
            emit frequencyChanged(_frequency);
        }
    }

    /* PRF */
    quint16 prf() const { return _prf; }
    void setPrf(const quint16& value){
        if(_prf != value){
            _prf = value;
            emit prfChanged(_prf);
        }
    }

    /* Burst */
    quint16 burst() const { return _burst; }
    void setBurst(const quint16 value){
        if(_burst != value){
            _burst = value;
            emit burstChanged(_burst);
        }
    }

    /* Sample */
    quint16 sample() const { return _sample; }
    void setSample(const quint16& value){
        if(_sample != value){
            _sample = value;
            emit sampleChanged(_sample);
        }
    }

    /* Depth */
    quint16 depth() const { return _depth; }
    void setDepth(const quint16& value){
        if(_depth != value){
            _depth = value;
            emit depthChanged(_depth);
        }
    }


/* methods */



public slots:

signals:
    void vidChanged(int value);
    void pidChanged(int value);
    void isConnectedChanged(bool value);
    void modeChanged(Mode value);

    void frequencyChanged(quint16 value);
    void prfChanged(quint16 value);
    void burstChanged(quint16 value);
    void sampleChanged(quint16 value);
    void depthChanged(quint16 value);
private:
    quint16 _vid;
    quint16 _pid;
    bool _isConnected;
    Mode _mode;

    quint16 _frequency;
    quint16 _prf;
    quint16 _burst;
    quint16 _sample;
    quint16 _depth;

    enum Request { SetFrequency = 0,
                    SetBurst = 1,
                    SetSample = 2,
                    SetDepth = 3,
                    SetDatarate = 4,
                    SetRun = 5,
                    Scan = 6,
                    SetConfiguration = 7
                  };
};


#endif // USB_API_H
