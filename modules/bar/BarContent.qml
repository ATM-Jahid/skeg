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

        StatusArea {
            Layout.alignment: Qt.AlignHCenter
        }

        Clock {
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
