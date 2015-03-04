#include <QApplication>

#include "mainwindow.h"

int main(int arc, char **argv)
{
   QApplication app(arc,argv);

   MainWindow *mw = new MainWindow();
   mw->show();

   int r=app.exec();

   return r;
}
