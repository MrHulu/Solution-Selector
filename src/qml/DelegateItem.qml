import QtQuick 2.0
import QtQuick.Controls 2.15

Control {
    id: control
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitContentHeight + topPadding + bottomPadding
    property color backgroundColor: "white"
    property color textColor: "dimgray"
    property string text
    signal clicked()
    padding: 12

    contentItem: Item{
        implicitWidth: text.width
        implicitHeight: text.height
        MouseArea {
            anchors.fill: parent
            onClicked: control.clicked()
        }
        Text {
            id: text
            color: textColor
            font.pixelSize: 18
            text: control.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: backgroundColor
        radius: 8
    }
}
