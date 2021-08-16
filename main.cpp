#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "qmlglobaldata.h"

#include "OrderFormValidator.h" // for test

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterUncreatableType<QMLGlobalData>("sushione.QMLGlobalData", 1, 0,

                                            "QMLGlobalData",

                                            "You can't create an instance of the DataQuality.");

    qRegisterMetaType<QMLGlobalData::PageIndex>("QMLGlobalData.Page");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

// test begin
    FormData data;
    data.clientName = "Vlad";
    data.clientsCount = 2;
    data.expectedDate = QDate();
    data.expectedTime = QTime();
    data.phoneNumber = "0666122552";
    data.isDevivery = false;

    OrderFormValidator validator(data);
    validator.validate();
// test end

    return app.exec();
}
