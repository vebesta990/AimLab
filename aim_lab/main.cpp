#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QCursor>
#include <QGuiApplication>

int main(int argc, char *argv[])
{
    QString customCursor = ":/resources/images/cursor.png";

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    app.setWindowIcon(QIcon(":/resources/images/icon.png"));
    QGuiApplication::setOverrideCursor(QPixmap(customCursor));

    return app.exec();
}
