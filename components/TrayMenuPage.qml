import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import "../config"

FocusScope {
    id: root

    property QsMenuHandle handle
    property var entries: opener.children
    property bool canGoBack: false
    readonly property real contentHeight: list.contentHeight + (canGoBack ? 34 : 0)
    signal backRequested()
    signal submenuRequested(var menu)
    signal actionTriggered()
    signal closeRequested()

    QsMenuOpener { id: opener; menu: root.handle }

    function activate(entry) {
        if (!entry || entry.isSeparator || !entry.enabled) return;
        if (entry.hasChildren) root.submenuRequested(entry);
        else {
            entry.triggered();
            root.actionTriggered();
        }
    }

    function moveSelection(direction) {
        const start = list.currentIndex < 0 && direction < 0 ? 0 : list.currentIndex;
        for (let step = 1; step <= list.count; step++) {
            const index = (start + direction * step + list.count) % list.count;
            const row = list.itemAtIndex(index);
            if (row && !row.modelData.isSeparator && row.modelData.enabled) {
                list.currentIndex = index;
                list.positionViewAtIndex(index, ListView.Contain);
                return;
            }
        }
    }

    Keys.onEscapePressed: root.closeRequested()
    Keys.onLeftPressed: { if (root.canGoBack) root.backRequested(); }
    Keys.onUpPressed: moveSelection(-1)
    Keys.onDownPressed: moveSelection(1)
    Keys.onReturnPressed: activate(list.currentItem?.modelData)
    Keys.onEnterPressed: activate(list.currentItem?.modelData)
    Keys.onRightPressed: {
        const entry = list.currentItem?.modelData;
        if (entry?.hasChildren) activate(entry);
    }

    Button {
        id: back
        visible: root.canGoBack
        width: parent.width
        height: visible ? 34 : 0
        text: "‹  Back"
        onClicked: root.backRequested()
        contentItem: Text {
            text: back.text
            color: Theme.foreground
            font.family: Theme.fontFamily
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle { color: back.hovered ? Theme.surfaceHover : "transparent" }
    }

    ListView {
        id: list
        anchors { top: back.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
        model: root.entries
        clip: true
        currentIndex: -1
        // Keep all rows available for keyboard navigation, including offscreen rows.
        cacheBuffer: Math.max(0, contentHeight)
        ScrollBar.vertical: ScrollBar {}

        delegate: ItemDelegate {
            id: row
            required property var modelData
            required property int index
            width: list.width
            height: modelData.isSeparator ? 9 : 32
            enabled: !modelData.isSeparator && modelData.enabled
            hoverEnabled: true
            onHoveredChanged: { if (hovered) list.currentIndex = index; }
            onClicked: root.activate(modelData)
            background: Rectangle {
                radius: 4
                color: row.enabled && (row.hovered || list.currentIndex === row.index)
                    ? Theme.surfaceHover : "transparent"
                Rectangle {
                    visible: row.modelData.isSeparator
                    anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter; margins: 6 }
                    height: 1
                    color: Theme.muted
                    opacity: 0.35
                }
            }
            contentItem: Item {
                visible: !row.modelData.isSeparator
                opacity: row.enabled ? 1 : 0.4
                Text {
                    width: 18
                    anchors.verticalCenter: parent.verticalCenter
                    text: row.modelData.checkState === Qt.PartiallyChecked ? "−"
                        : row.modelData.checkState === Qt.Checked
                            ? (row.modelData.buttonType === QsMenuButtonType.RadioButton ? "●" : "✓") : ""
                    color: Theme.foreground
                    horizontalAlignment: Text.AlignHCenter
                }
                Image {
                    id: icon
                    x: 22
                    anchors.verticalCenter: parent.verticalCenter
                    width: 16; height: 16
                    source: row.modelData.icon
                    sourceSize: Qt.size(16, 16)
                }
                Text {
                    x: icon.source.toString() ? 44 : 22
                    width: parent.width - x - 18
                    anchors.verticalCenter: parent.verticalCenter
                    // D-Bus menu labels use & for mnemonics and && for a literal &.
                    text: row.modelData.text.replace(/&&/g, "\u0000").replace(/&/g, "").replace(/\u0000/g, "&")
                    textFormat: Text.PlainText
                    elide: Text.ElideRight
                    color: Theme.foreground
                    font.family: Theme.fontFamily
                    font.pixelSize: 13
                }
                Text {
                    anchors { right: parent.right; verticalCenter: parent.verticalCenter }
                    text: row.modelData.hasChildren ? "›" : ""
                    color: Theme.foreground
                }
            }
        }
    }
}
