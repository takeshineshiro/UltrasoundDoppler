#ifndef UIMAINWINDOW_H
#define UIMAINWINDOW_H

#include <QMainWindow>
#include "app/Menu.h"

class uimainwindow : public QMainWindow
{
    Q_OBJECT

public:
    uimainwindow(QWidget *parent = 0);
    ~uimainwindow();

protected:
    void closeEvent(QCloseEvent * event);
private:
    void createFileMenu();
    void createHelpMenu();
    void createDock();
    void close();

    Menu* app;

signals:
    void connectionStatusChanged(bool);

private slots:
    void about();
    void handleStatusChanged(usbDevice* dev);
};

#endif // UIMAINWINDOW_H
