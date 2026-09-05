import QtQuick
import Quickshell
import "../config"

PopupWindow {
    id: root

    required property Item anchorItem
    default property alias contentData: content.data
    property int contentWidth: Theme.drawerWidth
    property int contentHeight: content.implicitHeight

    implicitWidth: contentWidth
    implicitHeight: contentHeight
    color: "transparent"
    grabFocus: true

    anchor.item: anchorItem
    anchor.edges: Edges.Right
    anchor.gravity: Edges.Right
    anchor.margins.left: 0

    Rectangle {
        id: drawer

        anchors.fill: parent
        x: root.visible ? 0 : -width
        color: Theme.background
        radius: Theme.radius
        border.width: 5
        border.color: "#18ffffff"

        Item {
            id: content
            anchors.fill: parent
            anchors.margins: 14
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height + 28
        }

        Behavior on x {
            NumberAnimation {
                duration: Theme.animationDuration
                easing.type: Easing.OutCubic
            }
        }
    }
}
