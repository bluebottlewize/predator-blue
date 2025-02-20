#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "sysfswriter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);

    qmlRegisterType<SysfsWriter>("org.bluebottle.SysfsWriter", 1, 0, "SysfsWriter");

    engine.loadFromModule("PredatorBlue", "Main");

    return app.exec();
}
