#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "models/bot_model.h"
#include "models/human_model.h"
#include "models/referee_model.h"
#include "rules_loader.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Bot_model>("Bot_model_qml", 1, 0, "Bot_model");
    qmlRegisterType<Human_model>("Human_model_qml", 1, 0, "Human_model");
    qmlRegisterType<Referee_model>("Referee_model_qml", 1, 0, "Referee_model");
    qmlRegisterType<Rules_loader>("Rules_loader_qml", 1, 0, "Rules_loader");

    qRegisterMetaType<QVector<Card>>("QVector<Card>");
    qRegisterMetaType<Card>("Card");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml_files/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
