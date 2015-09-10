#ifndef STRINGEXTENTIONS_H
#define STRINGEXTENTIONS_H

#include <QString>

class StringExtentions
{
public:
    StringExtentions();

    static bool isFrequencyStringValid(QString &freqStr);
    static QString frequencyToString(double freq);
    static QString frequencyToString(int freqInHz);
    static int frequencyToInt(QString &freqStr);

private:
    static const QString FrequencyRegExpPattern;
};

#endif // STRINGEXTENTIONS_H
