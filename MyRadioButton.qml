import QtQuick 2.7
import QtQuick.Controls 2.12
RadioButton {
   id: control
   text: qsTr("自定义RadioButton")
   checked: true

   indicator: Rectangle {
       implicitWidth: 56
       implicitHeight: 56
       x: control.leftPadding
       y: parent.height / 2 - height / 2
       radius: 28
       border.color: control.down ? "#17a81a" : "#21be2b"

       Rectangle {
           width: 34
           height: 34
           x: 11  // (56 - 34) / 2
           y: 11
           radius: 17
           color: control.down ? "#17a81a" : "#21be2b"
           visible: control.checked
       }
   }

   contentItem: Text {
       text: control.text
       font: control.font
       opacity: enabled ? 1.0 : 0.3
       color: control.down ? "#17a81a" : "#21be2b"
       verticalAlignment: Text.AlignVCenter
       leftPadding: control.indicator.width + control.spacing
   }
}
