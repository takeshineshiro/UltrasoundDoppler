#include <QtGui/QApplication>
#include "qtdopmain.h"
#include <time.h>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QTdopMain w;
    w.show();

    return a.exec();
}
