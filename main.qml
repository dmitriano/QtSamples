import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import GcBug

Window
{
    width: 640
    height: 480
    visible: true
    title: qsTr("GC Bug")
    id: mainWindow

    BotManager
    {
        id: bm
    }

    property var bot

    property var dynamicComp
    property var dynamicDlg

    function openBotDialog()
    {
        dynamicComp = Qt.createComponent("BotDialog.qml")
        dynamicDlg = dynamicComp.createObject(mainWindow, {"bot1" : bot});
        dynamicDlg.open()
    }

    function openBotDialog3()
    {
        dynamicComp = Qt.createComponent("BotDialog.qml")
        dynamicDlg = dynamicComp.createObject(mainWindow, {"bot1" : bot, "bot2" : bot, "bot3" : bot});
        dynamicDlg.open()
    }

    function openBotPageViaComponent()
    {
        dynamicComp = Qt.createComponent("BotPage.qml")
        dynamicDlg = dynamicComp.createObject(mainWindow, {"bot1" : bot, "bot2" : bot, "bot3" : bot});
        mainStack.push(dynamicDlg)
    }

    function openBotPageViaPush()
    {
        var url = Qt.resolvedUrl("BotPage.qml")

        console.log("url: ", url)

        if (url)
        {
            console.log("Creating BotPage...")

            mainStack.push(url, {"bot1" : bot, "bot2" : bot, "bot3" : bot})
        }
    }

    function openBotPageWithClone()
    {
        var url = Qt.resolvedUrl("BotPage.qml")

        console.log("url: ", url)

        if (url)
        {
            console.log("Creating BotPage...")

            mainStack.push(url, {"bot1" : bot.clone(), "bot2" : bot.clone(), "bot3" : bot.clone()})
        }
    }

    BotDialog
    {
        id: staticDlg
    }

    ColumnLayout
    {
        anchors.fill: parent

        Flow
        {
            spacing: 5

            Layout.fillWidth: true

            Button
            {
                text: "Create Bot"
                onClicked:
                {
                    bm.createBot("NotAssigned")
                }
            }

            Button
            {
                text: "Create and Assign"
                onClicked:
                {
                    bot = bm.createBot("Assigned")
                }
            }

            Button
            {
                text: "Dynamic Dialog"
                onClicked:
                {
                    bot = bm.createBot("Dynamic Dialog")
                    openBotDialog(bot)
                }
            }

            Button
            {
                text: "Dynamic Dialog 3"
                onClicked:
                {
                    bot = bm.createBot("Dynamic Dialog")
                    openBotDialog3()
                }
            }

            Button
            {
                text: "Static Dialog"
                onClicked:
                {
                    bot = bm.createBot("Static Dialog")
                    staticDlg.bot1 = bot
                    staticDlg.fill()
                    staticDlg.open()
                }
            }

            Button
            {
                text: "Clear Bot"
                onClicked:
                {
                    bot = undefined
                }
            }

            Button
            {
                text: "Clear Dynamic Dlg"
                onClicked:
                {
                    dynamicComp.destroy()
                    dynamicComp = null
                    dynamicDlg.destroy()
                    dynamicDlg = null
                }
            }

            Button
            {
                text: "Clear Dlg Refs"
                onClicked:
                {
                    dynamicComp = null
                    dynamicDlg = null
                }
            }

            Button
            {
                text: "Open Page Via Comp"
                onClicked:
                {
                    bot = bm.createBot("Page Comp")
                    openBotPageViaComponent()
                }
            }

            Button
            {
                text: "Open Page Via Push"
                onClicked:
                {
                    bot = bm.createBot("Page Push")
                    openBotPageViaPush()
                }
            }

            Button
            {
                text: "Open Page With Clone"
                onClicked:
                {
                    bot = bm.createBot("Page Clone")
                    openBotPageWithClone()
                }
            }

            Button
            {
                text: "Close Page"
                onClicked:
                {
                    mainStack.pop()
                }
            }

            Button
            {
                text: "GC"
                onClicked:
                {
                    gc()
                }
            }
        }

        StackView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true

            id: mainStack

            initialItem: Item {
                Text {
                    anchors.centerIn: parent
                    text: "Ready"
                }
            }
        }
    }
}
