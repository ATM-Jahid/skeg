import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../components"
import "../../config"

ColumnLayout {
    id: root
    required property var screen
    spacing: 3

    property var monitor: Hyprland.monitorFor(screen)

    Repeater {
        model: 10

        BarButton {
            required property int index
            readonly property int workspaceId: index + 1

            Layout.alignment: Qt.AlignHCenter
            implicitWidth: 36
            implicitHeight: 30
            text: workspaceId.toString()
            active: root.monitor?.activeWorkspace?.id === workspaceId
            foreground: active ? Theme.accent : Theme.muted

            onClicked: {
                const command = Hyprland.usingLua
                    ? "hl.dsp.focus({ workspace = \"" + workspaceId + "\" })"
                    : "workspace " + workspaceId;
                Hyprland.dispatch(command);
            }
        }
    }
}
