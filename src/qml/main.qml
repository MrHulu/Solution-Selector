import QtQuick 2.15
import QtQuick.Controls 2.15 as C2
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15
import QtQuick.Controls 1.4 as C14
import QtQuick.Controls.Styles 1.4 as CS
import Qt.labs.calendar 1.0
import "utils" as U

C2.ApplicationWindow {
    id: win
    width: 1024
    height: 720
    visible: true
    title: qsTr("方案选择器")
    background: Rectangle {
        color: "#FF000000"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#66F0F3F7" }
            GradientStop { position: 1.0; color: "#FFF2F6FA" }
        }
    }
    function reset() {
        timeModel.resetModel()
        timeView.currentIndex = -1
    }
    U.Pane {
        id: calenderPane
        anchors.top: win.contentItem.top
        anchors.left: win.contentItem.left
        anchors.right: win.contentItem.right
        anchors.topMargin: 32
        anchors.leftMargin: 32
        anchors.rightMargin: 32
        height: calendar.height
        C14.Calendar {
            id: calendar
            anchors.centerIn: parent
            anchors.margins: 10
            width: parent.width
            frameVisible: false
            navigationBarVisible: true
            weekNumbersVisible: false
            minimumDate: new Date(2022, 8, 1)
            maximumDate: new Date(2023, 0, 1)
            onClicked: {
                if(date !== selectedDate) {
                    reset()
                }
            }
        }
    }

    U.Pane {
        anchors.top: calenderPane.bottom
        anchors.left: win.contentItem.left
        anchors.right: win.contentItem.right
        anchors.bottom: win.contentItem.bottom
        anchors.topMargin: 32
        anchors.bottomMargin: 32
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        ListModel {
            id: timeModel
            Component.onCompleted: resetModel()
            function resetModel() {
                timeModel.clear()
                append({"text": "上午", "index": 0, "value": 1})
                append({"text": "下午", "index": 1, "value": 2})
                append({"text": "晚上", "index": 2, "value": 3})
            }
        }
        ListModel {
            id: eventModel
            Component.onCompleted: resetModel()
            function resetModel() {
                eventModel.clear()
                append({"text": "去海边", "index": 0 })
                append({"text": "骑车散步", "index": 1})
                append({"text": "去博物馆(有可能因为疫情不开放)", "index": 2, })
                append({"text": "在家", "index": 3, })
                append({"text": "去电影院", "index": 4, })
                append({"text": "去广州", "index": 5, })
                append({"text": "吃79号渔船", "index": 6, })
                append({"text": "吃农场西餐", "index": 7, })
                append({"text": "吃板一寿司", "index": 8, })
                append({"text": "住酒店", "index": 9, })
                append({"text": "去爬山", "index": 10, })
                append({"text": "去玩PS游戏(一方天地)", "index": 11, })
            }
        }
        RowLayout {
            anchors.fill: parent
            anchors.bottomMargin: 60
            spacing: 12
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                radius: 12
                color: "lightgrey"
                Text {
                    text: "选择时间段"
                    font.weight: Font.Bold
                    font.pixelSize: 16
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 10
                    color: "white"
                }
                ListView {
                    id: timeView
                    anchors.fill: parent
                    anchors.topMargin: 32
                    spacing: 3
                    contentWidth: timeView.width
                    model: timeModel
                    snapMode: ListView.SnapToItem
                    currentIndex: -1
                    onCurrentIndexChanged: { eventModel.resetModel(); eventView.currentIndex = -1 }
                    add: Transition {
                             NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 600 }
                             NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 600 }
                             NumberAnimation { property: "y"; from: 0; duration: 600; easing.type: Easing.OutBounce }
                     }
                    addDisplaced: Transition {
                        NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 600 }
                        NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 600 }
                        NumberAnimation { property: "y"; from: 0; duration: 600; easing.type: Easing.OutBounce }
                    }
                    delegate: DelegateItem {
                        hoverEnabled: true
                        width: ListView.view.contentWidth
                        backgroundColor: ListView.isCurrentItem ? "coral" : hovered ? "beige"  : "snow"
                        textColor: ListView.isCurrentItem ? "snow"  : "dimgray"
                        text: model.text
                        onClicked: { timeView.currentIndex = model.index }
                    }
                }
            }
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                radius: 12
                color: "beige"
                MouseArea {
                    z: 1
                    anchors.fill: parent
                    enabled: !eventView.enabled
                    hoverEnabled: true
                    onContainsMouseChanged: {
                        if(containsMouse) toolTip.open()
                        else toolTip.close()
                    }
                    C2.ToolTip {
                        id: toolTip;
                        text: "请先选择时间段才能选择娱乐方式!"; y: parent.height / 2
                        font.pixelSize: 20
                    }
                }
                Text {
                    text: "选择娱乐方式"
                    font.pixelSize: 16
                    font.weight: Font.Bold
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 10
                    color: "dimgray"
                    opacity: eventView.enabled ? 1 : 0.6
                }
