#ifndef SYSFSWRITER_H
#define SYSFSWRITER_H

#include <QObject>

class SysfsWriter : public QObject {
    Q_OBJECT
public:
    explicit SysfsWriter(QObject *parent = nullptr);

    Q_INVOKABLE void setFanSpeed(int cpu_speed, int gpu_speed) const;
    Q_INVOKABLE int getCpuFanSpeed();
    Q_INVOKABLE int getGpuFanSpeed();
    Q_INVOKABLE int getCpuTemperature();
    Q_INVOKABLE int getGpuTemperature();
    Q_INVOKABLE bool getLCDOverdrive();
    Q_INVOKABLE bool getBacklightTimeout();
    Q_INVOKABLE bool getBootAnimationSound();
    Q_INVOKABLE void setLCDOverdrive(bool enable);
    Q_INVOKABLE void setBacklightTimeout(bool enable);
    Q_INVOKABLE void setBootAnimationSound(bool enable);
    Q_INVOKABLE void setPlatformProfile(const QString& profile);
    Q_INVOKABLE void setUSBCharging(int value);
    Q_INVOKABLE void setBatteryLimiter(bool value);
    Q_INVOKABLE void setBatteryCalibration(bool value);
};

#endif // SYSFSWRITER_H
