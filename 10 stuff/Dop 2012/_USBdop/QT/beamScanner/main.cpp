#include <QtWidgets/QApplication>
#include <qtBSmain.h>
#include <dbt.h>


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QtBeamScannerMain w;
    w.show();
    return a.exec();
}
