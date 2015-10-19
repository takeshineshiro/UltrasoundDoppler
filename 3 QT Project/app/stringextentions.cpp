#include "stringextentions.h"
#include <QRegExp>
#include <QStringList>

// match strings such as 1 hz, 1.123 kHz, 1000, 1,1444MHZ
const QString StringExtentions::FrequencyRegExpPattern
    = "(\\d+((?:\\.|\\,)\\d+)?)(?:\\s)?(hz|khz|mhz)?";

StringExtentions::StringExtentions(){
}

/*!
    Convert frequency in Hz to a string representation.
*/
QString StringExtentions::frequencyToString(double freq){
    QString text;
    int n = 0;
    int neg = 1;

    if (freq < 0) {
        freq = -freq;
        neg = -1;
    }

    while (freq != 0 && freq >= 1000) {
        n++;
        freq/=1000;
    }

    text.append(QString("%1").arg(neg*freq));
    switch (n) {
    case 0:
        text.append(" Hz");
        break;
    case 1:
        text.append(" KHz");
        break;
    case 2:
        text.append(" MHz");
        break;
    case 3:
        text.append(" GHz");
        break;
    }

    return text;
}

/*!
    Checks if the specified \a freqStr contains a valid frequency value.
*/
bool StringExtentions::isFrequencyStringValid(QString &freqStr)
{
    QRegExp regExp;
    regExp.setCaseSensitivity(Qt::CaseInsensitive);
    regExp.setPattern(FrequencyRegExpPattern);

    return regExp.exactMatch(freqStr);
}

/*!
    Convert frequency in Hz to a string representation.
*/
QString StringExtentions::frequencyToString(int freqInHz)
{

    QLatin1Char fillChar('0');
    QString text;
    int freq = freqInHz;
    int n = 0;
    int neg = 1;

    if (freq < 0) {
        freq = -freq;
        neg = -1;
    }

    while (freq != 0 && freq >= 1000) {
        n++;
        freq/=1000;
    }

    int rem = 0;

    QString unit;
    switch (n) {
    case 0:
        unit.append(" Hz");
        break;
    case 1:
        unit.append(" kHz");
        rem = (freqInHz*neg) % 1000;
        break;
    case 2:
        unit.append(" MHz");
        rem = (freqInHz*neg) % 1000000;
        break;
    case 3:
        unit.append(" GHz");
        rem = (freqInHz*neg) % 1000000000;
        break;
    }

    text.append(QString("%1").arg(neg*freq));
    if (rem > 0) {
        text.append(QString(".%1").arg(rem, 3, 10, fillChar));
    }
    text.append(unit);

    return text;
}

/*!
    Convert to frequency in Hz from a string representation.
*/
int StringExtentions::frequencyToInt(QString &freqStr)
{
    int freq = -1;
    int mult = 1;
    int addDecDigits = 0;
    bool ok;

    do {

        if (!isFrequencyStringValid(freqStr)) break;

        // we are using a regular expression to divide the string into
        // 1 - complete number
        // 2 - only decimal part (including decimal character)
        // 3 - unit (hz, khz, mhz)

        QRegExp regExp;
        regExp.setCaseSensitivity(Qt::CaseInsensitive);
        regExp.setPattern(FrequencyRegExpPattern);

        regExp.indexIn(freqStr);

        QString numStr = regExp.cap(1);
        QString decStr = regExp.cap(2);

        if (!decStr.isEmpty()) {
            // remove decimal part from number string
            numStr = numStr.mid(0, numStr.indexOf(decStr));

            // remove decimal character
            decStr = decStr.mid(1);
        }

        // get multiplier

        QString multStr = regExp.cap(3).toLower();
        if (multStr == "khz") {
            mult = 1000;
            // 3 digits in the decimal part
            addDecDigits = 3-decStr.size();
        }
        else if (multStr == "mhz") {
            mult = 1000000;
            // 6 digits in the decimal part
            addDecDigits = 6-decStr.size();
        }
        else {
            // no decimals accepted when freq specified in Hz
            decStr = "0";
        }

        // get integer part of value

        int intVal = numStr.toInt(&ok);
        if (!ok) break;
        // will overflow after multiplication -> break
        if (mult > (INT_MAX / intVal)) break;

        intVal *= mult;

        // make sure the decimal part is 'large enough'. Fill with zeros if it
        // is short. Trim if it is too long.
        if (addDecDigits > 0) {
            decStr = decStr + QString("").fill('0', addDecDigits);
        }
        else if (addDecDigits < 0){
            decStr = decStr.left(decStr.size()+addDecDigits);
        }

        int decVal = decStr.toInt(&ok);
        if (!ok) break;

        freq = intVal + decVal;

    } while(false);

    return freq;
}
