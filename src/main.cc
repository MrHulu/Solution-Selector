#include <QGuiApplication>
#include <QResource>
#include <QQmlApplicationEngine>
#include "core/utils/Clipboard.h"
#include "core/UtilsHelper.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    //QResource::registerResource("resource.rcc");

    qmlRegisterUncreatableType<Clipboard>("UtilsHelper",1,0,"Clipboard", "Clipboard cannot be created in QML.");
    qmlRegisterSingletonType<UtilsHelper>("UtilsHelper",1,0,"UtilsHelper",
                                          [](QQmlEngine *engine, QJSEngine *) -> QObject* {
                                              auto instance = &UtilsHelper::instance();
                                              engine->setObjectOwnership(instance, QQmlEngine::ObjectOwnership::CppOwnership);
                                              return instance;
                                          });

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
