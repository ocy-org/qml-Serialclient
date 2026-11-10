import QtQuick 2.2
import QtQuick.Controls 2.12
import QtQuick.Controls 1.1 as Control11
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.3

import SerialServiceObj 1.0
import ComputerServiceObj 1.0
Rectangle {
    ComputerService{
        id:computerService
    }
    EditPassWord{
        id:edit
        visible: false
    }
    //密码验证窗口
    PwdCheck{
        id:pwdcheck
        visible: false
    }
    //主窗口加载完成后执行的动作
    Component.onCompleted: {
        //tabBar.color= "white";
        //registerImg.source="qrc:/img/success.png";
        // var regstatus = computerService.getRegisterStatus();
        // console.log("regstatus",regstatus);
        // if (regstatus==="YES") {
        //     reg_status.color= "white";
        //     reg_status.text="已完成注册";
        //     registerImg.source="qrc:/img/success.png";
        // }
    }

    Rectangle{
        id:tabBar
        width: 100
        height: parent.height
        anchors.left: parent.left
        color: "#02a7f0"
        Rectangle{
            width: 90
            height: parent.height-150

            anchors.centerIn: parent
            color: "transparent"
            Grid{
                id:tabGrid
                width: parent.width
                height: parent.height
                rows:6
                columns:1
                rowSpacing: 0
                anchors.centerIn: parent

                Row{
                    width: parent.width
                    height: parent.height/5

                    Rectangle{
                        id:index_bg
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered:{
                                if(tabView.currentIndex != 0){
                                    parent.color = "#3dc3f0" // 鼠标悬停时的颜色
                                }
                            }
                            onExited:{
                                if(tabView.currentIndex != 0){
                                    parent.color = "transparent" // 鼠标离开时的颜色
                                }
                            }
                            onClicked: {
                                tabView.currentIndex = 0;
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/1.5
                            color: "transparent"
                            Image {
                                width:40
                                height:40
                                source: "qrc:/img/index.png"
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/3
                            color: "transparent"
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            Text{
                                text: "首页"
                                color: "white"
                                anchors.centerIn: parent
                                font.pixelSize: 16
                                font.weight: Font.DemiBold
                            }
                        }
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height/5

                    Rectangle{
                        id:register_bg
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered:{
                                if(tabView.currentIndex != 1){
                                    parent.color = "#3dc3f0" // 鼠标悬停时的颜色
                                }
                            }
                            onExited:{
                                if(tabView.currentIndex != 1){
                                    parent.color = "transparent" // 鼠标离开时的颜色
                                }
                            }
                            onClicked: {
                                tabView.currentIndex = 1;
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/1.5
                            color: "transparent"

                            Image {
                                width:40
                                height:40
                                source: "qrc:/img/index_register.png"
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/3
                            color: "transparent"
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            Text{
                                text: "注册"
                                color: "white"
                                anchors.centerIn: parent
                                font.pixelSize: 16
                                font.weight: Font.DemiBold
                            }
                        }
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height/5

                    Rectangle{
                        id:author_bg
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered:{
                                if(tabView.currentIndex != 2){
                                    parent.color = "#3dc3f0" // 鼠标悬停时的颜色
                                }
                            }
                            onExited:{
                                if(tabView.currentIndex != 2){
                                    parent.color = "transparent" // 鼠标离开时的颜色
                                }
                            }
                            onClicked: {
                                tabView.currentIndex = 2;
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/1.5
                            color: "transparent"

                            Image {
                                width:40
                                height:40
                                source: "qrc:/img/author.png"
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/3
                            color: "transparent"
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            Text{
                                text: "授权"
                                color: "white"
                                anchors.centerIn: parent
                                font.pixelSize: 16
                                font.weight: Font.DemiBold
                            }
                        }
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height/5

                    Rectangle{
                        id:cnf_bg
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered:{
                                if(tabView.currentIndex != 3){
                                    parent.color = "#3dc3f0" // 鼠标悬停时的颜色
                                }
                            }
                            onExited:{
                                if(tabView.currentIndex != 3){
                                    parent.color = "transparent" // 鼠标离开时的颜色
                                }
                            }
                            onClicked: {
                                tabView.currentIndex = 3;
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/1.5
                            color: "transparent"

                            Image {
                                width:40
                                height:40
                                source: "qrc:/img/config.png"
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/3
                            color: "transparent"
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            Text{
                                text: "系统配置"
                                color: "white"
                                anchors.centerIn: parent
                                font.pixelSize: 16
                                font.weight: Font.DemiBold
                            }
                        }
                    }
                }

                Row{
                    width: parent.width
                    height: parent.height/5

                    Rectangle{
                        id:net_bg
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered:{
                                if(tabView.currentIndex != 4){
                                    parent.color = "#3dc3f0" // 鼠标悬停时的颜色
                                }
                            }
                            onExited:{
                                if(tabView.currentIndex != 4){
                                    parent.color = "transparent" // 鼠标离开时的颜色
                                }
                            }
                            onClicked: {
                                tabView.currentIndex = 4;
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/1.5
                            color: "transparent"

                            Image {
                                width:40
                                height:40
                                source: "qrc:/img/detective.png"
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height: parent.height/3
                            color: "transparent"
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            Text{
                                text: "终端检测"
                                color: "white"
                                anchors.centerIn: parent
                                font.pixelSize: 16
                                font.weight: Font.DemiBold
                            }
                        }
                    }
                }


            }
        }
    }

    Control11.TabView {
        id:tabView

        width: parent.width-100
        height: parent.height

        anchors.left: tabBar.right
        tabsVisible: false

        onCurrentIndexChanged: {
            if(tabView.currentIndex == 0){
                // registerImg.source="qrc:/img/success.png";
                reg_status.color= "white";
                index_bg.color = "#3dc3f0";
                register_bg.color = "transparent";
                author_bg.color = "transparent";
                cnf_bg.color = "transparent";
                net_bg.color = "transparent";
            }else if(tabView.currentIndex == 1){
                index_bg.color = "transparent";
                register_bg.color = "#3dc3f0";
                author_bg.color = "transparent";
                cnf_bg.color = "transparent";
                net_bg.color = "transparent";
            }else if(tabView.currentIndex == 2){
                index_bg.color = "transparent";
                register_bg.color = "transparent";
                author_bg.color = "#3dc3f0";
                cnf_bg.color = "transparent";
                net_bg.color = "transparent";
            }else if(tabView.currentIndex == 3){
                index_bg.color = "transparent";
                register_bg.color = "transparent";
                author_bg.color = "transparent";
                cnf_bg.color = "#3dc3f0";
                net_bg.color = "transparent";
            }else if(tabView.currentIndex == 4){
                index_bg.color = "transparent";
                register_bg.color = "transparent";
                author_bg.color = "transparent";
                cnf_bg.color = "transparent";
                net_bg.color = "#3dc3f0";
            }
        }

        Rectangle{
            anchors.fill: parent
            color: "#f2f2f2"
        }
        Control11.Tab {
            id:indexTab
            width: parent.width
            height: parent.height

            Grid{
                width: parent.width -50
                height: parent.height -50
                rows:5
                columns:1
                rowSpacing: 15
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 20

                Row{
                    width: parent.width
                    height:30
//                    height: parent.height/5
                    Rectangle{
                        color: "white"
                        width: parent.width/1.5
                        height: parent.height

                        Image {
                            id:img
                            width:20
                            height:20
                            source: "qrc:/img/information.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 5
                        }
                        Text {
                            text: qsTr("公告：")
                            font.pixelSize: 16
                            font.weight: Font.DemiBold
                            color: "gray"
                            anchors.left: img.right
                            anchors.leftMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 3
                        }
                    }
                }

                Row{
                    width: parent.width
                    height:1
                    Rectangle{
                        width: parent.width-50
                        height:1
                        color: "gray"
                    }
                }

                Row{
                    width: parent.width
                    height:150
                    Rectangle{
                        width: parent.width-50
                        height:parent.height
                        color: "white"

                        Rectangle{
                            width: parent.width-30
                            height:parent.height-30
//                            color: "#3dc3f0"

                            anchors.centerIn: parent
                            // 背景图片
                            Image {
                                anchors.fill: parent
                                source: "qrc:/img/index_back.png" // 替换为您的图片路径
                                fillMode: Image.PreserveAspectCrop // 保持图片比例，裁剪多余部分
                            }

                            Rectangle{
                                id:linkContainer
                                width: 100
                                height:parent.height
                                color: "transparent"
                                Image {
                                    id: linkImg
                                    source: "qrc:/img/link_success.png"// This is available in all editors.
                                    width: 60
                                    height: 60
                                    anchors.centerIn: parent
                                }
                            }
                            Rectangle{
                                width:parent.width/2
                                height:parent.height
                                color: "transparent"
                                anchors.left: linkContainer.right
                                Rectangle{
                                    width:parent.width
                                    height:parent.height/2
                                    anchors.top: parent.top
                                    color: "transparent"
                                    Text {
                                        text: qsTr("信息接入和一云管理平台，统一升级维护。")
                                        font.pixelSize: 16
                                        font.weight: Font.DemiBold
                                        color: "white"
                                        anchors.bottom: parent.bottom
                                    }
                                }
                                Rectangle{
                                    color: "transparent"
                                    width:parent.width
                                    height:parent.height/2
                                    anchors.bottom: parent.bottom

                                    Rectangle{
                                        width:parent.width/2
                                        height:parent.height
                                        color: "transparent"
                                        anchors.left: parent.left
                                        Rectangle{
                                            color: "transparent"
                                            width:parent.width
                                            height:parent.height/2
                                            anchors.top: parent.top
                                            Image {
                                                id: registerImg
                                                width: 20
                                                height: 20
                                                anchors.top: parent.top
                                                anchors.topMargin: 5
                                                source: "qrc:/img/waring.png"
                                            }
                                            MyLink{
                                                buttonText: "信息注册"
                                                onClicked: {
                                                    tabView.currentIndex = 1;
                                                }
                                            }
                                        }
                                        Rectangle{
                                            color: "transparent"
                                            width:parent.width
                                            height:parent.height/2
                                            anchors.bottom: parent.bottom
                                            Text {
                                                id:reg_status
                                                text: qsTr("提醒：未完成信息注册")
                                                color: "yellow"
                                            }
                                        }

                                    }
                                    Rectangle{
                                        width:parent.width/2
                                        height:parent.height
                                        color: "transparent"
                                        anchors.right: parent.right

                                        Rectangle{
                                            color: "transparent"
                                            width:parent.width
                                            height:parent.height/2
                                            anchors.top: parent.top
                                            Image {
                                                id: authorImg
                                                width: 20
                                                height: 20
                                                anchors.top: parent.top
                                                anchors.topMargin: 5
                                                source: "qrc:/img/waring.png"
                                            }
                                            MyLink{
                                                buttonText: "授权许可"
                                                onClicked: {
                                                    tabView.currentIndex = 2;
                                                }
                                            }
                                        }
                                        Rectangle{
                                            color: "transparent"
                                            width:parent.width
                                            height:parent.height/2
                                            anchors.bottom: parent.bottom
                                            Text {
                                                text: qsTr("提醒：未完成授权验证")
                                                color: "white"
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    }
                }

                Row{
                    width: parent.width
                    height:150

                    Rectangle{
                        width: parent.width-50
                        height:parent.height
                        color: "transparent"
                        Rectangle{
                            width: parent.width
                            height:20
                            color: "#f2f2f2"
                            Text {
                                text: qsTr("实用工具")
                                font.pixelSize: 16
                                color: "black"
                                font.weight: Font.DemiBold
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height:parent.height-50
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.bottomMargin: 20
                            color: "#f2f2f2"
                            GridLayout {
                                columns: 3 // 设置为三列
                                rows: 1    // 设置为三行
                                rowSpacing: 10 // 设置行之间的空隙为10像素
                                columnSpacing: 20 // 设置列之间的空隙为20像素
                                anchors.fill: parent

                                Rectangle {
                                    width: (parent.width-30)/3
                                    height: 80
                                    color: "white"
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            console.log(111)
                                            computerService.openHeYiYun()
                                        }
                                    }
                                    Rectangle{
                                        width:70
                                        height: parent.height
                                        anchors.left: parent.left
                                        Image {
                                            width:50
                                            height: 50
                                            source: "qrc:/img/heyiyun.png"
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Rectangle{
                                        width:parent.width-70
                                        height: parent.height
                                        anchors.right: parent.right
                                        Text {
                                            font.pixelSize: 18
                                            anchors.top: parent.top
                                            anchors.topMargin: 20
                                            text: qsTr("虚拟机管理工具")
                                        }
                                        Text {
                                            font.pixelSize: 12
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 10
                                            text: qsTr("USB挂载映射、文件互传等功能")
                                        }
                                    }
                                }

                                Rectangle {
                                    width: (parent.width-30)/3
                                    height: 80
                                    color: "white"
                                    MouseArea {
                                        anchors.fill: parent
//                                        hoverEnabled: true
//                                        onEntered: parent.color = "#3dc3f0" // 鼠标悬停时的颜色
//                                        onExited: parent.color = "transparent" // 鼠标离开时的颜色
                                        onClicked: {
                                            computerService.openRemoteFile()
                                        }
                                    }
                                    Rectangle{
                                        width:70
                                        height: parent.height
                                        anchors.left: parent.left
                                        Image {
                                            width:50
                                            height: 50
                                            source: "qrc:/img/fileChange.png"
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Rectangle{
                                        width:parent.width-70
                                        height: parent.height
                                        anchors.right: parent.right
                                        Text {
                                            font.pixelSize: 18
                                            anchors.top: parent.top
                                            anchors.topMargin: 20
                                            text: qsTr("文件互传")
                                        }
                                        Text {
                                            font.pixelSize: 12
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 10
                                            text: qsTr("宿主机与虚拟机之间的文件互传")
                                        }
                                    }
                                }

                                Rectangle {
                                    width: (parent.width-30)/3
                                    height: 80
                                    color: "white"
                                    MouseArea {
                                        anchors.fill: parent
//                                        hoverEnabled: true
//                                        onEntered: parent.color = "#3dc3f0" // 鼠标悬停时的颜色
//                                        onExited: parent.color = "transparent" // 鼠标离开时的颜色
                                        onClicked: {
                                            tabView.currentIndex = 4;
                                        }
                                    }
                                    Rectangle{
                                        width:70
                                        height: parent.height
                                        anchors.left: parent.left
                                        Image {
                                            width:50
                                            height: 50
                                            source: "qrc:/img/tool_detective.png"
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Rectangle{
                                        width:parent.width-70
                                        height: parent.height
                                        anchors.right: parent.right
                                        Text {
                                            font.pixelSize: 18
                                            anchors.top: parent.top
                                            anchors.topMargin: 20
                                            text: qsTr("终端检测")
                                        }
                                        Text {
                                            font.pixelSize: 12
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 10
                                            text: qsTr("串口、并口、网口检测工具")
                                        }
                                    }
                                }


                            }

                        }

                    }


                }

                Row{
                    width: parent.width
                    height:150

                    Rectangle{
                        width: parent.width-50
                        height:parent.height
                        color: "transparent"
                        Rectangle{
                            width: parent.width
                            height:20
                            color: "#f2f2f2"
                            Text {
                                text: qsTr("本地管理")
                                font.pixelSize: 16
                                color: "black"
                                font.weight: Font.DemiBold
                            }
                        }
                        Rectangle{
                            width: parent.width
                            height:parent.height-50
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.bottomMargin: 20
                            color: "#f2f2f2"
                            GridLayout {
                                columns: 3 // 设置为三列
                                rows: 1    // 设置为三行
                                rowSpacing: 10 // 设置行之间的空隙为10像素
                                columnSpacing: 20 // 设置列之间的空隙为20像素
                                anchors.fill: parent

                                Rectangle {
                                    width: (parent.width-30)/3
                                    height: 80
                                    color: "white"
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            tabView.currentIndex = 3;
                                        }
                                    }
                                    Rectangle{
                                        width:70
                                        height: parent.height
                                        anchors.left: parent.left
                                        Image {
                                            width:50
                                            height: 50
                                            source: "qrc:/img/vnc.png"
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Rectangle{
                                        width:parent.width-70
                                        height: parent.height
                                        anchors.right: parent.right
                                        Text {
                                            font.pixelSize: 18
                                            anchors.top: parent.top
                                            anchors.topMargin: 20
                                            text: qsTr("远程协助管理")
                                        }
                                        Text {
                                            font.pixelSize: 12
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 10
                                            text: qsTr("设置云平台远程维护方式")
                                        }
                                    }
                                }

                                Rectangle {
                                    width: (parent.width-30)/3
                                    height: 80
                                    color: "white"
                                    MouseArea {
                                        anchors.fill: parent
//                                        hoverEnabled: true
//                                        onEntered: parent.color = "#3dc3f0" // 鼠标悬停时的颜色
//                                        onExited: parent.color = "transparent" // 鼠标离开时的颜色
                                        onClicked: {
                                            //edit.visible=true  //v1.1版本暂不支持此功能
                                        }
                                    }
                                    Rectangle{
                                        width:70
                                        height: parent.height
                                        anchors.left: parent.left
                                        Image {
                                            width:50
                                            height: 50
                                            source: "qrc:/img/tool_editPassword.png"
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Rectangle{
                                        width:parent.width-70
                                        height: parent.height
                                        anchors.right: parent.right
                                        Text {
                                            font.pixelSize: 18
                                            anchors.top: parent.top
                                            anchors.topMargin: 20
                                            text: qsTr("密码管理")
                                        }
                                        Text {
                                            font.pixelSize: 12
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 10
                                            text: qsTr("修改您的登录密码")
                                        }
                                    }
                                }

                                Rectangle {
                                    width: (parent.width-30)/3
                                    height: 80
                                    color: "white"
                                    MouseArea {
                                        anchors.fill: parent
//                                        hoverEnabled: true
//                                        onEntered: parent.color = "#3dc3f0" // 鼠标悬停时的颜色
//                                        onExited: parent.color = "transparent" // 鼠标离开时的颜色
                                        onClicked: {
                                            tabView.currentIndex = 3;
                                        }
                                    }
                                    Rectangle{
                                        width:70
                                        height: parent.height
                                        anchors.left: parent.left
                                        Image {
                                            width:50
                                            height: 50
                                            source: "qrc:/img/netDevice.png"
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Rectangle{
                                        width:parent.width-70
                                        height: parent.height
                                        anchors.right: parent.right
                                        Text {
                                            font.pixelSize: 18
                                            anchors.top: parent.top
                                            anchors.topMargin: 20
                                            text: qsTr("通讯端口管理")
                                        }
                                        Text {
                                            font.pixelSize: 12
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 10
                                            text: qsTr("配置与和一云的通讯端口")
                                        }
                                    }
                                }


                            }

                        }

                    }


                }

            }
        }

        Control11.Tab {
            id:registerTab
            width: parent.width-20
            height: parent.height

            Rectangle{
                width: parent.width-40
                height: parent.height
                anchors.left: parent.left
                //anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 12
                anchors.right: parent.right
                anchors.rightMargin: 20
                //color: "blue"
                // Rectangle{
                //     width: parent.width
                //     height: 1
                //     color: "gray"
                // }

                RegisterInPage{
                    width: parent.width-40
                    height: parent.height-2
                    anchors.left: parent.left
                    anchors.leftMargin: 220
                    anchors.top: parent.top
                    anchors.topMargin: 2
                }
            }
        }

        Control11.Tab {
            id:authorTab
            width: parent.width
            height: parent.height

            Rectangle{
                width: parent.width
                height: parent.height
                color: "white"
                Image {
                    width: 400
                    height: 300
                    anchors.centerIn: parent
                    source: "qrc:/img/wating.png"
                }
            }
        }

        Control11.Tab {
            id:cnfTab
            width: parent.width/2
            height: parent.height

            Rectangle{
                width: parent.width
                height: parent.height
                color: "transparent"
                VncConfig{
                    mWidth:parent.width
                    mHeight: parent.height
                }
            }
        }

        Control11.Tab {
            id:netTab
            width: parent.width/2
            height: parent.height

            Rectangle{
                width: parent.width
                height: parent.height
                color: "transparent"
                NetDetective{
                    mWidth:parent.width
                    mHeight: parent.height
                }
            }
        }

    }

}

