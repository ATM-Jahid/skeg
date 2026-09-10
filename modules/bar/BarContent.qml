import QtQuick
import QtQuick.Layouts
import "../../config"

Item {
    id: root
    required property var screen

    ColumnLayout {
        anchors.fill: parent
        spacing: Theme.spacing

        Workspaces {
            Layout.alignment: Qt.AlignHCenter
            screen: root.screen
        }

        Item { Layout.fillHeight: true }

        Tray {
            Layout.alignment: Qt.AlignHCenter
        }

        Volume {
            Layout.alignment: Qt.AlignHCenter
        }

        Battery {
            Layout.alignment: Qt.AlignHCenter
        }

        Clock {
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
