import QtQuick
import Quickshell
import "../config"

PopupWindow {
    id: root

    required property Item anchorItem
    default property alias contentData: content.data
    property int padding: Theme.popupPadding
    // Dimensions include the panel padding.
    property int contentWidth: content.childrenRect.width + padding * 2
    property int contentHeight: content.childrenRect.height + padding * 2

    implicitWidth: contentWidth
    implicitHeight: contentHeight
    color: "transparent"
    grabFocus: true

    anchor.item: anchorItem
    anchor.edges: Edges.Right
    anchor.gravity: Edges.Right
    anchor.margins.left: 0

    // Keep the panel outside the default property used by derived content.
    data: Rectangle {
        anchors.fill: parent
        color: Theme.popupBackground
        radius: Theme.popupRadius
        border.width: Theme.popupBorderWidth
        border.color: Theme.popupBorderColor

        Item {
            id: content
            anchors.fill: parent
            anchors.margins: root.padding
        }
    }
}
