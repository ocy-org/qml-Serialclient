import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.1

Window {
    id:mainWindow
    width: 1000
    height: 660
    minimumWidth: 1000
    maximumWidth: 1000
    minimumHeight: 660
    maximumHeight: 660
    visible: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    title: qsTr("客户端")
    flags: Qt.Window | Qt.FramelessWindowHint ;



    // 应用全局 QSS 样式
    Component.onCompleted: {
        var styleComponent = Qt.createComponent("qrc:/mac.qss");
        if (styleComponent.status === Component.Ready) {
            Application.setStyleSheet(styleComponent.createObject());
        }
        //使用前要验证密码--add by ocy 20240509----调试时可以去掉
        pwdcheck.visible = true
    }


    Rectangle{
        id : rootWindowTitleBar
        width: mainWindow.width
        height: 30
//        color:"#2e8ded"
        TitleBar{
            id:titleBar
            z:rootWindowTitleBar.z+1;
            anchors.fill: parent

            // anchors{left: parent.left;right: parent.right; top: parent.top;}
        }
    }
    Rectangle{
        id:container
        width: mainWindow.width
        height: mainWindow.height-30
        y: 30

        Rectangle{
            id:center
            width: container.width
            height: container.height

            // MyTabView{
            //     width: parent.width-20
            //     height: parent.height-20
            //     anchors.centerIn: parent
            //     // border.color: "red"
            //     // border.width: 1
            //     // anchors.leftMargin:10
            //     // anchors.topMargin: 10
            // }
            CustomTabview{
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                // border.color: "red"
                // border.width: 1
                // anchors.leftMargin:10
                // anchors.topMargin: 10
            }
        }

//        Rectangle{
//            id:footer
//            width: container.width
//            height: 70
//            anchors.bottom: container.bottom

//            Button{
//                width: 80
//                height: 30
//                anchors.left: parent.left
//                anchors.bottom: parent.bottom
//                anchors.leftMargin: 200
//                anchors.bottomMargin: 20
//                text:"注销"
//            }

//            Button{
//                width: 80
//                height: 30
//                anchors.right:  parent.right
//                anchors.bottom: parent.bottom
//                anchors.rightMargin: 200
//                anchors.bottomMargin: 20
//                text:"关机"
//            }
//        }


    }
    //密码验证窗口
    PwdCheck{
        id:pwdcheck
        visible: false
    }
}
