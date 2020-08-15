TARGET = qsqlmysql

HEADERS += $$PWD/qsql_mysql_p.h
SOURCES += $$PWD/qsql_mysql.cpp $$PWD/main.cpp

#QMAKE_USE += mysql

OTHER_FILES += mysql.json

PLUGIN_CLASS_NAME = QMYSQLDriverPlugin
include(../qsqldriverbase.pri)


#手动编译Qt MYSQL驱动:
#因为MySQL在8.0后没有c连接器,而Qt MYSQL驱动需要的是c连接器所以需要根据Qt_32位就
#下载MySQL_32位的c连接器 https://downloads.mysql.com/archives/c-c/
#安装路径请勿有空格和中文字符不然会出现问题,很麻烦的,要重新安装的!!!
#下载安装好后就需要将c连接器里的libmysql.dll(保险起见也将libmysql.lib)文件放到Qt编译器文件下
#如:D:\Qt5.15.0_install\5.15.0\msvc2019\bin  中

#请将MySQL和Qt 的 bin路径添加到环境变量中!!!

#打开Qt安装目录下的源文件位置,打开mysql源文件
#参考: D:\Qt5.15.0_install\5.15.0\Src\qtbase\src\plugins\sqldrivers\mysql
#打开mysql.pro进行修改,只需要修改此处
#和将项目的构建目录 Build directory:debug和release生成路径最后的debug或者release去掉即可
#不然会出现找不到mysql头文件,或者打不开libmysql.obj
#编译的驱动文件模式,对应debug模式的只能对应debug

#只需要添加下面的就行了
INCLUDEPATH +="D:/MySQL/Connector_Qt_c_32/include" #将MySQL_C连接器头文件添加进来
LIBS+="D:/MySQL/Connector_Qt_c_32/lib/libmysql.lib" #将MySQL_C连接器文件添加进来

DESTDIR =../mysql/lib/ #这是编译后的文件放在当前目录下的,防止找不到编译后的文件

#自己编译太麻烦了,可以去https://cn.dll-files.com/ 下载QtMySQL驱动文件: qsqlmysql.dll,qsqlmysqld.dll ,
#注意!!! 这文件还是需要MySQL_c连接器搭配的噢,下载c连接器在上面,根据自己Qt系统多少位下载对应的噢

#注意!!! 测试连接MySQL驱动测试如出现:
#("QSQLITE", "QMARIADB", "QMYSQL", "QMYSQL3", "QODBC", "QODBC3", "QPSQL", "QPSQL7")
#"Authentication plugin 'caching_sha2_password' cannot be loaded: 找不到指定的模块。\r\n" "QMYSQL: Unable to connect"
#opened error
#解决方法:
#打开MySQL,进到数据库, use mysql;#选择此数据库
#alter user 'root'@'localhost' identified with mysql_native_password by '密码';#更改加密规则


