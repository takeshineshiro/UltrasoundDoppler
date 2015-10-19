#include "uimainwindow.h"
#include <QCoreApplication>
#include <QApplication>
#include <QDesktopWidget>
#include <QMenuBar>
#include <QSettings>
#include <QToolBar>
#include <QMessageBox>
#include <QTabWidget>
#include <QComboBox>
#include <QGroupBox>
#include <QDockWidget>
#include <QMainWindow>
#include <QHBoxLayout>
#include <QLabel>
#include <QDebug>
#include "app/stringextentions.h"

uimainwindow::uimainwindow(QWidget *parent) :
    QMainWindow(parent)
{
    app = new Menu(this);
    createFileMenu();
    menuBar()->addMenu(app->menu());
    createHelpMenu();
    createDock();
}

uimainwindow::~uimainwindow()
{
}

void uimainwindow::closeEvent(QCloseEvent *event)
{
    /* Do Somthing*/
    QMainWindow::closeEvent(event);
}

void uimainwindow::createFileMenu()
{
    QMenu* fileMenu = menuBar()->addMenu(tr("&File"));
    //
    //  New
    //
    QAction* action = new QAction(tr("&New"), this);
    action->setShortcut(tr("CTRL+N"));
    action->setToolTip(tr("Create a new project"));
    //connect(action, SIGNAL(triggered()), this, SLOT(newProject()));
    fileMenu->addAction(action);

    //
    //  Open
    //
    action = new QAction(tr("&Open"), this);
    action->setShortcut(tr("CTRL+O"));
    action->setToolTip(tr("Open an existing project"));
    //connect(action, SIGNAL(triggered()), this, SLOT(openProject()));
    fileMenu->addAction(action);

    //
    //  Save
    //
    action = new QAction(tr("&Save"), this);
    action->setShortcut(tr("CTRL+S"));
    action->setToolTip(tr("Save the project"));
    //connect(action, SIGNAL(triggered()), this, SLOT(saveProject()));
    fileMenu->addAction(action);

    //
    //  Save As
    //
    action = new QAction(tr("Save &As"), this);
    action->setToolTip(tr("Save the project as..."));
    //connect(action, SIGNAL(triggered()), this, SLOT(saveProjectAs()));
    fileMenu->addAction(action);

    fileMenu->addSeparator();

    //
    //  Exit
    //
    action = new QAction(tr("E&xit"), this);
    action->setShortcuts(QKeySequence::Quit);
    action->setToolTip(tr("Exit application"));
    connect(action, SIGNAL(triggered()), this, SLOT(close()));
    fileMenu->addAction(action);
    fileMenu->setToolTipsVisible(true);
}

void uimainwindow::close(){
    qApp->exit();
}

void uimainwindow::createHelpMenu()
{
    QMenu* menu = menuBar()->addMenu(tr("&Help"));
    //  About

    QAction* action = new QAction(tr("A&bout"), this);
    action->setToolTip(tr("About"));
    connect(action, SIGNAL(triggered()), this, SLOT(about()));
    menu->addAction(action);
    menu->setToolTipsVisible(true);
}

void uimainwindow::createDock()
{
    addDockWidget(Qt::RightDockWidgetArea, app->settings());

    QVBoxLayout *layout = new QVBoxLayout;

    QHBoxLayout *layoutmode = new QHBoxLayout;
    layoutmode->addWidget(app->mmodeGraph());

    QGroupBox *modebox = new QGroupBox(tr("M-Mode"));
    modebox->setLayout(layoutmode);
    layout->addWidget(modebox);

    QHBoxLayout *layoutfreq = new QHBoxLayout;
    layoutfreq->addWidget(app->spectromGraph());

    QGroupBox *freq = new QGroupBox(tr("frequency analysis"));
    freq->setLayout(layoutfreq);
    layout->addWidget(freq);

    // Set layout in QWidget
    QWidget *window = new QWidget();
    window->setLayout(layout);
    setCentralWidget(window);
    this->setMinimumHeight(400);
    this->setMinimumWidth(800);
}


void uimainwindow::about()
{
    QString progVer = "0.01";
    QString url = "http://www.hs-ulm.de/schilling";

    QString msg = "";
    msg.append(QString("<h2>Über %1</h2>").arg(QCoreApplication::applicationName()));
    msg.append(QString("Version %1<br>").arg(progVer));
    msg.append(QString("Built on %1 at %2 using Qt %3").arg(__DATE__).arg(__TIME__).arg(QT_VERSION_STR));
    msg.append("<br>");
    msg.append("<br>");
    msg.append(QString("User's Guide available on page: <a href=\"%1\" style=\"color:#4ec9b0\">%2</a>").arg(url).arg(url));
    msg.append("<br>");
    msg.append("<br>");
    msg.append("Copyright 2015 ");
    msg.append(QCoreApplication::organizationName());
    msg.append(" - Institut IMM");
    msg.append("<br>");
    QMessageBox::about(this, QString("Über %1").arg(
                           QCoreApplication::applicationName()), msg);
}

void uimainwindow::handleStatusChanged(usbDevice *dev)
{
    if(dev->isAvailable()){
        qDebug() << "Device" << dev->Descriptor(1) << "with Speed:"
                                       << dev->DeviceSpeed() << "is connected!";
        menuBar()->addMenu(dev->Descriptor(1));
    }
    else qDebug() << "device disconnected..";
}
