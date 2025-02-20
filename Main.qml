import QtQuick
import QtQuick.Controls
import PredatorBlue
import QtQuick.Studio.Components 1.0
import QtQuick3D.Particles3D 6.2
import org.bluebottle.SysfsWriter
import QtQuick.Layouts

Window {
    visible: true
    // color: "#0d143d"

    property bool initializeCpu: false;
    property bool initializeGpu: false;

    function deactivateAll() {
        cyberpunkButton.active = false;
        cyberpunkButton1.active = false;
        cyberpunkButton2.active = false;
        cyberpunkButton3.active = false;
        cyberpunkButton4.active = false;
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
            source: "qrc:/fonts/CyberAlert-xRv8j.otf"
        }

        Component.onCompleted: {
            console.log(writer.getCpuFanSpeed());
            console.log(writer.getGpuFanSpeed());
            cpuSlider.valueWrapper = Math.round(writer.getCpuFanSpeed());
            gpuSlider.valueWrapper = Math.round(writer.getGpuFanSpeed());

            cpuMeter.level = cpuSlider.valueWrapper
            gpuMeter.level = gpuSlider.valueWrapper

            initializeCpu = true;
            initializeGpu = true;
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
                        id: cyberpunkButton
                        displayText: "THERMAL"

                        onCliced: {
                            deactivateAll()
                            active = true
                        }
                    }

                    CyberSelectButton {
                        id: cyberpunkButton1
                        displayText: "PROFILES"

                        onCliced: {
                            deactivateAll()
                            active = true
                        }
                    }

                    CyberSelectButton {
                        id: cyberpunkButton2
                        displayText: "KEYBOARD"

                        onCliced: {
                            deactivateAll()
                            active = true
                        }
                    }

                    CyberSelectButton {
                        id: cyberpunkButton3
                        displayText: "MISC"

                        onCliced: {
                            deactivateAll()
                            active = true
                        }
                    }

                    CyberSelectButton {
                        id: cyberpunkButton4
                        displayText: "BATTERY"

                        onCliced: {
                            deactivateAll()
                            active = true
                        }
                    }
                }
            }

            Rectangle {
                Layout.leftMargin: 10
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

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
                        anchors.top: parent.top

                        spacing: 20
                        clip: false

                        CyberLabel {
                            id: cpuLabel
                            Layout.fillWidth: true
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 150
                            Layout.maximumHeight: 150


                            height: 150
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
                            Layout.fillWidth: true
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 500
                            Layout.maximumHeight: 500
                            width: 500

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
                        anchors.top: parent.top
                        // Layout.fillHeight: true

                        spacing: 20
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
                            Layout.fillWidth: true
                            Layout.topMargin: 40
                            Layout.minimumHeight: 50
                            Layout.preferredHeight: 500
                            Layout.maximumHeight: 500
                            width: 500
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
            }
        }
    }
}
