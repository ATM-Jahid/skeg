import QtQuick
import QtQuick.Controls.Basic
import Quickshell

BasePopup {
    id: root

    property QsMenuHandle menu

    contentWidth: 280
    contentHeight: Math.min((stack.currentItem?.contentHeight ?? 0) + padding * 2,
        screen ? screen.height - 24 : 600)

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

    StackView {
        id: stack
        anchors.fill: parent
        clip: true
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
