import QtQuick
import QtQuick.Layouts
import "../../components"
import "../../config"

Item {
    id: root
    required property var screen

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 2
        spacing: Theme.spacing

        BarButton {
            Layout.alignment: Qt.AlignHCenter
            text: "Q"
            foreground: Theme.accent
            onClicked: console.log("Launcher module is not wired yet")
        }

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            implicitWidth: 24
            implicitHeight: 1
            color: "#28ffffff"
        }

        Workspaces {
            Layout.alignment: Qt.AlignHCenter
            screen: root.screen
        }

        Item { Layout.fillHeight: true }

        StatusArea {
            Layout.alignment: Qt.AlignHCenter
        }

        Clock {
            Layout.alignment: Qt.AlignHCenter
        }

        BarButton {
            Layout.alignment: Qt.AlignHCenter
            text: "⏻"
            foreground: Theme.urgent
            onClicked: console.log("Session menu is not wired yet")
        }
    }
}
