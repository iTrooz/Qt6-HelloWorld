#include <QApplication>

#include "MyWindow.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MyWindow w;

    w.show();

    return a.exec();
}
