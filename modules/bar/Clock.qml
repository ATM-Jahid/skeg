import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../config"

ColumnLayout {
    spacing: 0

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatDateTime(clock.date, "HH")
        color: Theme.foreground
        font.family: Theme.fontFamily
        font.pixelSize: 14
        font.weight: Font.DemiBold
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatDateTime(clock.date, "mm")
        color: Theme.muted
        font.family: Theme.fontFamily
        font.pixelSize: 12
    }
}
