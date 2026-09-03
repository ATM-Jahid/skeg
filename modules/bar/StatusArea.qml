import QtQuick
import QtQuick.Layouts
import "../../components"
import "../../config"

ColumnLayout {
    spacing: 2

    BarButton {
        Layout.alignment: Qt.AlignHCenter
        implicitHeight: 32
        text: "●"
        foreground: Theme.accent
        onClicked: console.log("Network module is not wired yet")
    }

    BarButton {
        Layout.alignment: Qt.AlignHCenter
        implicitHeight: 32
        text: "♪"
        onClicked: console.log("Audio module is not wired yet")
    }
}
