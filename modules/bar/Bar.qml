import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../config"

Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
        id: panel
        required property var modelData

        screen: modelData
        implicitWidth: Theme.barWidth
        color: "transparent"
        exclusionMode: ExclusionMode.Auto

        anchors {
            top: true
            bottom: true
            left: true
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: 6
            radius: Theme.radius
            color: Theme.background
            border.width: 1
            border.color: "#18ffffff"

            BarContent {
                anchors.fill: parent
                screen: panel.screen
            }
        }
    }
}
