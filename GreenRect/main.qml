import QtQuick

Window {
    //width: 640
    //height: 480
    visible: true
    title: qsTr("Hello World")
    //visibility: Window.FullScreen

    Rectangle
    {
        anchors.fill: parent
        color: "red"
    }

    Rectangle
    {
        anchors.fill: parent
        anchors.margins: 5
        color: "green"
    }
}
