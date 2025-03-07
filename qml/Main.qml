import QtQuick
import QtQuick.Controls
import QtQuick3D.Particles3D 6.2
import org.bluebottle.SysfsWriter
import QtQuick.Layouts

Window {
    visible: true
    // color: "#0d143d"

    property bool initializeCpu: false;
    property bool initializeGpu: false;
    property bool backlightActive: false
    property bool lcdoverrideActive: false
    property bool bootsoundActive: false
    property bool usbchargingActive: false
    property bool batterylimiterActive: false
    property bool batterycalibrationActive: false

    property int currentTab: 0


    Component.onCompleted: {
        console.log(writer.getCpuFanSpeed());
        console.log(writer.getGpuFanSpeed());
        console.log(writer.getBacklightTimeout());
        cpuSlider.valueWrapper = Math.round(writer.getCpuFanSpeed());
        gpuSlider.valueWrapper = Math.round(writer.getGpuFanSpeed());

        cpuMeter.level = cpuSlider.valueWrapper
        gpuMeter.level = gpuSlider.valueWrapper

        initializeCpu = true;
        initializeGpu = true;

        lcdoverrideActive = writer.getLCDOverdrive();
        bootsoundActive = writer.getBootAnimationSound();
        backlightActive = writer.getBacklightTimeout();
        usbchargingActive = writer.getUSBCharging();
        batterylimiterActive = writer.getBatteryLimiter();
        batterycalibrationActive = writer.getBatteryCalibration();
    }

    function deactivateAll() {
        thermalButton.active = false;
        profileButton.active = false;
        keyboardButton.active = false;
        batteryButton.active = false;
        miscButton.active = false;
    }

    Rectangle {

        width: parent.width
        height: parent.height

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#1a0136"
            }
            GradientStop {
                position: 0.50228
                color: "#0a0c12"
            }

            GradientStop {
                position: 1.0
                color: "#050c27"
            }
        }

        SysfsWriter {
            id: writer
        }

        FontLoader {
            id: cyberalert
            source: "qrc:/fonts/CyberAlert-xRv8j.otf"
        }

        FontLoader{
            id: vipnagorgialla
            source: "qrc:/fonts/Vipnagorgialla Rg.otf"
        }

        RowLayout
        {
            spacing: 20
            anchors.fill: parent

            CyberNavbar
            {
                height: parent.height - 100
                width: 600

                Layout.fillWidth: true
                Layout.minimumWidth: 50
                Layout.preferredWidth: 600
                Layout.maximumWidth: 600
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20

                ColumnLayout {
                    id: navbarColumn
                    width: 450
                    height: 500
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 20
                    anchors.verticalCenterOffset: -110

                    spacing: 0
                    clip: false

                    CyberSelectButton {
                        id: thermalButton
                        displayText: "THERMAL"
                        active: true

                        onCliced: {
                            deactivateAll()
                            active = true
                            tabsStack.currentIndex = 0
                            currentTab = 0
                        }
                    }

                    CyberSelectButton {
                        id: profileButton
                        displayText: "PROFILES"

                        onCliced: {
                            deactivateAll()
                            active = true
                            tabsStack.currentIndex = 1
                            currentTab = 1
                        }
                    }

                    CyberSelectButton {
                        id: keyboardButton
                        displayText: "KEYBOARD"

                        onCliced: {
                            deactivateAll()
                            active = true
                            tabsStack.currentIndex = 2
                            currentTab = 2
                        }
                    }

                    CyberSelectButton {
                        id: batteryButton
                        displayText: "BATTERY"

                        onCliced: {
                            deactivateAll()
                            active = true
                            tabsStack.currentIndex = 2
                            currentTab = 3
                        }
                    }

                    CyberSelectButton {
                        id: miscButton
                        displayText: "MISC"

                        onCliced: {
                            deactivateAll()
                            active = true
                            tabsStack.currentIndex = 3
                            currentTab = 4
                        }
                    }
                }
            }

            StackLayout {
                Layout.leftMargin: 10
                Layout.rightMargin: 40
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: tabsStack
                // color: "transparent"
                currentIndex: 0

                RowLayout
                {
                    anchors.fill: parent
                    spacing: 20

                    ColumnLayout {
                        id: column1
                        Layout.fillWidth: true
                        Layout.minimumWidth: 50
                        Layout.preferredWidth: 600
                        Layout.maximumWidth: 600
                        Layout.fillHeight: true
                        anchors.top: parent.Center

                        spacing: 0
                        clip: false

                        CyberLabel {
                            id: cpuLabel
                            Layout.fillWidth: true
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 100
                            Layout.maximumHeight: 100


                            height: 100
                            anchors.horizontalCenter: parent.horizontalCenter


                            Timer {
                                interval: 1000  // 2 seconds
                                running: true   // Start automatically
                                repeat: true    // Keep running indefinitely
                                onTriggered: {
                                    // console.log(writer.getGpuTemperature())
                                    cpuLabel.temperature = writer.getCpuTemperature()
                                    // cyberLabel.temperature = 0
                                }
                            }

                        }



                        SpeedoMeter {
                            id: cpuMeter
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 400
                            Layout.maximumHeight: 400
                            width: 400
                            height: 400

                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        CyberToggleGroup {
                            Layout.preferredWidth: parent.width - 80
                            // Layout.fillWidth: true
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 60
                            Layout.maximumHeight: 60
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        CyberSlider {
                            id: cpuSlider
                            width: parent.width
                            Layout.fillWidth: true
                            Layout.topMargin: 40
                            height: 60
                            stepsize: 1
                            valueWrapper: 0

                            to: 100
                            from: 0
                            anchors.horizontalCenter: parent.horizontalCenter

                            Timer {
                                id: sliderTimer
                                interval: 500  // Wait 500ms after last change
                                onTriggered: {
                                    if (initializeCpu)
                                    {
                                        writer.setFanSpeed(cpuSlider.valueWrapper, gpuSlider.valueWrapper)
                                    }
                                }
                            }

                            onValueChangedWrapper: {
                                if (initializeCpu)
                                {
                                    cpuMeter.level = cpuSlider.valueWrapper
                                    sliderTimer.restart()  // Reset the timer on every change
                                }
                            }
                        }
                    }

                    ColumnLayout {
                        id: column2
                        Layout.fillWidth: true
                        Layout.minimumWidth: 50
                        Layout.preferredWidth: 600
                        Layout.maximumWidth: 600
                        anchors.top: parent.Center
                        // Layout.fillHeight: true

                        spacing: 0
                        clip: false

                        CyberLabel {
                            id: gpuLabel
                            Layout.fillWidth: true
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 150
                            Layout.maximumHeight: 150


                            height: 150
                            anchors.horizontalCenter: parent.horizontalCenter


                            Timer {
                                interval: 5000  // 2 seconds
                                running: true   // Start automatically
                                repeat: true    // Keep running indefinitely
                                onTriggered: {
                                    // console.log(writer.getGpuTemperature())
                                    gpuLabel.temperature = writer.getGpuTemperature()
                                    // cyberLabel.temperature = 0
                                }
                            }

                        }

                        SpeedoMeter {
                            id: gpuMeter
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 400
                            Layout.maximumHeight: 400
                            width: 400
                            height: 400

                            anchors.horizontalCenter: parent.horizontalCenter

                        }

                        CyberToggleGroup {
                            Layout.preferredWidth: parent.width - 80
                            // Layout.fillWidth: true
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 60
                            Layout.maximumHeight: 60
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        CyberSlider {
                            id: gpuSlider
                            width: parent.width
                            Layout.fillWidth: true
                            Layout.topMargin: 40
                            height: 60
                            stepsize: 1
                            valueWrapper: 0

                            to: 100
                            from: 0
                            anchors.horizontalCenter: parent.horizontalCenter

                            Timer {
                                id: sliderTimer1
                                interval: 500
                                onTriggered: {
                                    if (initializeGpu)
                                    {
                                        writer.setFanSpeed(cpuSlider.valueWrapper, gpuSlider.valueWrapper)
                                    }
                                }
                            }

                            onValueChangedWrapper:
                            {
                                if (initializeGpu)
                                {
                                    gpuMeter.level = gpuSlider.valueWrapper
                                    sliderTimer1.restart()  // Reset the timer on every change
                                }
                            }
                        }

                    }
                }

                RowLayout {
                    // Layout.fillWidth: true
                    // Layout.fillHeight: true
                    spacing: 20

                    anchors.fill: parent
                    anchors.topMargin: 180
                    anchors.rightMargin: 0

                    CyberModeButton {
                        width: (parent.width - 20 * 3) / 4;
                        mode: "QUIET"
                        description: "Perfect for classrooms"
                        source: "qrc:/images/cyber_mode_quiet.png"

                        onClickedWrapper:
                        {
                            writer.setPlatformProfile("quiet");
                        }
                    }

                    CyberModeButton {
                        width: (parent.width - 20 * 3) / 4;
                        mode: "BALANCED"
                        description: "Daily use"
                        source: "qrc:/images/cyber_mode_balanced.png"

                        onClickedWrapper:
                        {
                            writer.setPlatformProfile("balanced");
                        }
                    }

                    CyberModeButton {
                        width: (parent.width - 20 * 3) / 4;
                        mode: "HEAVY"
                        description: "For heavy workflows"
                        source: "qrc:/images/cyber_mode_heavy.png"

                        onClickedWrapper:
                        {
                            writer.setPlatformProfile("balanced-performance");
                        }
                    }

                    CyberModeButton {
                        width: (parent.width - 20 * 3) / 4;
                        mode: "TURBO"
                        description: "CPU and GPU Overclocked"
                        source: "qrc:/images/cyber_mode_turbo.png"

                        onClickedWrapper:
                        {
                            writer.setPlatformProfile("performance");
                        }
                    }
                }

                ColumnLayout {

                    id: batterySection
                    anchors.fill: parent
                    spacing: 30

                    anchors.topMargin: 180
                    anchors.rightMargin: 20

                    RowLayout {

                        Layout.fillWidth: true
                        spacing: 30

                        CyberMiscItem {
                            id: batterylimiterItem
                            Layout.fillWidth: true
                            height: 379
                            active: batterylimiterActive

                            onStateChangedWrapper: {
                                console.log("hello");
                                writer.setLCDOverdrive(lcdItem.active);
                            }

                            heading: "BATTERY LIMITER"
                            description: "Limits battery charging to 80%, preserving battery health for laptops primarily used while plugged into AC power"
                        }

                        CyberMiscItem {
                            id: batterycalibrationItem
                            Layout.fillWidth: true
                            height: 379
                            active: batterycalibrationActive

                            onStateChangedWrapper: {
                                writer.setBootAnimationSound(bootItem.active);
                            }

                            heading: "BATTERY CALIBRATION"
                            description: "This function calibrates your battery to provide a more accurate percentage reading. It involves charging the battery to 100%, draining it to 0%, and recharging it back to 100%. Do not unplug the laptop from AC power during calibration."
                        }

                    }

                    RowLayout {

                        Layout.fillWidth: true
                        spacing: 30

                        CyberMiscItem {
                            id: usbchargingItem
                            Layout.fillWidth: true
                            height: 379
                            width: batterycalibrationItem.width
                            active: usbchargingActive

                            onStateChangedWrapper: {
                                writer.setBacklightTimeout(backlightItem.active);
                            }

                            heading: "USB CHARGING"
                            description: "Allows the USB charging port to provide power even when the laptop is off"
                        }
                    }
                }

                ColumnLayout {

                    anchors.fill: parent
                    spacing: 30

                    anchors.topMargin: 180
                    anchors.rightMargin: 20

                    RowLayout {

                        Layout.fillWidth: true
                        spacing: 30

                        CyberMiscItem {
                            id: lcdItem
                            Layout.fillWidth: true
                            height: 379
                            active: lcdoverrideActive

                            onStateChangedWrapper: {
                                console.log("hello");
                                writer.setLCDOverdrive(lcdItem.active);
                            }

                            heading: "LCD OVERDRIVE"
                            description: "Reduces LCD latency and minimizes ghosting"
                        }

                        CyberMiscItem {
                            id: bootItem
                            Layout.fillWidth: true
                            height: 379
                            active: bootsoundActive

                            onStateChangedWrapper: {
                                writer.setBootAnimationSound(bootItem.active);
                            }

                            heading: "BOOT ANIMATION SOUND"
                            description: "Enables or disables custom boot animation and sound"
                        }

                    }

                    RowLayout {

                        Layout.fillWidth: true
                        spacing: 30

                        CyberMiscItem {
                            id: backlightItem
                            // Layout.fillWidth: true
                            width: bootItem.width
                            height: 379
                            active: backlightActive

                            onStateChangedWrapper: {
                                writer.setBacklightTimeout(backlightItem.active);
                            }

                            heading: "BACKLIGHT TIMEOUT"
                            description: "This feature turns off the keyboard RGB after 30 seconds of idle mode"
                        }

                        // CyberMiscItem {
                        //     id: cyberMiscItems4
                        //     Layout.fillWidth: true
                        //     x: 730
                        //     y: 129
                        //     width: 536
                        //     height: 379

                        //     heading: "BOOT ANIMATION SOUND"
                        //     description: "Enables or disables custom boot animation and sound."
                        // }
                    }
                }
            }
        }
    }
}
