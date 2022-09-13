import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as C
import QtGraphicalEffects 1.0
import Clipboard 1.0

C.Popup {
    id: popup
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitContentHeight + topPadding + bottomPadding

    //parent: ApplicationWindow.window ? ApplicationWindow.window.contentItem : null
    x: parent ? Math.round((parent.width - width) / 2) : 0
    y: parent ? Math.round((parent.height - height) / 2) : 0
    visible: false
    modal: true
    clip: false
    closePolicy: Popup.NoAutoClose

    property string text

    contentItem: Item {
        implicitWidth: layout.width
        implicitHeight: layout.height
        ColumnLayout {
            id: layout
            spacing: 20
            Text {
                text: "你的选择结果为：请点击\"复制\"按钮，然后发给你的猪小屁"
                font.weight: Font.Bold
                font.pixelSize: 16
                horizontalAlignment: Text.AlignLeft
            }
            Rectangle {
                Layout.preferredHeight: text.implicitHeight * 2
                Layout.fillWidth: true
                color: "beige"
                TextInput {
                    id: text
                    width: parent.width
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    text: popup.text
                    font.pixelSize: 14
                    readOnly: true
                }
            }
            Item { Layout.preferredHeight: 1; Layout.preferredWidth: 500 }
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                C.Button {
                    text: "取消"
                    onClicked: { popup.close() }
                }
                C.Button {
                    highlighted: true
                    text: "复制"
                    onClicked:  { clipboard.setText(popup.text); popup.close() }
                }
            }
        }
    }
    Clipboard { id: clipboard }

    background: Item {
        Rectangle {
            id: blank
            anchors.fill: parent
            color: "#FFFFFFFF"
            radius: 4
        }
        DropShadow {
            anchors.fill: parent
            source: blank
            verticalOffset: 8
            horizontalOffset: 8
            radius: 28
            samples: 20
            color: "#24565759"
        }
    }
}
