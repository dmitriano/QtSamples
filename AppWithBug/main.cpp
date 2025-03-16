#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QStringList>

int main(int argc, char *argv[])
{
    // qputenv("QT_QUICK_CONTROLS_STYLE", "Fusion");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("appName", app.applicationName());

    QStringList model { "Beginner", "Professional", "Expert"};
    engine.rootContext()->setContextProperty("levelListModel", QVariant::fromValue(model));

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    qDebug() << "Starting the application event loop...";

    return app.exec();
}
