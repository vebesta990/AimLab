import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Window {
    id: settingsWindow
    title: qsTr("Aim Lab")
    property int size: 100
    property int timerInterval: 500
    property int speed: 1
    property int maxCount: 10
    property string backgroundID: "qrc:/resources/images/background_game2.jpg"
    property string colorСircles: "red"

    function changingInterval(value) {
        if(value === 0) {
            if(timerInterval === 100) {
                timerInterval -= 50;
                intervalLeftButton.visible = false;
                return;
            }
            else {
                intervalRightButton.visible = true;
                timerInterval -= 50;
            }
        }
        else {
            if(timerInterval === 1450) {
                timerInterval += 50;
                intervalRightButton.visible = false;
                return;
            }
            else {
                intervalLeftButton.visible = true;
                timerInterval += 50;
            }
        }
    }

    function changingMax(value) {
        if(value === 0) {
            if(maxCount === 4) {
                --maxCount;
                windowMaxLeftButton.visible = false;
                return;
            }
            else {
                windowMaxRightButton.visible = true;
                --maxCount;
            }
        }
        else {
            if(maxCount === 14) {
                ++maxCount;
                windowMaxRightButton.visible = false;
                return;
            }
            else {
                windowMaxLeftButton.visible = true;
                ++maxCount;
            }
        }
    }


    function changingSize(value) {
        if(value === 0) {
            if(size === 60) {
                size -= 10;
                changingSizeCirclesLeftButton.visible = false;
                return;
            }
            else {
                changingSizeCirclesRightButton.visible = true;
                size -= 10;
            }
        }
        else {
            if(size === 190) {
                size += 10;
                changingSizeCirclesRightButton.visible = false;
                return;
            }
            else {
                changingSizeCirclesLeftButton.visible = true;
                size += 10;
            }
        }
    }

    function changingSpeed(value) {
        if(value === 0) {
            if(speed === 1) {
                --speed;
                speedLeftButton.visible = false;
                return;
            }
            else {
                speedRightButton.visible = true;
                --speed;
            }
        }
        else {
            if(speed === 9) {
                ++speed;
                speedRightButton.visible = false;
                return;
            }
            else {
                speedLeftButton.visible = true;
                ++speed;
            }
        }
    }

    Image {
        id: backgroundImage
        source: "qrc:/resources/images/background_menu.jpg"
    }

    Rectangle {
        color: Qt.rgba(15/255, 15/255, 15/255, 0.25)
        anchors.fill: parent
    }

    Item {
        id: demoСhanges

        Image {
            id: demoСhangesImage
            x: 458
            y: 48
            source: "qrc:/resources/images/demo.png"
        }

        Rectangle {
            width: size; height: width
            radius: size / 2
            color: colorСircles
            anchors.horizontalCenter: demoСhangesImage.horizontalCenter
            anchors.verticalCenter: demoСhangesImage.verticalCenter
        }
    }

    Item {
        id: changingSizeCircles

        Image {
            id: windowSizeImage
            x: 354
            y: 489
            source: "qrc:/resources/images/window_size.png"
        }

        Image {
            id: changingSizeCirclesLeftButton
            source: mouseAreaLeftSizeCircles.pressed ? "qrc:/resources/images/size_left_pressed.png" : "qrc:/resources/images/size_left.png"
            x: 240
            y: 531

            MouseArea {
                id: mouseAreaLeftSizeCircles
                anchors.fill: changingSizeCirclesLeftButton
                onClicked: changingSize(0)
            }
        }

        Text {
            anchors.horizontalCenter: windowSizeImage.horizontalCenter
            y: 575
            font.pixelSize: 30
            font.family: "OCR A Extended"
            font.letterSpacing: -3
            color: "white"
            text: size
        }

        Image {
            id: changingSizeCirclesRightButton
            source: mouseAreaRightSizeCircles.pressed ? "qrc:/resources/images/size_right_pressed.png" : "qrc:/resources/images/size_right.png"
            x: 697
            y: 531

            MouseArea {
                id: mouseAreaRightSizeCircles
                anchors.fill: changingSizeCirclesRightButton
                onClicked: changingSize(1)
            }
        }
    }

    Item {
        id: changingTimerInterval

        Image {
            id: intervalWindowImage
            x: 475
            y: 720
            source: "qrc:/resources/images/interval_window.png"
        }

        Image {
            id: intervalLeftButton
            source: mouseAreaIntervalLeftButton.pressed ? "qrc:/resources/images/interval_left_pressed.png" : "qrc:/resources/images/interval_left.png"
            x: 361
            y: 762

            MouseArea {
                id: mouseAreaIntervalLeftButton
                anchors.fill: intervalLeftButton
                onClicked: changingInterval(0)
            }
        }

        Text {
            anchors.horizontalCenter: intervalWindowImage.horizontalCenter
            y: 806
            font.pixelSize: 30
            font.family: "OCR A Extended"
            font.letterSpacing: -3
            color: "white"
            text: timerInterval
        }

        Image {
            id: intervalRightButton
            source: mouseAreaIntervalRightButton.pressed ? "qrc:/resources/images/interval_right_pressed.png" : "qrc:/resources/images/interval_right.png"
            x: 818
            y: 762

            MouseArea {
                id: mouseAreaIntervalRightButton
                anchors.fill: intervalRightButton
                onClicked: changingInterval(1)
            }
        }
    }

    Item {
        id: changingSpeedWindow

        Image {
            id: speedWindowImage
            x: 1142
            y: 720
            source: "qrc:/resources/images/speed_window.png"
        }

        Image {
            id: speedLeftButton
            source: mouseAreaSpeedLeftButton.pressed ? "qrc:/resources/images/speed_left_pressed.png" : "qrc:/resources/images/speed_left.png"
            x: 1028
            y: 762

            MouseArea {
                id: mouseAreaSpeedLeftButton
                anchors.fill: speedLeftButton
                onClicked: changingSpeed(0)
            }
        }

        Text {
            anchors.horizontalCenter: speedWindowImage.horizontalCenter
            y: 806
            font.pixelSize: 30
            font.family: "OCR A Extended"
            font.letterSpacing: -3
            color: "white"
            text: speed
        }

        Image {
            id: speedRightButton
            source: mouseAreaSpeedRightButton.pressed ? "qrc:/resources/images/speed_right_pressed.png" : "qrc:/resources/images/speed_right.png"
            x: 1485
            y: 762

            MouseArea {
                id: mouseAreaSpeedRightButton
                anchors.fill: speedRightButton
                onClicked: changingSpeed(1)
            }
        }
    }

    Item {
        id: changingMaxCount

        Image {
            id: windowMaxImage
            x: 1264
            y: 489
            source: "qrc:/resources/images/max_window.png"
        }

        Image {
            id: windowMaxLeftButton
            source: mouseAreaMaxLeftButton.pressed ? "qrc:/resources/images/max_left_pressed.png" : "qrc:/resources/images/max_left.png"
            x: 1150
            y: 531

            MouseArea {
                id: mouseAreaMaxLeftButton
                anchors.fill: windowMaxLeftButton
                onClicked: changingMax(0)
            }
        }

        Text {
            anchors.horizontalCenter: windowMaxImage.horizontalCenter
            y: 575
            font.pixelSize: 30
            font.family: "OCR A Extended"
            font.letterSpacing: -3
            color: "white"
            text: maxCount
        }

        Image {
            id: windowMaxRightButton
            source: mouseAreaMaxRightButton.pressed ? "qrc:/resources/images/max_right_pressed.png" : "qrc:/resources/images/max_right.png"
            x: 1607
            y: 531

            MouseArea {
                id: mouseAreaMaxRightButton
                anchors.fill: windowMaxRightButton
                onClicked: changingMax(1)
            }
        }
    }

//    Item {
//        id: changingCrosshair

//        Text {
//            y: 600
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: "Прицел:"
//        }

//        Button {
//            x: 300
//            y: 600
//            text: "<"
//            //onClicked:
//        }

//        Text {
//            x: 450
//            y: 600
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: "В разраб..."
//        }

//        Button {
//            x: 600
//            y: 600
//            text: ">"
//            //onClicked:
//        }
//    }

//    Item {
//        id: changingBackgroundID

//        Text {
//            y: 750
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: "Фон:"
//        }

//        Button {
//            x: 300
//            y: 750
//            text: "<"
//            onClicked: changingBackground(0)
//        }

//        Text {
//            x: 450
//            y: 750
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: backgroundID
//        }

//        Button {
//            x: 600
//            y: 750
//            text: ">"
//            onClicked: changingBackground(1)
//        }
//    }

//    Item {
//        id: changingSoundShots

//        Text {
//            y: 900
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: "Оружие:"
//        }

//        Button {
//            x: 300
//            y: 900
//            text: "<"
//            //onClicked:
//        }

//        Text {
//            x: 450
//            y: 900
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: "В разраб..."
//        }

//        Button {
//            x: 600
//            y: 900
//            text: ">"
//            //onClicked:
//        }
//    }

//    Item {
//        id: changingVolumeLevel

//        Text {
//            y: 1000
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: "Громкость:"
//        }

//        Button {
//            x: 300
//            y: 1000
//            text: "<"
//            //onClicked:
//        }

//        Text {
//            x: 450
//            y: 1000
//            font.pixelSize: 30
//            font.family: "OCR A Extended"
//            font.letterSpacing: -3
//            color: "white"
//            text: "В разраб..."
//        }

//        Button {
//            x: 600
//            y: 1000
//            text: ">"
//            //onClicked:
//        }
//    }

    Image {
        id: returnSettings
        source: mouseAreaReturnSettings.pressed ? "qrc:/resources/images/return_pressed.png" : "qrc:/resources/images/return.png"
        x: 908
        y: 600

        MouseArea {
            id: mouseAreaReturnSettings
            anchors.fill: returnSettings
            onClicked: {
                size = 100
                timerInterval = 500
                speed = 1
                maxCount = 10
                windowMaxRightButton.visible = true
                windowMaxLeftButton.visible = true
                speedRightButton.visible = true
                speedLeftButton.visible = true
                changingSizeCirclesRightButton.visible = true
                changingSizeCirclesLeftButton.visible = true
                intervalRightButton.visible = true
                intervalLeftButton.visible = true
            }
        }
    }

    Image {
        id: backButton
        source: mouseAreaBackButton.pressed ? "qrc:/resources/images/back_button_pressed.png" : "qrc:/resources/images/back_button.png"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 930

        MouseArea {
            id: mouseAreaBackButton
            anchors.fill: backButton
            onClicked: settingsWindow.close()
        }
    }
}
