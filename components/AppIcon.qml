import QtQuick
import Quickshell
import Quickshell.Widgets
import "../config"
import "DesktopEntryLookup.js" as DesktopEntryLookup

Item {
    id: root

    required property var appIds
    property int entriesRevision: 0
    readonly property var desktopEntry: {
        // Lookup methods don't notify QML when the asynchronous scan finishes.
        root.entriesRevision;
        return DesktopEntryLookup.lookup(
            root.appIds,
            DesktopEntries.applications.values,
            id => DesktopEntries.byId(id)
        );
    }
    readonly property bool iconReady: icon.status === Image.Ready

    Connections {
        target: DesktopEntries
        function onApplicationsChanged() { root.entriesRevision++; }
    }

    Text {
        anchors.centerIn: parent
        visible: !root.iconReady
        text: (root.appIds.find(id => id && id.length > 0) || "?").charAt(0).toUpperCase()
        color: Theme.muted
        font.family: Theme.fontFamily
        font.pixelSize: 12
        font.weight: Font.DemiBold
    }

    IconImage {
        id: icon
        anchors.fill: parent
        anchors.margins: 2
        // Keep loading independent of visibility (including ancestor visibility).
        source: root.desktopEntry?.icon ? Quickshell.iconPath(root.desktopEntry.icon, true) : ""
        visible: root.iconReady
    }
}
