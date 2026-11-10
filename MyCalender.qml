import QtQml 2.7
import QtQuick 2.7
import QtQuick.Controls 1.6
import QtQuick.Controls.Styles 1.4



Calendar {
    id:calendar
    width: 260
    height: 260
    frameVisible:false
    property color backgroundColor: "#d90b394e"
    property color backgroundBorderColor: "#e6115777"
    property color navigationBarBackgroundColor: "#99b3b3b3"
    property color navigationBarTextColor: "#38d3dc"
    property color dayOfWeekBackgroundColor: "#4d2d2f39"
    property color dayOfWeekTextColor: "#38d3dc"
    property color daySelectedBackgroundColor: "#6638d3dc"
    property color dayInvalidBackgroundColor: "#4d5c5952"
    property color dayTextColor: "#38d3dc"
    property color gridLineColor: "#555"

    signal dateChanged(var dateStr)

    function formatDate(date) {
        var day = date.getDate()
        var month = date.getMonth() + 1
        var year = date.getFullYear()

        var formattedDate = year + "-" + (month < 10 ? "0" + month : month) + "-" + (day < 10 ? "0" + day : day)
        return formattedDate
    }
    onClicked: {
        // var s = date.toLocaleDateString();
        var s = formatDate(date)
        dateChanged(s);
        // messge.mVisible=true
        // messge.mText=s;
        // messge.mTitle="title"
    }


    style: CalendarStyle {
             gridVisible: false
             background: Rectangle{
                 color: calendar.backgroundColor
                 border.color: calendar.backgroundBorderColor
             }
             navigationBar:Rectangle{
                 height: 30
                 // color: calendar.navigationBarColor
                 Label {
                     text: styleData.title
                     anchors.centerIn: parent
                     // color: calendar.titleColor
                     font.pixelSize: 13
                     font.family: "微软雅黑"
                     font.bold: true
                 }
                 Label {
                     anchors.left: parent.left
                     width: 30
                     height: 30
                     text:"<"
                     font.pixelSize: 16
                     horizontalAlignment: Text.AlignHCenter
                     verticalAlignment: Text.AlignVCenter
                     font.family: "微软雅黑"
                     font.bold: true
                     color: "#cecece"
                     MouseArea{
                         anchors.fill: parent
                         onClicked: calendar.showPreviousMonth()
                     }
                 }
                 Label {
                     anchors.right: parent.right
                     width: 30
                     height: 30
                     text:">"
                     font.pixelSize: 16
                     horizontalAlignment: Text.AlignHCenter
                     verticalAlignment: Text.AlignVCenter
                     font.family: "微软雅黑"
                     font.bold: true
                     color: "#cecece"
                     MouseArea{
                         anchors.fill: parent
                         onClicked: calendar.showNextMonth()
                     }
                 }
             }

             dayOfWeekDelegate:Rectangle{
                 color: calendar.dayOfWeekBackgroundColor
                 height: 26
                 Label {
                     text: Qt.locale().dayName(styleData.dayOfWeek)
                     anchors.centerIn: parent
                     color: calendar.dayOfWeekTextColor
                     font.pixelSize: 9
                 }
             }

             dayDelegate: Rectangle {
                 color: styleData.selected ? calendar.daySelectedBackgroundColor :(styleData.visibleMonth && styleData.valid ? "#00000000" : calendar.dayInvalidBackgroundColor)
                 border.width: 0


                 Label {
                     text: styleData.date.getDate()
                     anchors.centerIn: parent
                     color: styleData.visibleMonth && styleData.valid ?  calendar.dayTextColor: "#888"
                 }

                 Rectangle {
                     width: parent.width
                     height: 1
                     color: calendar.gridLineColor
                     anchors.bottom: parent.bottom
                 }

                 Rectangle {
                     width: 1
                     height: parent.height
                     color: calendar.gridLineColor
                     anchors.right: parent.right
                 }
             }
         }

    // MyMessge{
    //     id:messge
    // }
  }