//                    C2.ScrollBar {
//                        z: 1
//                        active: hovered || pressed
//                        orientation: Qt.Vertical
//                        size: parent.height / eventView.contentHeight
//                        anchors.top: parent.top
//                        anchors.right: parent.right
//                        anchors.bottom: parent.bottom
//                        policy: C2.ScrollBar.AlwaysOn
//                        contentItem: Rectangle {
//                           implicitWidth: 6
//                           implicitHeight: 30
//                           radius: width / 2
//                           color: parent.pressed ? "#81e889" : "#c2f4c6"
//                        }
//                    }
                ListView {
                    id: eventView
                    opacity: enabled ? 1 : 0.6
                    enabled: timeView.currentIndex != -1
                    property bool isSelected: Qt.binding(function(){
                        for(let i=0; i<eventView.count; ++i) {
                            if(eventView.itemAtIndex(i).isSelected)
                                return true
                        }
                        return false})
                    anchors.fill: parent
                    currentIndex: -1
                    anchors.topMargin: 32
                    spacing: 3
                    contentWidth: eventView.width
                    snapMode: ListView.SnapToItem
                    model: eventModel
                    U.ScrollBar.vertical: U.ScrollBar {  policy: U.ScrollBar.AlwaysOn }
                    add: Transition {
                             NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                             NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                             NumberAnimation { property: "y"; from: 0; duration: 400; easing.type: Easing.OutBounce }
                     }
                    addDisplaced: Transition {
                        NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                        NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                        NumberAnimation { property: "y"; from: 0; duration: 400; easing.type: Easing.OutBounce }
                    }
                    delegate: DelegateItem {
                        hoverEnabled: true
                        width: ListView.view.contentWidth
                        backgroundColor: isSelected ? "coral" : hovered ? "dimgray"  : "snow"
                        textColor: isSelected ? "snow" : hovered ? "while" : "dimgray"
                        text: model.text
                        property bool isSelected: false
                        onClicked: {
                            isSelected = !isSelected
                            eventView.currentIndex = model.index
                        }
                    }
                }
            }// Rectangle

        }// RowLayout

        C2.Button {
            id: button
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            text: "我决定这么选~"
            C2.ToolTip {
                id: buttonToolTip
                text: "你还没确定呢！！";
                font.pixelSize: 16
            }
            background: Rectangle {
                radius: 8
                color: button.hovered ? "lightskyblue" : "lightblue"
            }
            onClicked: {
                for(let k=0; k<eventView.count; ++k) {
                    let item = eventView.itemAtIndex(k)
                    console.log(k, item.isSelected, item.text)
                }
                console.log("eventView.isSelected",eventView.isSelected)
                if(!eventView.isSelected) {
                    buttonToolTip.open()
                    buttonToolTip.timeout = 1000
                    return
                }
                let dateText = calendar.selectedDate.toLocaleDateString()
                let timeText = timeView.currentItem.text
                let eventTextList = []
                for(let i=0; i<eventView.count; ++i) {
                    let item = eventView.itemAtIndex(i)
                    if(item.isSelected)
                        eventTextList.push(item.text)
                }
                popup.text = dateText + " " + timeText + ": " +eventTextList.join(",")
                popup.open()
            }
            onHoveredChanged: { scale = 1.0 }
            Timer {
                id: timer
                running: !button.hovered
                repeat: true
                interval: 1000
                onTriggered: {
                    if(button.scale == 1.0) button.scale = 1.3
                    else button.scale = 1.0
                }
            }
            Behavior on scale { NumberAnimation { property: "scale"; duration: 1000 } }
        }

    }// pane

    U.Popup { id: popup; onClosed: { reset(); } }

}
