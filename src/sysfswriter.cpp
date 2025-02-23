#include "headers/sysfswriter.h"
#include <iostream>
#include <fstream>
#include <tensorflow/include/nvml.h>
#include <QtConcurrent>

using namespace std;

SysfsWriter::SysfsWriter(QObject *parent) : QObject(parent) {}

QString SysfsWriter::sayHello() const {



    return "Hello from C++!";
}

void SysfsWriter::setFanSpeed(int cpu_speed, int gpu_speed) const {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";

    std::ofstream sysfs_file;
    sysfs_file.open(sysfs_path.toStdString());

    if (sysfs_file.is_open()) {
        // Write a value to the sysfs file
        sysfs_file << cpu_speed << "," << gpu_speed;

        // Close the file after writing
        sysfs_file.close();
        std::cout << "Successfully wrote to " << sysfs_path.toStdString() << std::endl;
    } else {
        std::cerr << "Failed to open " << sysfs_path.toStdString() << " for writing!" << std::endl;
    }
}


int SysfsWriter::getGpuFanSpeed()
{
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";

    std::ifstream sysfs_file;
    sysfs_file.open(sysfs_path.toStdString());
    int cpu = 0, gpu = 0;
    char comma;

    if (sysfs_file.is_open()) {
        // Write a value to the sysfs file
        sysfs_file >> cpu >> comma >> gpu;

        cout << "gpu" << gpu << endl;

        // Close the file after writing
        sysfs_file.close();
        std::cout << "Successfully wrote to " << sysfs_path.toStdString() << std::endl;
    } else {
        std::cerr << "Failed to open " << sysfs_path.toStdString() << " for writing!" << std::endl;
    }

    return gpu;
}

int SysfsWriter::getCpuFanSpeed()
{
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";

    std::ifstream sysfs_file;
    sysfs_file.open(sysfs_path.toStdString());
    int cpu = 0, gpu = 0;
    char comma;

    if (sysfs_file.is_open()) {
        // Write a value to the sysfs file
        sysfs_file >> cpu >> comma >> gpu;

        cout << "cpu" << cpu << endl;

        // Close the file after writing
        sysfs_file.close();
        std::cout << "Successfully wrote to " << sysfs_path.toStdString() << std::endl;
    } else {
        std::cerr << "Failed to open " << sysfs_path.toStdString() << " for writing!" << std::endl;
    }
    return cpu;
}


int SysfsWriter::getGpuTemperature() {
    FILE* pipe = popen("nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader", "r");
    if (!pipe) return -1; // Failed to open pipe

    int temperature = -1;
    fscanf(pipe, "%d", &temperature);  // Read temperature as integer
    pclose(pipe);

    return temperature;

    // QtConcurrent::run([] {
    //     nvmlInit();
    //     nvmlDevice_t device;
    //     nvmlDeviceGetHandleByIndex(0, &device);

    //     unsigned int temp = 0;
    //     nvmlDeviceGetTemperature(device, NVML_TEMPERATURE_GPU, &temp);

    //     nvmlShutdown();
    //     qDebug() << "GPU Temperature:" << temp << "°C";

    //     return temp;
    // });
}

int SysfsWriter::getCpuTemperature() {
    std::ifstream file("/sys/class/thermal/thermal_zone9/temp");
    int temp;

    if (file.is_open()) {
        file >> temp;
        file.close();
        return temp / 1000;  // Convert to degrees Celsius
    } else {
        std::cerr << "Failed to read CPU temperature!" << std::endl;
        return -1;
    }
}
