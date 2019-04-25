#ifndef ADBINSTALLWORKER_H
#define ADBINSTALLWORKER_H

#include <QObject>

class AdbInstallWorker : public QObject
{
    Q_OBJECT
public:
    explicit AdbInstallWorker(const QString &apk, QObject *parent = nullptr);
    void install();
private:
    QString m_Apk;
signals:
    void finished();
    void installFailed(const QString &apk);
    void installFinished(const QString &apk);
    void started();
};

#endif // ADBINSTALLWORKER_H
