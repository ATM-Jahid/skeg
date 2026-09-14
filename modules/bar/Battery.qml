import QtQuick
import QtQuick.Shapes
import Quickshell.Services.UPower
import "../../config"

Item {
    id: battery
    implicitWidth: Theme.barWidth
    implicitHeight: visible ? 42 : 0
    visible: UPower.displayDevice.ready && UPower.displayDevice.isPresent
    readonly property int percent: Math.round(UPower.displayDevice.percentage * 100)
    readonly property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

    Rectangle {
        id: batteryBody
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -1
        y: 5
        width: 18
        height: 10
        radius: 2
        color: "transparent"
        border.width: 1
        border.color: battery.percent <= 15 ? Theme.urgent : Theme.foreground
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 2
            width: Math.max(1, (parent.width - 4) * battery.percent / 100)
            radius: 1
            color: battery.charging ? Theme.charging : (battery.percent <= 15 ? Theme.urgent : Theme.accent)
        }
    }
    Rectangle {
        anchors.left: batteryBody.right
        anchors.verticalCenter: batteryBody.verticalCenter
        width: 2
        height: 6
        radius: 1
        color: battery.percent <= 15 ? Theme.urgent : Theme.foreground
    }
    Shape {
        anchors.centerIn: batteryBody
        width: 8
        height: 14
        visible: battery.charging

        ShapePath {
            strokeColor: Theme.background
            strokeWidth: 1
            fillColor: Theme.foreground
            startX: 5
            startY: 0
            PathLine { x: 0; y: 8 }
            PathLine { x: 3; y: 8 }
            PathLine { x: 2; y: 14 }
            PathLine { x: 8; y: 5 }
            PathLine { x: 5; y: 5 }
            PathLine { x: 5; y: 0 }
        }
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        text: battery.percent
        color: battery.percent <= 15 ? Theme.urgent : Theme.muted
        font.family: Theme.fontFamily
        font.pixelSize: 11
    }
}
