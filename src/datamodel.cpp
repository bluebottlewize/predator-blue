#include "headers/datamodel.h"
#include "headers/sysfswriter.h"

DataModel::DataModel(QObject *parent) : QObject(parent) {
    pollTimer.setInterval(1000);  // Poll every second
    connect(&pollTimer, &QTimer::timeout, this, &DataModel::updateSensors);
    pollTimer.start();
}

void DataModel::updateSensors()
{
    SysfsWriter writer;

    // Update sensor values
    m_cpuTemp = writer.getCpuTemperature();
    m_gpuTemp = writer.getGpuTemperature();
    m_cpuFanRPM = writer.getCpuFanRPM();
    m_gpuFanRPM = writer.getGpuFanRPM();
    m_cpuFanSpeed = writer.getCpuFanSpeed();
    m_gpuFanSpeed = writer.getGpuFanSpeed();

    emit dataUpdated();
}
