import QtQuick
import "../config"

Rectangle {
    id: root

    property alias text: label.text
    property color foreground: Theme.foreground
    property bool active: false
    signal clicked

    implicitWidth: 40
    implicitHeight: 40
    radius: 12
    color: mouse.containsMouse || active ? Theme.surfaceHover : "transparent"

    Text {
        id: label
        anchors.centerIn: parent
        color: root.foreground
        font.family: Theme.fontFamily
        font.pixelSize: 15
        font.weight: root.active ? Font.DemiBold : Font.Normal
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }

    Behavior on color {
        ColorAnimation { duration: 120 }
    }
}
