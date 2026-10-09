import QtQuick

Item {
    id: anim

    required property bool state

    opacity: state ? 1 : 0
    property real move: state ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: 300
        }
    }

    Behavior on move {
        NumberAnimation {
            duration: 600
            easing: Easing.OutQuint
        }
    }
}