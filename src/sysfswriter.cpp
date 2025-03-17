#include "headers/sysfswriter.h"
#include <iostream>
#include <fstream>
#include <filesystem>
// #include <QtConcurrent>

using namespace std;
namespace fs = std::filesystem;

SysfsWriter::SysfsWriter(QObject *parent) : QObject(parent) {}

string findHwmonPath() {
    string base_path = "/sys/class/hwmon/";

    // Iterate through all hwmon devices
    for (const auto& entry : fs::directory_iterator(base_path)) {
        std::string device_path = entry.path();
        std::string driver_path = device_path + "/name";

        // Read the "name" file to check if it's the correct driver
        std::ifstream name_file(driver_path);
        if (name_file.is_open()) {
            std::string name;
            std::getline(name_file, name);
            name_file.close();

            // Check if this is the Acer WMI driver
            if (name == "acer") {
                return device_path;
            }
        }
    }

    return "";  // Return empty string if not found
}

int SysfsWriter::getCpuFanRPM()
{
    std::string hwmon_path = findHwmonPath() + "/fan1_input";
    if (hwmon_path.empty()) {
        std::cerr << "Error: Could not find the correct hwmon path!" << std::endl;
        return -1;
    }

    std::ifstream sysfs_file(hwmon_path);
    if (!sysfs_file.is_open()) {
        std::cerr << "Error: Failed to open " << hwmon_path << std::endl;
        return -1;
    }

    int fan_speed = 0;
    sysfs_file >> fan_speed;
    sysfs_file.close();

    return fan_speed;
}

int SysfsWriter::getGpuFanRPM()
{
    std::string hwmon_path = findHwmonPath() + "/fan2_input";
    if (hwmon_path.empty()) {
        std::cerr << "Error: Could not find the correct hwmon path!" << std::endl;
        return -1;
    }

    std::ifstream sysfs_file(hwmon_path);
    if (!sysfs_file.is_open()) {
        std::cerr << "Error: Failed to open " << hwmon_path << std::endl;
        return -1;
    }

    int fan_speed = 0;
    sysfs_file >> fan_speed;
    sysfs_file.close();

    return fan_speed;
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

bool SysfsWriter::getLCDOverdrive()
{
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/lcd_override";

    std::ifstream sysfs_file;
    sysfs_file.open(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file\n";
        return -1; // Return error code
    }

    std::string value_str;
    std::getline(sysfs_file, value_str);
    sysfs_file.close();

    try {
        if (value_str == "1") {
            return true;
        }
        else {
            return false;
        }
    } catch (const std::exception &e) {
        std::cerr << "Conversion error: " << e.what() << "\n";
        return false;
    }
}

bool SysfsWriter::getBacklightTimeout()
{
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/backlight_timeout";

    std::ifstream sysfs_file;
    sysfs_file.open(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file\n";
        return -1; // Return error code
    }

    std::string value_str;
    std::getline(sysfs_file, value_str);
    sysfs_file.close();

    std::cout << value_str;

    try {
        if (value_str == "1") {
            return true;
        }
        else {
            return false;
        }
    } catch (const std::exception &e) {
        std::cerr << "Conversion error: " << e.what() << "\n";
        return false;
    }
}

bool SysfsWriter::getBootAnimationSound()
{
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/boot_animation_sound";

    std::ifstream sysfs_file;
    sysfs_file.open(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file\n";
        return -1; // Return error code
    }

    std::string value_str;
    std::getline(sysfs_file, value_str);
    sysfs_file.close();

    try {
        if (value_str == "1") {
            return true;
        }
        else {
            return false;
        }
    } catch (const std::exception &e) {
        std::cerr << "Conversion error: " << e.what() << "\n";
        return false;
    }
}

void SysfsWriter::setLCDOverdrive(bool enable) {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/lcd_override";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << (enable ? "1" : "0") << std::endl;
    sysfs_file.close();
}

void SysfsWriter::setBacklightTimeout(bool enable) {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/backlight_timeout";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << (enable ? "1" : "0") << std::endl;
    sysfs_file.close();
}

void SysfsWriter::setBootAnimationSound(bool enable) {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/boot_animation_sound";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << (enable ? "1" : "0") << std::endl;
    sysfs_file.close();
}

void SysfsWriter::setPlatformProfile(const QString& profile) {
    QString sysfs_path = "/sys/firmware/acpi/platform_profile";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << profile.toStdString() << std::endl;
    sysfs_file.close();
}

int SysfsWriter::getUSBCharging() {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/usb_charging";
    std::ifstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for reading\n";
        return -1;
    }

    std::string value;
    std::getline(sysfs_file, value);
    sysfs_file.close();

    return QString::fromStdString(value).toInt();
}

bool SysfsWriter::getBatteryLimiter() {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter";
    std::ifstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for reading\n";
        return false;
    }

    std::string value;
    std::getline(sysfs_file, value);
    sysfs_file.close();

    return value == "1";
}

bool SysfsWriter::getBatteryCalibration() {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_calibration";
    std::ifstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for reading\n";
        return false;
    }

    std::string value;
    std::getline(sysfs_file, value);
    sysfs_file.close();

    return value == "1";
}

QString SysfsWriter::getPlatformProfile() {
    QString sysfs_path = "/sys/firmware/acpi/platform_profile";
    std::ifstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for reading\n";
        return QString();
    }

    std::string value;
    std::getline(sysfs_file, value);
    sysfs_file.close();

    return QString::fromStdString(value);
}


void SysfsWriter::setUSBCharging(int value) {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/usb_charging";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << value << std::endl;
    sysfs_file.close();
}

void SysfsWriter::setBatteryLimiter(bool value) {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << (value ? "1" : "0") << std::endl;
    sysfs_file.close();
}

void SysfsWriter::setBatteryCalibration(bool value) {
    QString sysfs_path = "/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_calibration";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << (value ? "1" : "0") << std::endl;
    sysfs_file.close();
}

bool SysfsWriter::getTurboboost() {
    QString sysfs_path = "/sys/devices/system/cpu/intel_pstate/no_turbo";
    std::ifstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for reading\n";
        return false;
    }

    std::string value;
    std::getline(sysfs_file, value);
    sysfs_file.close();

    return value == "0";
}

void SysfsWriter::setTurboboost(bool value) {
    QString sysfs_path = "/sys/devices/system/cpu/intel_pstate/no_turbo";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << (value ? "0" : "1") << std::endl;
    sysfs_file.close();
}

bool SysfsWriter::getHyperthreading() {
    QString sysfs_path = "/sys/devices/system/cpu/smt/control";
    std::ifstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for reading\n";
        return false;
    }

    std::string value;
    std::getline(sysfs_file, value);
    sysfs_file.close();

    return value == "on";
}

void SysfsWriter::setHyperthreading(bool value) {
    QString sysfs_path = "/sys/devices/system/cpu/smt/control";
    std::ofstream sysfs_file(sysfs_path.toStdString());

    if (!sysfs_file.is_open()) {
        std::cerr << "Failed to open sysfs file for writing\n";
        return;
    }

    sysfs_file << (value ? "on" : "off") << std::endl;
    sysfs_file.close();
}
