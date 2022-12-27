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
    property int flag: 0
    property int maxCount: 10
    property string backgroundID: "qrc:/resources/images/background_game2.jpg"
    property string colorСircles: "red"

    function changingInterval(value) {
        if(value === 0) {
            if(timerInterval === 200) {
                timerInterval -= 50;
                intervalLeftButton.visible = false;
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
            }
            else {
                intervalLeftButton.visible = true;
                timerInterval += 50;
            }
        }

        rectSize.visible = false;
        timerForMax.stop();
        flag = 0;
        timerForMax.interval = 100;
        textForMax.visible = false;
        rectMax.visible = false;
        demoСhangesImage.source = "qrc:/resources/images/demo.png";
        textForMax.text = "1";
        timerForInterval.start();
    }

    function showInterval() {
        if (showIntRect1.visible === false) {
            showIntRect1.visible = true;
            return;
        }

        if (showIntRect2.visible === false) {
            showIntRect2.visible = true;
            return;
        }

        if (showIntRect3.visible === false) {
            showIntRect3.visible = true;
            return;
        }

        showIntRect1.visible = false;
        showIntRect2.visible = false;
        showIntRect3.visible = false;
    }

    function changingMax(value) {
        timerForInterval.stop();
        timerForMax.interval = 100;
        showIntRect1.visible = false;
        showIntRect2.visible = false;
        showIntRect3.visible = false;
        rectSize.visible = false;
        rectMax.visible = true;

        if(value === 0) {
            if(maxCount === 2) {
                --maxCount;
                windowMaxLeftButton.visible = false;
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
            }
            else {
                windowMaxLeftButton.visible = true;
                ++maxCount;
            }
        }

        textForMax.visible = true;
        timerForMax.start();
    }

    function showMax() {
        if(flag === 1) {
            flag = 0;
            demoСhangesImage.source = "qrc:/resources/images/demo.png";
            textForMax.text = "1";
            timerForMax.interval = 100;
            return;
        }

        if(+textForMax.text < maxCount) {
            textForMax.text = (+textForMax.text + 1).toString();
        }
        else {
            demoСhangesImage.source = "qrc:/resources/images/demo_red.png";
            timerForMax.interval = 1500;
            flag = 1;
        }

    }

    function changingSize(value) {
        timerForInterval.stop();
        showIntRect1.visible = false;
        showIntRect2.visible = false;
        showIntRect3.visible = false;
        timerForMax.stop();
        flag = 0;
        textForMax.visible = false;
        rectMax.visible = false;
        demoСhangesImage.source = "qrc:/resources/images/demo.png";
        textForMax.text = "1";
        rectSize.visible = true;

        if(value === 0) {
            if(size === 20) {
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

    Image {
        id: demoСhangesImage
        x: 458
        y: 48
        source: "qrc:/resources/images/demo.png"
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

    Image {
        id: returnSettings
        source: mouseAreaReturnSettings.pressed ? "qrc:/resources/images/return_pressed.png" : "qrc:/resources/images/return.png"
        x: 908
        y: 600

        MouseArea {
            id: mouseAreaReturnSettings
            anchors.fill: returnSettings
            onClicked: {
                demoСhangesImage.source = "qrc:/resources/images/demo.png";
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
                timerForInterval.stop()
                timerForMax.stop()
                flag = 0
                timerForMax.interval = 100
                textForMax.visible = false
                textForMax.text = "1"
                rectMax.visible = false
                showIntRect1.visible = false
                showIntRect2.visible = false
                showIntRect3.visible = false
                rectSize.visible = true
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
            onClicked: {
                demoСhangesImage.source = "qrc:/resources/images/demo.png";
                timerForInterval.stop()
                timerForMax.stop()
                flag = 0
                timerForMax.interval = 100
                showIntRect1.visible = false
                showIntRect2.visible = false
                showIntRect3.visible = false
                textForMax.visible = false
                textForMax.text = "1"
                rectMax.visible = false
                rectSize.visible = true
                settingsWindow.close()
            }
        }
    }

    Rectangle {
        id: rectSize
        anchors.horizontalCenter: demoСhangesImage.horizontalCenter
        anchors.verticalCenter: demoСhangesImage.verticalCenter
        visible: true
        width: size; height: width
        radius: size / 2
        color: colorСircles

        MouseArea {
            anchors.fill: rectSize
            onClicked: {
                rectSize.visible = false
                timerForSize.start()
            }
        }

        Timer {
            id: timerForSize
            repeat: false
            interval: 500
            onTriggered: rectSize.visible = true
        }
    }

    Rectangle {
        id: rectMax
        anchors.horizontalCenter: demoСhangesImage.horizontalCenter
        anchors.verticalCenter: demoСhangesImage.verticalCenter
        visible: false
        width: 200; height: width
        radius: width / 2
        color: colorСircles
    }


    Rectangle {
        id: showIntRect1
        anchors.right: showIntRect2.left
        anchors.rightMargin: size / 2
        anchors.verticalCenter: showIntRect2.verticalCenter
        visible: false
        width: size; height: width
        radius: size / 2
        color: colorСircles
    }

    Rectangle {
        id: showIntRect2
        anchors.horizontalCenter: demoСhangesImage.horizontalCenter
        anchors.verticalCenter: demoСhangesImage.verticalCenter
        visible: false
        width: size; height: width
        radius: size / 2
        color: colorСircles
    }

    Rectangle {
        id: showIntRect3
        anchors.left: showIntRect2.right
        anchors.leftMargin: size / 2
        anchors.verticalCenter: showIntRect2.verticalCenter
        visible: false
        width: size; height: width
        radius: size / 2
        color: colorСircles
    }

    Timer {
        id: timerForInterval
        repeat: true
        interval: timerInterval
        onTriggered: showInterval()
    }

    Timer {
        id: timerForMax
        repeat: true
        interval: 100
        onTriggered: showMax()
    }

    Text {
        id: textForMax
        visible: false
        anchors.horizontalCenter: rectSize.horizontalCenter
        anchors.verticalCenter: rectSize.verticalCenter
        font.pixelSize: 75
        font.family: "OCR A Extended"
        font.letterSpacing: -3
        color: "white"
        text: "1"
    }
}
