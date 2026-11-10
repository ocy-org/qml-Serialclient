#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

// #include "DatabaseManager.h"
#include "computerservice.h"
#include "cursorposprovider.h"
#include "vncmshservice.h"
#include "serialservice.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // Computer computer;
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    // CursorPosProvider cursorPosProvider;
    // engine.rootContext()->setContextProperty("cursorPosProvider", &cursorPosProvider);
    // QQmlContext *context =  engine.rootContext();
    qmlRegisterType<ComputerService>("ComputerServiceObj",1,0,"ComputerService");
    qmlRegisterType<CursorPosProvider>("CursorPosProviderObj",1,0,"CursorPosProvider");
    qmlRegisterType<VncMshService>("VncMshServiceObj",1,0,"VncMshService");
    qmlRegisterType<SerialService>("SerialServiceObj",1,0,"SerialService");
    engine.load(url);

    // DatabaseManager& manager = DatabaseManager::getInstance();
    // QSqlDatabase db = manager.getDatabaseConnection(false);

    app.setWindowIcon(QIcon(":/img/client.png"));

    return app.exec();
}
