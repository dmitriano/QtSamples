import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import TableDemo

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    //visibility: Window.FullScreen

    TableModel {
        id: tableModel
    }

    ColumnLayout
    {
        anchors.fill: parent

        spacing: 5

        RowLayout
        {
            Layout.fillWidth: true

            spacing: 5

            Button {
                text: "Add Row"
                onClicked: tableModel.add()
            }

            Button {
                text: "Reset Model"
                onClicked: tableModel.resetModel()
            }

            Button {
                text: "Reset Counter"
                onClicked: tableModel.resetCounter()
            }
        }

        TableView
        {
            Layout.fillWidth: true
            Layout.fillHeight: true

            columnSpacing: 1
            rowSpacing: 1
            clip: true

            model: tableModel

            delegate: Rectangle {
                implicitWidth: 100
                implicitHeight: 50
                Text {
                    text: display
                }
            }
        }

    }

}
