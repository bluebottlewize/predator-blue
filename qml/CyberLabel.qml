import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 320
    height: 150

    property int temperature: 0;

    BorderImage {
        id: borderImage
        anchors.fill: parent
        source: "qrc:/images/cyber_label.png"


        Text {
            id: text1
            color: "#628fd1"
            text: qsTr(temperature + "°C")
            font.pixelSize: 75
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Cyber Alert"
        }
    }
}
