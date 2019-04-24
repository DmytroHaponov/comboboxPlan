#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include "back.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
//qmlRegisterType<Back>("ah", 1,0, "MyBack");
    QQmlApplicationEngine engine;
    QQmlContext* rootContext = engine.rootContext();
    Back back;
     rootContext->setContextProperty("myBack", &back);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
