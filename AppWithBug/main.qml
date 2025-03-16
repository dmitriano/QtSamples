import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow
{
    id: window
    visible: true
    width: 360
    height: 640
    title: appName

    font.pointSize: 18

    Menu
    {
        id: speedMenu
        title: qsTr("Bug Speed")

        MenuItem {
            text: qsTr("Slow", "female")
            checkable: true
        }

        MenuItem {
            text: qsTr("Medium", "female")
            checkable: true
        }

        MenuItem {
            text: qsTr("Fast", "female")
            checkable: true
        }
    }

    ColumnLayout
    {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10

        spacing: 10

        Button {
            text: "Show Menu"
            onClicked: speedMenu.open()
        }

        ComboBox {
            id: levelComboBox
            Layout.fillWidth: true
            model: levelListModel
        }
    }
}
