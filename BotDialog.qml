import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog
{
    title: "Bot Settings"
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    property var bot1
    property var bot2
    property var bot3

    function fill()
    {
        if (bot1)
        {
            nameText1.text = bot1.p.name
        }

        if (bot2)
        {
            nameText2.text = bot2.p.name
        }

        if (bot3)
        {
            nameText3.text = bot3.p.name
        }
    }

    ColumnLayout
    {
        //anchors.fill: parent
        //anchors.margins: 5
        spacing: 5

        GridLayout
        {
            Layout.margins: 5
            Layout.fillWidth: true

            columns: 2
            flow: GridLayout.LeftToRight

            Label {
                text: qsTr("Bot1 Name:")
                Layout.alignment: Qt.AlignRight
            }

            TextEdit
            {
                id: nameText1
                //readOnly: botDialog.updating
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("Bot2 Name:")
                Layout.alignment: Qt.AlignRight
            }

            TextEdit
            {
                id: nameText2
                //readOnly: botDialog.updating
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("Bot3 Name:")
                Layout.alignment: Qt.AlignRight
            }

            TextEdit
            {
                id: nameText3
                //readOnly: botDialog.updating
                Layout.fillWidth: true
            }

        }
    }

    onAccepted:
    {
    }

    onRejected:
    {
    }

    Component.onCompleted:
    {
        console.log("BotDialog has been created.")

        console.log(JSON.stringify(bot1))
        console.log(JSON.stringify(bot2))
        console.log(JSON.stringify(bot3))

        fill()
    }

    Component.onDestruction:
    {
        if (bot1)
        {
            console.log("Destroying Dialog", bot1.p.name);
        }
        else
        {
            console.log("Destroying Dialog with unset bot1");
        }
    }
}
