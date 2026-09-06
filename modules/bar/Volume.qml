import QtQuick
import Quickshell.Services.Pipewire
import "../../config"

Item {
    id: volume

    PwObjectTracker { objects: [Pipewire.defaultAudioSink] }
    implicitWidth: Theme.barWidth
    implicitHeight: 42
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property int percent: sink?.audio ? Math.round(sink.audio.volume * 100) : 0

    Column {
        anchors.centerIn: parent
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: volume.sink?.audio?.muted ? "MUTE" : "VOL"
            color: volume.sink?.audio?.muted ? Theme.urgent : Theme.foreground
            font.family: Theme.fontFamily
            font.pixelSize: 9
            font.weight: Font.DemiBold
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: volume.sink?.audio ? volume.percent : "--"
            color: Theme.muted
            font.family: Theme.fontFamily
            font.pixelSize: 11
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: if (volume.sink?.audio) volume.sink.audio.muted = !volume.sink.audio.muted
        onWheel: wheel => {
            if (!volume.sink?.audio || volume.sink.audio.muted) return;
            // A standard wheel notch is 120 units; change volume by 1% per notch.
            const delta = wheel.angleDelta.y / 120 * 0.01;
            if (delta === 0) return;
            volume.sink.audio.volume = Math.max(0, Math.min(1, volume.sink.audio.volume + delta));
        }
    }
}
