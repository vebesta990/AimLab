import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Window {
    id: playWindow
    title: qsTr("Aim Lab")
    property int screenWidth: 1920
    property int screenHeight: 1080
    property int size: 100
    property int rad: size / 2
    property int offsetScrean: 25
    property int offsetСircle: 25
    property int timerInterval: 500
    property int maxCount: 11
    property int redCount: 0
    property int xPlace
    property int yPlace
    property int hitCounter: 0
    property int hitGreenCounter: 0
    property int hitRedCounter: 0
    property int missCounter: 0
    property int scoreCounter: 0
    property int speed: 1
    property int scoreMultiplier: 10
    property string backgroundID: "qrc:/resources/images/background_game.jpg"
    property string colorСircles: "red"
    property string timerBeforeStartText: "3"

    function startTimerBeforeStart() {
        timerBeforeStart.start();
    }

    function findingСoordinates() {
        var failureFlag = false;
        var i;
        while(1) {
            xPlace = Math.floor(Math.random() * (screenWidth - offsetScrean - offsetScrean - rad - rad + 1)) + offsetScrean + rad;
            yPlace = Math.floor(Math.random() * (screenHeight - offsetScrean - offsetScrean - rad - rad + 1)) + offsetScrean + rad;

            if(((xPlace + rad + offsetScrean >= 899) && (xPlace - rad - offsetScrean <= 1022)) &&
                    (yPlace + rad + offsetScrean >= 11) && (yPlace - rad - offsetScrean <= 90))
                continue;

            if((xPlace + rad + offsetScrean >= 1834) && (yPlace + rad + offsetScrean >= 994))
                continue;

            if(listModel.count == 0)
                return;

            for(i = 0; i < listModel.count; ++i)
                if((Math.abs(xPlace - listModel.get(i).xPos) < size + offsetСircle) && (Math.abs(yPlace - listModel.get(i).yPos) < size + offsetСircle))
                    break;

            if(i === listModel.count)
                return;
        }
    }

    function newGame() {
        endGameWindow.visible = false;
        listModel.clear();
        hitCounter = 0;
        redCount = 0;
        hitGreenCounter = 0;
        hitRedCounter = 0;
        missCounter = 0;
        scoreCounter = 0;
        scoreMultiplier = 10;
        timerBeforeStartText = "3";
        timerBeforeStart.interval = 500;
        dimmingBeforeStarting.visible = true;
        textForTimerBeforeStart.visible = true;
        hitPanel.visible = true;
        exitButton.visible = true;
    }

    function formattingHitCounter() {
        if(hitCounter < 10)
            return ("00" + hitCounter);
        else if(hitCounter < 100)
            return ("0" + hitCounter);
        else if(hitCounter < 999)
            return hitCounter;
        else {
            timerForStartGeneration.stop();
            timerForDeleteGreen.stop();
            endGameWindow.visible = true;
            return hitCounter;
        }
    }

    function formattingPercentage() {
        if(hitCounter === 0 && missCounter === 0)
            return "0%";
        else
            return (Math.round(hitCounter / (hitCounter + missCounter) * 100) + "%");
    }

    function forTimerBeforeStart()
    {
        if(timerBeforeStartText === "3")
            timerBeforeStartText = "2";
        else if(timerBeforeStartText === "2")
            timerBeforeStartText = "1";
        else if(timerBeforeStartText === "1")
        {
            timerBeforeStart.interval = 250;
            timerBeforeStartText = "GO!";
        }
        else {
            timerBeforeStart.stop();
            textForTimerBeforeStart.visible = false;
            timerForStartGeneration.start();
            timerForDeleteGreen.start();
            dimmingBeforeStarting.visible = false;
        }
    }

    function colorCheck(color) {
        if (color === "red") {
            ++hitRedCounter;
            scoreCounter += scoreMultiplier;
            scoreMultiplier += 10;
            --redCount;
        }
        else {
            ++hitGreenCounter;
            scoreCounter -= 100;
            scoreMultiplier = 10;
        }
    }

    function deleteGreen() {
        for(var i = 0; i < listModel.count; ++i) {
            if(listModel.get(i).colorCircle === "green") {
                listModel.remove(i);
                return;
            }
        }
    }

    Image {
        id: backgroundImage
        source: backgroundID
    }

    Rectangle {
        id: backgroundDimmer
        anchors.fill: parent
        color: Qt.rgba(15/255, 15/255, 15/255, 0.5)

        MouseArea {
            anchors.fill: parent
            onClicked:  {
                ++missCounter
                scoreMultiplier = 10
            }
        }
    }

    Repeater {
        model: listModel
        Rectangle {
            width: size; height: width
            radius: rad
            color: colorCircle
            x: xPos - radius
            y: yPos - radius
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ++hitCounter
                    colorCheck(colorCircle)
                    listModel.remove(index)
                }
            }
        }
   }

   ListModel {
       id: listModel
   }

   Image {
       id: hitPanel
       source: "qrc:/resources/images/hit_panel.png"
       anchors.horizontalCenter: parent.horizontalCenter
       y: 10

       Text {
           id: hitCounterText
           x: 16
           y: 8
           font.pixelSize: 60
           font.family: "OCR A Extended"
           font.letterSpacing: -7
           color: "white"
           text: formattingHitCounter()
       }
   }

   Timer {
       id: timerForStartGeneration
       repeat: true
       interval: timerInterval
       onTriggered: {
           findingСoordinates()
           var newItem = {}
           newItem.xPos = xPlace
           newItem.yPos = yPlace
           newItem.colorCircle = (Math.random() < 0.25) ? "green" : "red"
           listModel.append(newItem)

           if(newItem.colorCircle === "red")
               ++redCount;

           if(redCount === maxCount) {
               timerForStartGeneration.stop();
               timerForDeleteGreen.stop();
               hitPanel.visible = false;
               exitButton.visible = false;
               endGameWindow.visible = true;
               listModel.clear();
           }
       }
   }

   Timer {
       id: timerBeforeStart
       repeat: true
       interval: 500
       onTriggered: forTimerBeforeStart()
   }

   Timer {
       id: timerForDeleteGreen
       repeat: true
       interval: timerInterval * 4
       onTriggered: deleteGreen()
   }

   Rectangle {
       id: dimmingBeforeStarting
       visible: true
       color: Qt.rgba(15/255, 15/255, 15/255, 0.75)
       anchors.fill: parent

       MouseArea {
           anchors.fill: parent
       }
   }

   Image {
       id: exitButton
       source: mouseAreaExitButton.pressed ? "qrc:/resources/images/exit_button_pressed.png" : "qrc:/resources/images/exit_button.png"
       x: 1833
       y: 993

       MouseArea {
           id: mouseAreaExitButton
           anchors.fill: exitButton
           onClicked: {
               timerBeforeStart.stop()
               timerForStartGeneration.stop()
               timerForDeleteGreen.stop()
               playWindow.close()
           }
       }
   }

   Rectangle {
       id: endGameWindow
       visible: false
       color: Qt.rgba(15/255, 15/255, 15/255, 0.75)
       anchors.fill: parent

       MouseArea {
           anchors.fill: parent
       }

       Image {
           source: "qrc:/resources/images/side_stroke.png"
           anchors.centerIn: parent
       }

       Image {
           source: "qrc:/resources/images/base.png"
           anchors.centerIn: parent
       }

       Image {
           source: "qrc:/resources/images/words.png"
           anchors.centerIn: parent
       }

       Image {
           source: "qrc:/resources/images/logo_for_end.png"
           anchors.centerIn: parent
       }

       Image {
           id: newGameButton
           source: mouseAreaNewGameButton.pressed ? "qrc:/resources/images/left_button_pressed.png" : "qrc:/resources/images/left_button.png"
           x: 810
           y: 671

           MouseArea {
               id: mouseAreaNewGameButton
               anchors.fill: newGameButton
               onClicked: {
                   newGame()
                   startTimerBeforeStart()
               }
           }
       }

       Image {
           id: backButtonEnd
           source: mouseAreaBackButtonEnd.pressed ? "qrc:/resources/images/right_button_pressed.png" : "qrc:/resources/images/right_button.png"
           x: 960
           y: 671

           MouseArea {
               id: mouseAreaBackButtonEnd
               anchors.fill: backButtonEnd
               onClicked: {
                   timerForStartGeneration.stop()
                   timerForDeleteGreen.stop()
                   playWindow.close()
               }
           }
       }

       Text {
           id: scoreCounterText
           anchors.horizontalCenter: parent.horizontalCenter
           y: 422
           font.pixelSize: 30
           font.family: "OCR A Extended"
           font.letterSpacing: -3
           color: "white"
           text: scoreCounter
       }

       Text {
           id: accuracyText
           anchors.horizontalCenter: parent.horizontalCenter
           y: 485
           font.pixelSize: 30
           font.family: "OCR A Extended"
           font.letterSpacing: -3
           color: "white"
           text: formattingPercentage()
       }

       Text {
           id: hitCounterText2
           anchors.horizontalCenter: parent.horizontalCenter
           y: 548
           font.pixelSize: 30
           font.family: "OCR A Extended"
           font.letterSpacing: -3
           color: "white"
           text: hitCounter
       }

       Text {
           id: hitGreenCounterText
           anchors.horizontalCenter: parent.horizontalCenter
           leftPadding: 150
           y: 548
           font.pixelSize: 20
           font.family: "OCR A Extended"
           font.letterSpacing: -3
           color: "green"
           text: hitGreenCounter
       }

       Text {
           id: hitRedCounterText
           anchors.horizontalCenter: parent.horizontalCenter
           rightPadding: 150
           y: 548
           font.pixelSize: 20
           font.family: "OCR A Extended"
           font.letterSpacing: -3
           color: "red"
           text: hitRedCounter
       }

       Text {
           id: missCounterText
           anchors.horizontalCenter: parent.horizontalCenter
           y: 611
           font.pixelSize: 30
           font.family: "OCR A Extended"
           font.letterSpacing: -3
           color: "white"
           text: missCounter
       }
   }

   Text {
       id: textForTimerBeforeStart
       anchors.centerIn: parent
       font.pixelSize: 120
       font.family: "OCR A Extended"
       font.letterSpacing: -20
       color: "white"
       text: timerBeforeStartText
   }
}
