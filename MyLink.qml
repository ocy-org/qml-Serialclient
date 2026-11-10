import QtQuick 2.9
import QtQuick.Controls 2.12

Button {

    property string iconSource: ""
    property string buttonText: ""

    id: self
    width: 200
    height: 30
    text: buttonText
    background: Rectangle {
        color: "transparent"
        border.color: "transparent"
    }
    // icon.source: iconSource
    // icon.width: 25
    // icon.height:25


    contentItem: Item{
        // anchors.fill: parent
        // background:
        width: parent.width
        height: parent.height
        Image{
            source: iconSource
            width: 20
            height: 20
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 30
            width: parent.width-20
            height: parent.height
            text: buttonText
            verticalAlignment: Text.AlignVCenter
            // horizontalAlignment: Text.AlignHCenter
            color: "white"
            font.underline: self.hovered
            font.pixelSize: 15
        }
    }

    // contentItem: Text {
    //     text: parent.text
    //     verticalAlignment: Text.AlignVCenter
    //     horizontalAlignment: Text.AlignHCenter
    //     color: "#0099FF"
    //     font.underline: parent.hovered
    // }
}
