QT += quick gui qml quickcontrols2 sql serialport
CONFIG += c++17
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/commfuntion.cpp \
        src/computer.cpp \
        src/computerservice.cpp \
        src/department.cpp \
        src/main.cpp \
        src/serialservice.cpp \
        src/vncmsg.cpp \
        src/vncmshservice.cpp \
        src/utils.cpp \
        src/qaesencryption.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/DatabaseManager.h \
    src/commfuntion.h \
    src/computer.h \
    src/computerservice.h \
    src/cursorposprovider.h \
    src/department.h \
    src/serialservice.h \
    src/vncmsg.h \
    src/vncmshservice.h \
    src/utils.h \
    src/qaesencryption.h

DISTFILES +=
