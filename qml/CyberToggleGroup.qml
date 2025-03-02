import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 6.0

Item {
    id: item1
    width: 800
    height: 70

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 10

        CyberToggleLeft {
            id: mouseArea
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        CyberToggleCenter {
            id: mouseArea1
            Layout.fillWidth: true
            Layout.fillHeight: true

        }

        CyberToggleRight {
            id: mouseArea2
            Layout.fillWidth: true
            Layout.fillHeight: true

        }

    }
}
