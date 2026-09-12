import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import "../config"

PopupWindow {
    id: root

    required property Item anchorItem
    property QsMenuHandle menu

    anchor.item: anchorItem
    anchor.edges: Edges.Right
    anchor.gravity: Edges.Right
    implicitWidth: 280
    implicitHeight: Math.min((stack.currentItem?.contentHeight ?? 0) + 12,
        screen ? screen.height - 24 : 600)
    color: "transparent"
    grabFocus: true

    function open() {
        if (!menu) return;
        stack.clear();
        stack.push(page, { handle: menu }, StackView.Immediate);
        visible = true;
        stack.currentItem.forceActiveFocus();
    }

    function close() { visible = false; }

    onVisibleChanged: { if (!visible) stack.clear(); }
    onMenuChanged: close()

    Rectangle {
        anchors.fill: parent
        color: Theme.trayMenuBackground
        radius: 6
        border.color: Theme.surfaceHover

        StackView {
            id: stack
            anchors.fill: parent
            anchors.margins: 6
            clip: true
        }
    }

    Component {
        id: page
        TrayMenuPage {
            canGoBack: stack.depth > 1
            onBackRequested: {
                stack.pop(StackView.Immediate);
                stack.currentItem.forceActiveFocus();
            }
            onSubmenuRequested: submenu => {
                // Keep parent openers alive while navigating their child entries.
                stack.push(page, { handle: submenu }, StackView.Immediate);
                stack.currentItem.forceActiveFocus();
            }
            onActionTriggered: root.close()
            onCloseRequested: root.close()
        }
    }
}
