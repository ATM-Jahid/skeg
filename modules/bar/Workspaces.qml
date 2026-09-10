pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../components"
import "../../config"

ColumnLayout {
    id: root

    required property var screen
    readonly property var monitor: Hyprland.monitorFor(screen)
    spacing: 3

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: workspaceItem

            required property var modelData
            readonly property bool onThisScreen: modelData.monitor === root.monitor

            Layout.alignment: Qt.AlignHCenter
            implicitWidth: Theme.barWidth
            implicitHeight: onThisScreen ? workspaceContents.implicitHeight + 8 : 0
            visible: onThisScreen
            color: modelData.focused ? Theme.surfaceHover : "transparent"

            MouseArea {
                anchors.fill: parent
                z: 0
                onClicked: {
                    const workspaceName = workspaceItem.modelData.name;
                    const command = Hyprland.usingLua
                        ? "hl.dsp.focus({ workspace = \"" + workspaceName + "\" })"
                        : "workspace " + workspaceName;
                    Hyprland.dispatch(command);
                }
            }

            ColumnLayout {
                id: workspaceContents
                anchors.centerIn: parent
                z: 1
                spacing: 3

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: workspaceItem.modelData.id > 0
                        ? workspaceItem.modelData.id.toString()
                        : workspaceItem.modelData.name
                    color: workspaceItem.modelData.focused ? Theme.accent : Theme.muted
                    font.family: Theme.fontFamily
                    font.pixelSize: 13
                    font.weight: workspaceItem.modelData.focused ? Font.DemiBold : Font.Normal
                }

                Repeater {
                    model: Hyprland.toplevels

                    delegate: Item {
                        id: appItem
                        required property var modelData
                        readonly property bool inWorkspace: modelData.workspace === workspaceItem.modelData

                        Layout.alignment: Qt.AlignHCenter
                        implicitWidth: inWorkspace ? 24 : 0
                        implicitHeight: inWorkspace ? 24 : 0
                        visible: inWorkspace

                        AppIcon {
                            anchors.fill: parent
                            appIds: [
                                appItem.modelData.wayland?.appId ?? "",
                                appItem.modelData.lastIpcObject?.["class"] ?? "",
                                appItem.modelData.lastIpcObject?.initialClass ?? ""
                            ]
                        }

                        Rectangle {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            width: 2
                            height: 12
                            radius: 1
                            color: appItem.modelData.urgent ? Theme.urgent : Theme.accent
                            visible: appItem.modelData.activated || appItem.modelData.urgent
                        }

                        MouseArea {
                            anchors.fill: parent
                            z: 2
                            onClicked: {
                                const address = appItem.modelData.address;
                                const command = Hyprland.usingLua
                                    ? "hl.dsp.focus({ window = \"address:0x" + address + "\" })"
                                    : "focuswindow address:" + address;
                                Hyprland.dispatch(command);
                            }
                        }
                    }
                }
            }

            Behavior on color {
                ColorAnimation { duration: Theme.animationDuration }
            }
        }
    }
}
