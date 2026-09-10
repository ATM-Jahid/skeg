import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import "../../config"

Column {
    id: tray

    width: Theme.barWidth
    spacing: Theme.spacing
    visible: items.count > 0

    Repeater {
        id: items
        model: SystemTray.items

        delegate: Rectangle {
            id: entry
            required property SystemTrayItem modelData

            width: Theme.barWidth
            height: Theme.barWidth
            radius: 4
            color: mouse.containsMouse ? Theme.surfaceHover : "transparent"

            Image {
                anchors.centerIn: parent
                width: 18
                height: 18
                source: entry.modelData.icon
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
            }

            QsMenuAnchor {
                id: menu
                menu: entry.modelData.menu
                anchor.item: entry
                anchor.edges: Edges.Right
                anchor.gravity: Edges.Right
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                onClicked: event => {
                    if (event.button === Qt.MiddleButton) {
                        entry.modelData.secondaryActivate();
                    } else if (event.button === Qt.RightButton || entry.modelData.onlyMenu) {
                        if (entry.modelData.hasMenu) menu.open();
                    } else {
                        entry.modelData.activate();
                    }
                }

                onWheel: event => {
                    if (event.angleDelta.y !== 0)
                        entry.modelData.scroll(event.angleDelta.y, false);
                    if (event.angleDelta.x !== 0)
                        entry.modelData.scroll(event.angleDelta.x, true);
                }
            }
        }
    }
}
