#include "uimainwindow.h"
#include <QApplication>
#include <QStyleFactory>
#include <QFile>

void SetupApp(void);
void SetupStyle(QString sheetName);

int main(int argc, char *argv[])
{
    Q_INIT_RESOURCE(icons);
    qRegisterMetaType<vector<unsigned char> >("vector<unsigned char>");
    QApplication a(argc, argv);

    SetupApp();
    //SetupStyle("Style");
    qRegisterMetaType<usdDevice::Mode>("usdDevice::Mode");
    uimainwindow w;
    w.setWindowIcon(QIcon(":/resources/oscilloscope.ico"));


    w.show();

    return a.exec();
}

void SetupApp(void){
    // application name and organization details for the creator of the application
    QCoreApplication::setOrganizationName("Hochschule Ulm");
    QCoreApplication::setOrganizationDomain("www.hs-ulm.de");
    QCoreApplication::setApplicationName("Ultraschall Doppler");
}

void SetupStyle(QString sheetName){
    //qApp->setStyle(QStyleFactory::create("plastique"));
    QFile file(":/" + sheetName.toLower() + ".qss");
    file.open(QFile::ReadOnly);
    QString styleSheet = QString::fromLatin1(file.readAll());
    qApp->setStyleSheet(styleSheet);
}
