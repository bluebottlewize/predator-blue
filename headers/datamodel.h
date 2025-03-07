#ifndef DATAMODEL_H
#define DATAMODEL_H

#include <QObject>
#include <QTimer>
#include <QFile>
#include <QTextStream>

class DataModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(int cpuFanRPM READ cpuFanRPM NOTIFY dataUpdated)
    Q_PROPERTY(int gpuFanRPM READ gpuFanRPM NOTIFY dataUpdated)
    Q_PROPERTY(int cpuFanSpeed READ cpuFanSpeed NOTIFY dataUpdated)
    Q_PROPERTY(int gpuFanSpeed READ gpuFanSpeed NOTIFY dataUpdated)
    Q_PROPERTY(int cpuTemp READ cpuTemp NOTIFY dataUpdated)
    Q_PROPERTY(int gpuTemp READ gpuTemp NOTIFY dataUpdated)

public:
    explicit DataModel(QObject *parent = nullptr);

    int cpuFanRPM() const { return m_cpuFanRPM; }
    int gpuFanRPM() const { return m_gpuFanRPM; }
    int cpuFanSpeed() const { return m_cpuFanSpeed; }
    int gpuFanSpeed() const { return m_gpuFanSpeed; }
    int cpuTemp() const { return m_cpuTemp; }
    int gpuTemp() const { return m_gpuTemp; }

signals:
    void dataUpdated();
    // void gpuFanRPMChanged();
    // void cpuFanSpeedChanged();
    // void gpuFanSpeedChanged();
    // void cpuTempChanged();
    // void gpuTempChanged();

private slots:
    void updateSensors();

private:
    QTimer pollTimer;
    int m_cpuFanRPM = 0;
    int m_gpuFanRPM = 0;
    int m_cpuFanSpeed = 0;
    int m_gpuFanSpeed = 0;
    int m_cpuTemp = 0;
    int m_gpuTemp = 0;
};

#endif // DATAMODEL_H
