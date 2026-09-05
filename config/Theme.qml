pragma Singleton

import QtQuick

QtObject {
    readonly property color background: "#e6141720"
    readonly property color surface: "#ff202431"
    readonly property color surfaceHover: "#ff2a3040"
    readonly property color foreground: "#ffe7eaf0"
    readonly property color muted: "#ff8b93a7"
    readonly property color accent: "#ff8aadf4"
    readonly property color urgent: "#ffed8796"

    readonly property int barWidth: 24
    readonly property int radius: 10
    readonly property int spacing: 8
    readonly property int drawerWidth: 248
    readonly property int animationDuration: 50
    readonly property string fontFamily: "sans-serif"
}
