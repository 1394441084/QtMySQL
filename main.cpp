#include "mainwindow.h"

#include <QApplication>
#include <QSqlError>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    qDebug()<<QSqlDatabase::drivers();//数据库驱动有哪些
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");//加载驱动
    //db.setHostName("127.0.0.1");//设置主机名
        db.setHostName("localhost");
        db.setPort(3306);//设置端口
        db.setUserName("root");
        db.setPassword("zwc12345678910@");
        db.setDatabaseName(QString("qtqq"));

//        QSqlDatabase firstDB = QSqlDatabase::addDatabase("QMYSQL", "first");
//        QSqlDatabase secondDB = QSqlDatabase::addDatabase("QMYSQL", "second");

        bool i = db.open();//打开数据库
        QSqlError e = db.lastError();//打开数据库出现的最后一个问题

        qDebug()<<e.databaseText()<<e.driverText();
        if(i)
        {
            QSqlQuery query;
            query.exec("select * from tab_department;");
            while(query.next())
            {
                int id = query.value(0).toInt();
                QString str = query.value(0).toString();
                qDebug() << id << "|" << str;
            }
            db.close();
        }
        else
        {
            qDebug() << "opened error";
        }

    MainWindow w;
    w.show();
    return a.exec();
}
