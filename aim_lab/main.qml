import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import QtQml 2.12


Window {
    id: mainWindow
    visible: true
    visibility: Window.FullScreen
    title: qsTr("Aim Lab")

    function changingSettings() {
        playWindow.size = settingsWindow.size;
        playWindow.speed = settingsWindow.speed;
        playWindow.timerInterval = settingsWindow.timerInterval;
        playWindow.maxCount = settingsWindow.maxCount + 1;
        playWindow.colorСircles = settingsWindow.colorСircles;
        playWindow.backgroundID = settingsWindow.backgroundID;
    }

    Image {
        id: backgroundImage
        source: "qrc:/resources/images/background_menu.jpg"
    }

    Image {
        id: logoImage
        source: "qrc:/resources/images/logo.png"
    }

    ColumnLayout {
        id: clMain
        spacing: 28
        anchors.horizontalCenter: parent.horizontalCenter
        y: 419

        Button {
            id: startGameButton
            background: Rectangle {
                            implicitWidth: 402
                            implicitHeight: 102
                            radius: 10
                            Image {
                            source: startGameButton.pressed ? "qrc:/resources/images/play_pressed.png" : "qrc:/resources/images/play.png"
                            }
                        }
            onClicked: {
                changingSettings()
                playWindow.newGame()
                playWindow.visibility = Window.FullScreen
                playWindow.startTimerBeforeStart()
            }
        }

        Button {
            id: settingsButton
            background: Rectangle {
                            implicitWidth: 402
                            implicitHeight: 102
                            radius: 10
                            Image {
                            source: settingsButton.pressed ? "qrc:/resources/images/settings_pressed.png" : "qrc:/resources/images/settings.png"
                            }
                        }
            onClicked: {
                settingsWindow.visibility = Window.FullScreen
            }
        }

        Button {
            id: exitButton
            background: Rectangle {
                            implicitWidth: 402
                            implicitHeight: 102
                            radius: 10
                            Image {
                            source: exitButton.pressed ? "qrc:/resources/images/exit_pressed.png" : "qrc:/resources/images/exit.png"
                            }
                       }
            onClicked: Qt.quit()
        }
    }

    PlayWindow {
        id: playWindow
    }

    SettingsWindow {
        id: settingsWindow
    }
}
