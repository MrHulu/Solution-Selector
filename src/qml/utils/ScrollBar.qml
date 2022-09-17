import QtQuick 2.12
import QtQuick.Templates 2.12 as T

T.ScrollBar {
    id: control
    property bool lighter: false
    property alias colorRect: colorRect

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    visible: control.policy !== T.ScrollBar.AlwaysOff
    minimumSize: orientation == Qt.Horizontal ? height / width : width / height

    contentItem: Item {
        implicitWidth: 8
        implicitHeight: 8
        opacity: 0.0
        Rectangle {
            id: colorRect
            anchors.fill: parent
            radius: 4

            color: control.pressed ? "#FFDADDE0"
                                           : control.interactive && control.hovered ? "#FFDADDE0"
                                                                                    : "#FFE4E7EB"
            opacity: 1
            Behavior on implicitWidth { NumberAnimation { duration: 100 } }
            Behavior on implicitHeight { NumberAnimation { duration: 100 } }
            Behavior on radius { NumberAnimation { duration: 100 } }
        }
    }

    states: State {
        name: "active"
        when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
    }

    transitions: [
        Transition {
            to: "active"
            NumberAnimation { targets: [control.contentItem]; property: "opacity"; to: 1.0 }
        },
        Transition {
            from: "active"
            SequentialAnimation {
                PropertyAction{ targets: [control.contentItem,]; property: "opacity"; value: 1.0 }
                PauseAnimation { duration: 2450 }
                NumberAnimation { targets: [control.contentItem]; property: "opacity"; to: 0.0 }
            }
        }
    ]
}
