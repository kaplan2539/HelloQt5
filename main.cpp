#include <QApplication>

#include "mainwindow.h"

int main(int arc, char **argv)
{
   QApplication app(arc,argv);

   MainWindow *mw = new MainWindow();
   mw->show();
   mw->setWindowIcon(QIcon(":/icon.svg"));

   int r=app.exec();

   return r;
}
