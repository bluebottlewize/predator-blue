#ifndef SYSFSWRITER_H
#define SYSFSWRITER_H

#include <QObject>

class SysfsWriter : public QObject {
    Q_OBJECT
public:
    explicit SysfsWriter(QObject *parent = nullptr);

    Q_INVOKABLE QString sayHello() const;
    Q_INVOKABLE void setFanSpeed(int cpu_speed, int gpu_speed) const;
    Q_INVOKABLE int getCpuFanSpeed();
    Q_INVOKABLE int getGpuFanSpeed();
    Q_INVOKABLE int getCpuTemperature();
    Q_INVOKABLE int getGpuTemperature();
};

#endif // SYSFSWRITER_H
