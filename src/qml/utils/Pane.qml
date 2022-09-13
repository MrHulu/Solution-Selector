import QtQuick 2.12
import QtQuick.Controls 2.15 as C
import QtGraphicalEffects 1.0

C.Pane {
    id: control
    property bool dropShadowVisible: true

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 12


    background: Loader {
        sourceComponent: lightBackground
    }
    Component {
        id: lightBackground
        Item {
            DropShadow {
                visible: dropShadowVisible
                anchors.fill: parent
                source: whiteBlank
                verticalOffset: 0
                horizontalOffset: 8
                radius: 28
                samples: 20
                color: "#24565759"
            }
            Rectangle {
                id: whiteBlank
                anchors.fill: parent
                color: dropShadowVisible ? "#D1FFFFFF" : "#FFFEFEFE"
                radius: 8
            }
            opacity: control.enabled ? 1.0 : 0.4
        }
    }
}
