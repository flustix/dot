import QtQml

QtObject {
    property string id
    property string name
    property string state

    readonly property bool connected: state.startsWith("connected")
}
