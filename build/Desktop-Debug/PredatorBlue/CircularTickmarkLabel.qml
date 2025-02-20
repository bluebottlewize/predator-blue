/****************************************************************************
**
** Copyright (C) 2014 Digia Plc
** All rights reserved.
** For any questions to Digia, please use contact form at http://qt.digia.com
**
** This file is part of the QtQuick Enterprise Controls Add-on.
**
** $QT_BEGIN_LICENSE$
** Licensees holding valid Qt Commercial licenses may use this file in
** accordance with the Qt Commercial License Agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.
**
** If you have questions regarding the use of this file, please use
** contact form at http://qt.digia.com
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
// Workaround for QTBUG-37751; we need this import for RangeModel, although we shouldn't.
import QtQuick.Controls
//import QtQuick.Controls.Private 1.0
//import QtQuick.Enterprise.Controls 1.3
//import QtQuick.Enterprise.Controls.Private 1.0
import com.memorymap.mm 1.0
import "Utils.js" as Utils

Control {
    id: control


    property alias minimumValue: range.minimumValue

    property alias maximumValue: range.maximumValue

    property alias stepSize: range.stepSize

    RangeModel {
        id: range
        minimumValue: 0
        maximumValue: 100
        stepSize: 0
        // Not used.
        value: minimumValue
    }

    /*!
        This property determines the angle at which the first tickmark is drawn.
    */
    property real minimumValueAngle: -145

    /*!
        This property determines the angle at which the last tickmark is drawn.
    */
    property real maximumValueAngle: 145

    /*!
        The range between \l minimumValueAngle and \l maximumValueAngle, in
        degrees.
    */
    readonly property real angleRange: maximumValueAngle - minimumValueAngle

    /*!
        The interval at which tickmarks are displayed.
    */
    property real tickmarkStepSize: 10

    /*!
        The distance in pixels from the outside of the control (outerRadius) at
        which the outermost point of the tickmark line is drawn.
    */
    property real tickmarkInset: 0.0

    /*!
        The amount of tickmarks displayed.
    */
    readonly property int tickmarkCount: __tickmarkCount

    /*!
        The amount of minor tickmarks between each tickmark.
    */
    property int minorTickmarkCount: 4

    /*!
        The distance in pixels from the outside of the control (outerRadius) at
        which the outermost point of the minor tickmark line is drawn.
    */
    property real minorTickmarkInset: 0.0

    /*!
        The distance in pixels from the outside of the control (outerRadius) at
        which the center of the value marker text is drawn.
    */
    property real labelInset: __protectedScope.toPixels(0.19)

    /*!
        The interval at which tickmark labels are displayed.
    */
    property real labelStepSize: tickmarkStepSize

    /*!
        The amount of tickmark labels displayed.
    */
    readonly property int labelCount: (maximumValue - minimumValue) / labelStepSize + 1

    /*! \internal */
    readonly property real __tickmarkCount: tickmarkStepSize > 0 ? (maximumValue - minimumValue) / tickmarkStepSize + 1 : 0

    /*!
        This property determines whether or not the control displays tickmarks,
        minor tickmarks, and labels.
    */
    property bool tickmarksVisible: true

    /*!
        Returns \a value as an angle in degrees.

        For example, if minimumValueAngle is set to \c 270 and maximumValueAngle
        is set to \c 90, this function will return \c 270 when passed
        minimumValue and \c 90 when passed maximumValue.
    */
    function valueToAngle(value) {
        var normalised = (value - minimumValue) / (maximumValue - minimumValue);
        return (maximumValueAngle - minimumValueAngle) * normalised + minimumValueAngle;
    }


    /*!
        The distance from the center of the control to the outer edge.
    */
    readonly property real outerRadius: Math.min(control.width, control.height) * 0.5

    property QtObject __protectedScope: QtObject {
        /*!
            Converts a value expressed as a percentage of \l outerRadius to
            a pixel value.
        */
        function toPixels(percentageOfOuterRadius) {
            return percentageOfOuterRadius * outerRadius;
        }
    }

    /*!
        This component defines each individual tickmark. The position of each
        tickmark is already set; only the size needs to be specified.
    */
    property Component tickmark: Rectangle {
        width: outerRadius * 0.02
        antialiasing: true
        height: outerRadius * 0.06
        color: "#c8c8c8"
    }

    /*!
        This component defines each individual minor tickmark. The position of
        each minor tickmark is already set; only the size needs to be specified.
    */
    property Component minorTickmark: Rectangle {
        width: outerRadius * 0.01
        antialiasing: true
        height: outerRadius * 0.03
        color: "#c8c8c8"
    }

    /*!
        This defines the text of each tickmark label on the gauge.
    */
    property Component tickmarkLabel: Text {
        font.pixelSize: Math.max(6, __protectedScope.toPixels(0.12))
        text: styleData.value
        color: "#c8c8c8"
        antialiasing: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    /*! \internal */
    Item {
        id: panelItem
        anchors.fill: parent


        function rangeUsed(count, stepSize) {
            return (((count - 1) * stepSize) / (control.maximumValue - control.minimumValue)) * control.angleRange;
        }

        readonly property real tickmarkSectionSize: rangeUsed(control.tickmarkCount, control.tickmarkStepSize) / (control.tickmarkCount - 1)
        readonly property real tickmarkSectionValue: (control.maximumValue - control.minimumValue) / (control.tickmarkCount - 1)
        readonly property real minorTickmarkSectionSize: tickmarkSectionSize / (control.minorTickmarkCount + 1)
        readonly property real minorTickmarkSectionValue: tickmarkSectionValue / (control.minorTickmarkCount + 1)
        readonly property int totalMinorTickmarkCount: {
            // The size of each section within two major tickmarks, expressed as a percentage.
            var minorSectionPercentage = 1 / (control.minorTickmarkCount + 1);
            // The amount of major tickmarks not able to be displayed; will be 0 if they all fit.
            var tickmarksNotDisplayed = control.__tickmarkCount - control.tickmarkCount;
            var count = control.minorTickmarkCount * (control.tickmarkCount - 1);
            // We'll try to display as many minor tickmarks as we can to fill up the space.
            count + tickmarksNotDisplayed / minorSectionPercentage;
        }
        readonly property real labelSectionSize: rangeUsed(control.labelCount, control.labelStepSize) / (control.labelCount - 1)

        function toPixels(percentageOfOuterRadius) {
            return percentageOfOuterRadius * outerRadius;
        }

        /*!
            Returns the angle of \a marker (in the range 0 ... n - 1, where n
            is the amount of markers) on the gauge where sections are of size
            tickmarkSectionSize.
        */
        function tickmarkAngleFromIndex(tickmarkIndex) {
            return tickmarkIndex * tickmarkSectionSize + control.minimumValueAngle;
        }

        function labelAngleFromIndex(labelIndex) {
            return labelIndex * labelSectionSize + control.minimumValueAngle;
        }

        function labelPosFromIndex(index, labelWidth, labelHeight) {
            return Utils.centerAlongCircle(outerRadius, outerRadius, labelWidth, labelHeight,
                Utils.degToRadOffset(labelAngleFromIndex(index)),
                outerRadius - control.labelInset)
        }

        function minorTickmarkAngleFromIndex(minorTickmarkIndex) {
            var baseAngle = tickmarkAngleFromIndex(Math.floor(minorTickmarkIndex / control.minorTickmarkCount));
            // + minorTickmarkSectionSize because we don't want the first minor tickmark to start on top of its "parent" tickmark.
            var relativeMinorAngle = (minorTickmarkIndex % control.minorTickmarkCount * minorTickmarkSectionSize) + minorTickmarkSectionSize;
            return baseAngle + relativeMinorAngle;
        }

        function tickmarkValueFromIndex(majorIndex) {
            return (majorIndex * tickmarkSectionValue) + control.minimumValue;
        }

        function tickmarkValueFromMinorIndex(minorIndex) {
            var majorIndex = Math.floor(minorIndex / control.minorTickmarkCount);
            var relativeMinorIndex = minorIndex % control.minorTickmarkCount;
            return tickmarkValueFromIndex(majorIndex) + ((relativeMinorIndex * minorTickmarkSectionValue) + minorTickmarkSectionValue);
        }

        Loader {
            active: control.tickmarksVisible && tickmark != null
            width: outerRadius * 2
            height: outerRadius * 2
            anchors.centerIn: parent

            sourceComponent: Repeater {
                id: tickmarkRepeater
                model: control.tickmarkCount
                delegate: Loader {
                    id: tickmarkLoader
                    x: tickmarkRepeater.width / 2
                    y: tickmarkRepeater.height / 2

                    transform: [
                        Translate {
                            y: -outerRadius + control.tickmarkInset
                        },
                        Rotation {
                            angle: panelItem.tickmarkAngleFromIndex(styleData.index) - __tickmarkWidthAsAngle / 2
                        }
                    ]

                    sourceComponent: tickmark

                    property int __index: index
                    property QtObject styleData: QtObject {
                        readonly property alias index: tickmarkLoader.__index
                        readonly property real value: panelItem.tickmarkValueFromIndex(index)
                    }

                    readonly property real __tickmarkWidthAsAngle: Utils.radToDeg((width / (Utils.pi2 * outerRadius)) * Utils.pi2)
                }
            }
        }
        Loader {
            active: control.tickmarksVisible && minorTickmark != null
            width: outerRadius * 2
            height: outerRadius * 2
            anchors.centerIn: parent

            sourceComponent: Repeater {
                id: minorRepeater
                anchors.fill: parent
                model: panelItem.totalMinorTickmarkCount
                delegate: Loader {
                    id: minorTickmarkLoader
                    x: minorRepeater.width / 2
                    y: minorRepeater.height / 2
                    transform: [
                        Translate {
                            y: -outerRadius + control.minorTickmarkInset
                        },
                        Rotation {
                            angle: panelItem.minorTickmarkAngleFromIndex(styleData.index) - __minorTickmarkWidthAsAngle / 2
                        }
                    ]

                    sourceComponent: minorTickmark

                    property int __index: index
                    property QtObject styleData: QtObject {
                        readonly property alias index: minorTickmarkLoader.__index
                        readonly property real value: panelItem.tickmarkValueFromMinorIndex(index)
                    }

                    readonly property real __minorTickmarkWidthAsAngle: Utils.radToDeg((width / (Utils.pi2 * outerRadius)) * Utils.pi2)
                }
            }
        }
        Loader {
            id: labelLoader
            active: control.tickmarksVisible && tickmarkLabel != null
            width: outerRadius * 2
            height: outerRadius * 2
            anchors.centerIn: parent

            sourceComponent: Item {
                id: labelItem
                width: outerRadius * 2
                height: outerRadius * 2
                anchors.centerIn: parent

                Connections {
                    target: control
                    function onMinimumValueChanged() { valueTextModel.update() }
                    function onMaximumValueChanged() { valueTextModel.update() }
                    function onTickmarkStepSizeChanged() { valueTextModel.update() }
                    function onLabelStepSizeChanged() { valueTextModel.update() }
                }

                Repeater {
                    id: labelItemRepeater

                    Component.onCompleted: valueTextModel.update();

                    model: ListModel {
                        id: valueTextModel

                        function update() {
                            if (control.labelStepSize === 0) {
                                return;
                            }

                            // Make bigger if it's too small and vice versa.
                            // +1 because we want to show 11 values, with, for example: 0, 10, 20... 100.
                            var difference = control.labelCount - count;
                            if (difference > 0) {
                                for (; difference > 0; --difference) {
                                    append({ value: 0 });
                                }
                            } else if (difference < 0) {
                                for (; difference < 0; ++difference) {
                                    remove(count - 1);
                                }
                            }

                            var index = 0;
                            for (var value = control.minimumValue;
                                 value <= control.maximumValue && index < count;
                                 value += control.labelStepSize, ++index) {
                                setProperty(index, "value", value);
                            }
                        }
                    }
                    delegate: Loader {
                        id: tickmarkLabelDelegateLoader
                        sourceComponent: tickmarkLabel
                        x: pos.x
                        y: pos.y

                        readonly property point pos: panelItem.labelPosFromIndex(index, width, height);

                        readonly property int __index: index
                        property QtObject styleData: QtObject {
                            readonly property var value: index != -1 ? labelItemRepeater.model.get(index).value : 0
                            readonly property alias index: tickmarkLabelDelegateLoader.__index
                        }
                    }
                }
            }
        }
    }
}
