import QtQuick
import Quickshell
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
            radius: 0
            color: Theme.background

            BarContent {
                anchors.fill: parent
                screen: panel.screen
            }
        }
    }
}
