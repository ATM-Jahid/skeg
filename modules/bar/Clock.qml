pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../components"
import "../../config"

Item {
    id: root

    implicitWidth: Theme.barWidth
    implicitHeight: timeColumn.implicitHeight + 12

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    ColumnLayout {
        id: timeColumn
        anchors.centerIn: parent
        spacing: 0

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

    MouseArea {
        anchors.fill: parent
        onClicked: calendar.visible = !calendar.visible
    }

    DrawerPopup {
        id: calendar
        anchorItem: root
        contentHeight: 286

        ColumnLayout {
            width: Theme.drawerWidth - 28
            spacing: 10

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: Qt.formatDateTime(clock.date, "MMMM yyyy")
                color: Theme.foreground
                font.family: Theme.fontFamily
                font.pixelSize: 16
                font.weight: Font.DemiBold
            }

            GridLayout {
                Layout.fillWidth: true
                columns: 7
                columnSpacing: 2
                rowSpacing: 5

                Repeater {
                    model: ["M", "T", "W", "T", "F", "S", "S"]
                    Text {
                        required property var modelData
                        Layout.preferredWidth: 27
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData
                        color: Theme.muted
                        font.family: Theme.fontFamily
                        font.pixelSize: 11
                    }
                }

                Repeater {
                    model: 42
                    delegate: Rectangle {
                        required property int index
                        readonly property date first: new Date(clock.date.getFullYear(), clock.date.getMonth(), 1)
                        readonly property int offset: (first.getDay() + 6) % 7
                        readonly property date cellDate: new Date(first.getFullYear(), first.getMonth(), index - offset + 1)
                        readonly property bool inMonth: cellDate.getMonth() === first.getMonth()
                        readonly property bool today: cellDate.toDateString() === clock.date.toDateString()

                        Layout.preferredWidth: 27
                        Layout.preferredHeight: 27
                        radius: 7
                        color: today ? Theme.accent : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: parent.cellDate.getDate()
                            color: parent.today ? Theme.background
                                : parent.inMonth ? Theme.foreground : Theme.muted
                            opacity: parent.inMonth || parent.today ? 1 : 0.45
                            font.family: Theme.fontFamily
                            font.pixelSize: 11
                            font.weight: parent.today ? Font.DemiBold : Font.Normal
                        }
                    }
                }
            }
        }
    }
}
