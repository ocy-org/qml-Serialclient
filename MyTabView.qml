import QtQuick 2.2
import QtQuick.Controls 2.12
import QtQuick.Controls 1.1 as Control11
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.3

import SerialServiceObj 1.0
Rectangle {
    // width: 360;
    // height: 240;
    color: "lightgray";
    id: root;


    SerialService{
        id:serialService
    }

    Control11.TabView {
        id:tabView
        anchors.fill: parent


        style: TabViewStyle {
            tabBar: Item {
                Rectangle {
                    color: "white"
                    width: parent.width
                    height: parent.height

                    Row {
                        Repeater {
                            model: tabView.count
                        }
                    }
                }
            }
        }

        Control11.Tab {
            title: "整机配置"
            Rectangle {
                anchors.fill: parent
                Column{
                    id:col
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 30
                    anchors.topMargin: 40
                    width: parent.width-40
                    height: parent.height-40
                    MyLink{
                        id:registButton
                        iconSource: "qrc:/img/register.png"
                        buttonText: "注册到服务器"
                        onClicked: {
                            registe.m_visible=true
                            registe.show()
                        }

                        Register{
                            id:registe
                            m_visible: false
                        }

                    }


                    MyLink{
                        id:socketButton
                        iconSource: "qrc:/img/communicate.png"
                        buttonText: "通讯端口配置"
                        onClicked: {
                            cnt.m_visible=true
                            cnt.show()
                        }


                        CntcnfDialog{
                            id:cnt
                            m_visible: false
                        }
                    }

                    MyLink{
                        id:remoteButton
                        iconSource: "qrc:/img/remote.png"
                        buttonText: "远程监控配置"
                        onClicked: {
                            vnc.m_visible=true
                            vnc.show()
                        }


                        VncCnfDialog{
                            id:vnc
                            m_visible: false
                        }
                    }


                    MyLink{
                        id:virtualButton
                        iconSource: "qrc:/img/virtual.png"
                        buttonText: "打开虚拟机管理器"
                        onClicked: {
                        }
                    }


                    MyLink{
                        id:licsenButton
                        iconSource: "qrc:/img/accredit.png"
                        buttonText: "许可授权"
                        onClicked: {
                            var dia = Qt.createComponent("MyMessge.qml")
                            var dlg = dia.createObject(tabView)
                            dlg.btnType = dlg.mb_OK | dlg.mb_NO | dlg.mb_CANCEL
                            dlg.message = "Are you sure?"
                            dlg.closing.connect(function ret(){
                                if(dlg.retValue === dlg.mb_YES)
                                {
                                    //do something
                                }
                                else if(dlg.retValue === dlg.mb_NO)
                                {
                                    //do something
                                }
                                else if(dlg.retValue === dlg.mb_CANCEL)
                                {
                                    //do something
                                }

                                dlg.destroy()
                            })
                            dlg.show()
                        }
                    }

                    MyLink{
                        id:editButton
                        iconSource: "qrc:/img/editPassWord.png"
                        buttonText: "修改密码"
                        onClicked: {
                            dialog.visible=true
                        }
                    }

                    MyLink{
                        id:safeButton
                        iconSource: "qrc:/img/udisk.png"
                        buttonText: "U盘安全配置"
                        onClicked: {
                            registerDialog.open()
                        }
                    }

                }
            }
        }

        Control11.Tab {
            title: "终端测试"
            Rectangle {
                // color: "lightgreen"
                anchors.fill: parent

                Control11.TabView {
                    id:testView
                    anchors.fill: parent
                    property var serialList: []
                    property var normalList: []
                    onCurrentIndexChanged: {
                        if(currentIndex == 1){
                            testView.rend()

                        }
                    }

                    signal rend()
                    // function renderCombox(){
                    //     serial_Combox.model.append({text:serialList[0]})
                    // }

                    property variant list: []

                    Control11.Tab {
                        id:serial_cnf
                        title: "串并口设备文件设置"

                        signal renderCombox();

                        Rectangle {
                            anchors.fill: parent
                            Grid{
                                id:cnfGrid
                                width: parent.width-50
                                height: parent.height-60
                                rows:6
                                columns:1
                                rowSpacing: 10
                                columnSpacing: 5
                                anchors.centerIn: parent


                                Row{
                                    width: parent.width
                                    height: 30
                                    spacing: 10

                                    Label{
                                        text: qsTr("串口1")
                                        width: 50
                                        height:parent.height
                                        horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    TextField {
                                        id:serial_one
                                        width: 200
                                        height:parent.height
                                        selectByMouse: true
                                    }
                                    Button{
                                        // width: 80
                                        height:parent.height
                                        text: qsTr("选择")
                                        background: Rectangle{
                                            anchors.fill: parent
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        contentItem: Text {
                                               text: parent.text
                                               font: parent.font
                                               opacity: enabled ? 1.0 : 0.3
                                               color: "#169BD5" // 设置文本颜色为黑色
                                               horizontalAlignment: Text.AlignHCenter
                                               verticalAlignment: Text.AlignVCenter
                                               elide: Text.ElideRight
                                        }

                                        onClicked: {
                                        }
                                    }
                                }

                                Row{
                                    width: parent.width
                                    height: 30
                                    spacing: 10

                                    Label{
                                        text: qsTr("串口2")
                                        width: 50
                                        height:parent.height
                                        horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    TextField {
                                        id:serial_two
                                        width: 200
                                        height:parent.height
                                        selectByMouse: true
                                    }
                                    Button{
                                        // width: 80
                                        height:parent.height
                                        text: qsTr("选择")
                                        background: Rectangle{
                                            anchors.fill: parent
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        contentItem: Text {
                                               text: parent.text
                                               font: parent.font
                                               opacity: enabled ? 1.0 : 0.3
                                               color: "#169BD5" // 设置文本颜色为黑色
                                               horizontalAlignment: Text.AlignHCenter
                                               verticalAlignment: Text.AlignVCenter
                                               elide: Text.ElideRight
                                        }

                                        onClicked: {
                                        }
                                    }
                                }
                                Row{
                                    width: parent.width
                                    height: 30
                                    spacing: 10

                                    Label{
                                        text: qsTr("串口3")
                                        width: 50
                                        height:parent.height
                                        horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    TextField {
                                        id:serial_thr
                                        width: 200
                                        height:parent.height
                                        selectByMouse: true
                                    }
                                    Button{
                                        // width: 80
                                        height:parent.height
                                        text: qsTr("选择")
                                        background: Rectangle{
                                            anchors.fill: parent
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        contentItem: Text {
                                               text: parent.text
                                               font: parent.font
                                               opacity: enabled ? 1.0 : 0.3
                                               color: "#169BD5" // 设置文本颜色为黑色
                                               horizontalAlignment: Text.AlignHCenter
                                               verticalAlignment: Text.AlignVCenter
                                               elide: Text.ElideRight
                                        }

                                        onClicked: {
                                        }
                                    }
                                }
                                Row{
                                    width: parent.width
                                    height: 30
                                    spacing: 10

                                    Label{
                                        text: qsTr("串口4")
                                        width: 50
                                        height:parent.height
                                        horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    TextField {
                                        id:serial_four
                                        width: 200
                                        height:parent.height
                                        selectByMouse: true
                                    }
                                    Button{
                                        // width: 80
                                        height:parent.height
                                        text: qsTr("选择")
                                        background: Rectangle{
                                            anchors.fill: parent
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        contentItem: Text {
                                               text: parent.text
                                               font: parent.font
                                               opacity: enabled ? 1.0 : 0.3
                                               color: "#169BD5" // 设置文本颜色为黑色
                                               horizontalAlignment: Text.AlignHCenter
                                               verticalAlignment: Text.AlignVCenter
                                               elide: Text.ElideRight
                                        }

                                        onClicked: {
                                        }
                                    }
                                }
                                Row{
                                    width: parent.width
                                    height: 30
                                    spacing: 10

                                    Label{
                                        text: qsTr("并口")
                                        width: 50
                                        height:parent.height
                                        horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                        verticalAlignment: Text.AlignVCenter

                                    }
                                    TextField {
                                        id:lp
                                        width: 200
                                        height:parent.height
                                        selectByMouse: true
                                    }
                                    Button{
                                        // width: 80
                                        height:parent.height
                                        text: qsTr("选择")
                                        background: Rectangle{
                                            anchors.fill: parent
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        contentItem: Text {
                                               text: parent.text
                                               font: parent.font
                                               opacity: enabled ? 1.0 : 0.3
                                               color: "#169BD5" // 设置文本颜色为黑色
                                               horizontalAlignment: Text.AlignHCenter
                                               verticalAlignment: Text.AlignVCenter
                                               elide: Text.ElideRight
                                        }

                                        onClicked: {
                                            fileDialog.open();
                                        }
                                    }
                                }

                                Row{
                                    width: parent.width
                                    height: 30
                                    spacing: 10
                                    Rectangle{
                                        width: parent.width
                                        height:parent.height

                                        Button{
                                            width: 70
                                            height:parent.height
                                            anchors.left: parent.left
                                            anchors.leftMargin: 160
                                            text: qsTr("确定")
                                            background: Rectangle{
                                                anchors.fill: parent
                                                border.color: "#169bd5"
                                                border.width: 1
                                                radius: 3
                                            }
                                            contentItem: Text {
                                                   text: parent.text
                                                   font: parent.font
                                                   opacity: enabled ? 1.0 : 0.3
                                                   color: "#169BD5" // 设置文本颜色为黑色
                                                   horizontalAlignment: Text.AlignHCenter
                                                   verticalAlignment: Text.AlignVCenter
                                                   elide: Text.ElideRight
                                            }

                                            onClicked: {
                                                testView.serialList[0]=serial_one.text;
                                                testView.serialList[1]=serial_two.text;
                                                testView.serialList[2]=serial_thr.text;
                                                testView.serialList[3]=serial_four.text;
                                                testView.serialList[4]=lp.text;
                                                // serial_cnf.renderCombox();
                                                testView.rend()
                                            }
                                        }

                                        Button{
                                            width: 70
                                            height:parent.height
                                            anchors.right: parent.right
                                            anchors.rightMargin: 160
                                            text: qsTr("取消")
                                            background: Rectangle{
                                                anchors.fill: parent
                                                border.color: "#169bd5"
                                                border.width: 1
                                                radius: 3
                                            }
                                            contentItem: Text {
                                                   text: parent.text
                                                   font: parent.font
                                                   opacity: enabled ? 1.0 : 0.3
                                                   color: "#169BD5" // 设置文本颜色为黑色
                                                   horizontalAlignment: Text.AlignHCenter
                                                   verticalAlignment: Text.AlignVCenter
                                                   elide: Text.ElideRight
                                            }

                                            onClicked: {
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    }

                    Control11.Tab {
                        id:testTab
                        title: "串并口测试"

                        property bool status: false
                        // Connections{
                        //     target:serial_cnf
                        //     onDataChanged: console.log(22)
                        //     // onRenderCombox:{
                        //     //     console.log(66)
                        //     // }
                        // }

                        Rectangle{
                            width: parent.width
                            height: parent.height
                            color: "black"
                            Rectangle{
                                width: parent.width
                                height: (parent.height/4)*3
                                color: "white"
                                anchors.top:parent.top
                                border.color: "#dedede"
                                border.width: 1
                                Grid{
                                    id:serialGrid
                                    width: parent.width-50
                                    height: parent.height-60
                                    rows:5
                                    columns:1
                                    rowSpacing: 10
                                    columnSpacing: 5
                                    anchors.centerIn: parent


                                    Row{
                                        width: parent.width
                                        height: 30
                                        spacing: 10
                                        Label{
                                            text: qsTr("串口测试")
                                            width: 50
                                            height:parent.height
                                            horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                    Row{
                                        width: parent.width
                                        height: 30
                                        spacing: 10

                                        Label{
                                            text: qsTr("串口选择")
                                            width: 50
                                            height:parent.height
                                            horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        Rectangle{
                                            width: parent.width-190
                                            height: 30
                                            ComboBox{
                                                id:serial_Combox
                                                width: parent.width/3
                                                height:parent.height
                                                anchors.left: parent.left
                                                model: ListModel{}

                                                Connections{
                                                    target:testView
                                                    onRend:{
                                                        serial_Combox.model.clear()
                                                        testView.normalList = serialService.getNormalPort();
                                                        for(var i =0;i<testView.normalList.length;i++){
                                                            serial_Combox.model.append({text:testView.normalList[i]})
                                                        }

                                                        if(testView.serialList[0] !== "" && testView.serialList[0] !== undefined){
                                                            serial_Combox.model.append({text:testView.serialList[0]})
                                                        }

                                                        if(testView.serialList[1] !== ""  && testView.serialList[1] !== undefined){
                                                            serial_Combox.model.append({text:testView.serialList[1]})
                                                        }
                                                        if(testView.serialList[2] !== "" && testView.serialList[2] !== undefined){
                                                            serial_Combox.model.append({text:testView.serialList[2]})
                                                        }
                                                        if(testView.serialList[3] !== "" && testView.serialList[3] !== undefined){
                                                            serial_Combox.model.append({text:testView.serialList[3]})
                                                        }
                                                        if(testView.serialList[4] !== "" && testView.serialList[4] !== undefined){
                                                            serial_Combox.model.append({text:testView.serialList[4]})
                                                        }
                                                    }
                                                }

                                            }

                                            Label{
                                                text: qsTr("波特率")
                                                width: parent.width/3
                                                height:30
                                                anchors.left: parent.left
                                                anchors.leftMargin: 150
                                                horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                                verticalAlignment: Text.AlignVCenter

                                            }

                                            ComboBox{
                                                id:rate
                                                width: parent.width/3
                                                height:parent.height
                                                anchors.right: parent.right
                                                // 初始时不包含任何选项
                                                model: ListModel {
                                                    ListElement{text:"1200"}
                                                    ListElement{text:"2400"}
                                                    ListElement{text:"4800"}
                                                    ListElement{text:"9600"}
                                                    ListElement{text:"19200"}
                                                    ListElement{text:"38400"}
                                                    ListElement{text:"57600"}
                                                    ListElement{text:"115200"}
                                                }

                                                // 设置默认选中项
                                                currentIndex: 0
                                            }
                                        }

                                        Rectangle{
                                            width: 120
                                            height: 30
                                            Button{
                                                id:openBtn
                                                width: 70
                                                height:parent.height
                                                text: qsTr("打开")
                                                background: Rectangle{
                                                    anchors.fill: parent

                                                    border.color: "#169bd5"
                                                    border.width: 1
                                                    radius: 3
                                                }
                                                contentItem: Text {
                                                       text: parent.text
                                                       font: parent.font
                                                       opacity: enabled ? 1.0 : 0.3
                                                       color: "#169BD5" // 设置文本颜色为黑色
                                                       horizontalAlignment: Text.AlignHCenter
                                                       verticalAlignment: Text.AlignVCenter
                                                       elide: Text.ElideRight
                                                }

                                                onClicked: {
                                                    if(!testTab.status){
                                                        testTab.status = true;
                                                        serial_Combox.enabled = false
                                                        rate.enabled = false;
                                                        openBtn.text = "关闭"
                                                    }else{
                                                        testTab.status = false;
                                                        serial_Combox.enabled = true
                                                        rate.enabled = true;
                                                        openBtn.text = "打开"
                                                    }
                                                    serialService.openPort(serial_Combox.currentText,rate.currentText,testTab.status)

                                                }
                                            }
                                        }
                                    }

                                    Row{
                                        width: parent.width
                                        height: 100
                                        spacing: 10

                                        Label{
                                            text: qsTr("发送内容")
                                            width: 50
                                            height:parent.height
                                            horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                            // verticalAlignment: Text.AlignVCenter
                                        }

                                        ScrollView {
                                            id: sdView
                                            width: parent.width-190
                                            height: 100
                                            background: Rectangle {
                                                anchors.fill: parent
                                                border.color: "gray"
                                                radius: 5
                                            }

                                            TextArea {
                                                id: sendArea
                                                wrapMode: TextArea.WrapAnywhere
                                                font.pixelSize: 15
                                                selectByMouse: true
                                            }
                                        }

                                        Rectangle{
                                            width: 120
                                            height: 30

                                            Grid{
                                                width: parent.width
                                                height: parent.height
                                                anchors.topMargin: 20
                                                rows:2
                                                columns:1
                                                rowSpacing: 10
                                                columnSpacing: 5
                                                anchors.top: parent.top

                                                Row{
                                                    width: parent.width
                                                    height: 30
                                                    spacing: 10

                                                    Button{
                                                        width: parent.width+10
                                                        height:parent.height
                                                        text: qsTr("常用外设命令")
                                                        background: Rectangle{
                                                            anchors.fill: parent

                                                            border.color: "#169bd5"
                                                            border.width: 1
                                                            radius: 3
                                                        }
                                                        contentItem: Text {
                                                               text: parent.text
                                                               font: parent.font
                                                               opacity: enabled ? 1.0 : 0.3
                                                               color: "#169BD5" // 设置文本颜色为黑色
                                                               horizontalAlignment: Text.AlignHCenter
                                                               verticalAlignment: Text.AlignVCenter
                                                               elide: Text.ElideRight
                                                        }

                                                        onClicked: {
                                                        }
                                                    }
                                                }

                                                Row{
                                                    width: parent.width
                                                    height: 30
                                                    spacing: 10

                                                    Button{
                                                        width: parent.width/2
                                                        height:parent.height
                                                        text: qsTr("发送")
                                                        background: Rectangle{
                                                            anchors.fill: parent

                                                            border.color: "#169bd5"
                                                            border.width: 1
                                                            radius: 3
                                                        }
                                                        contentItem: Text {
                                                               text: parent.text
                                                               font: parent.font
                                                               opacity: enabled ? 1.0 : 0.3
                                                               color: "#169BD5" // 设置文本颜色为黑色
                                                               horizontalAlignment: Text.AlignHCenter
                                                               verticalAlignment: Text.AlignVCenter
                                                               elide: Text.ElideRight
                                                        }

                                                        onClicked: {
                                                            receiveArea.text =  serialService.sendAndReceiveMsg(sendArea.text);
                                                        }
                                                    }

                                                    Button{
                                                        width: parent.width/2
                                                        height:parent.height
                                                        text: qsTr("清除")
                                                        background: Rectangle{
                                                            anchors.fill: parent

                                                            border.color: "#169bd5"
                                                            border.width: 1
                                                            radius: 3
                                                        }
                                                        contentItem: Text {
                                                               text: parent.text
                                                               font: parent.font
                                                               opacity: enabled ? 1.0 : 0.3
                                                               color: "#169BD5" // 设置文本颜色为黑色
                                                               horizontalAlignment: Text.AlignHCenter
                                                               verticalAlignment: Text.AlignVCenter
                                                               elide: Text.ElideRight
                                                        }

                                                        onClicked: {
                                                            sendArea.text = ""
                                                        }
                                                    }
                                                }
                                            }

                                        }
                                    }

                                    Row{
                                        width: parent.width
                                        height: 100
                                        spacing: 10

                                        Label{
                                            text: qsTr("接收内容")
                                            width: 50
                                            height:parent.height
                                            horizontalAlignment: Text.AlignHCenter // 让文本水平居中
                                            // verticalAlignment: Text.AlignVCenter
                                        }

                                        ScrollView {
                                            id: reView
                                            width: parent.width-190
                                            height: 100
                                            background: Rectangle {
                                                anchors.fill: parent
                                                border.color: "gray"
                                                radius: 5
                                            }

                                            TextArea {
                                                id: receiveArea
                                                wrapMode: TextArea.WrapAnywhere
                                                font.pixelSize: 15
                                                enabled: false
                                            }
                                        }

                                        Rectangle{
                                            width: 120
                                            height: 30
                                            Button{
                                                width: 70
                                                height:parent.height
                                                text: qsTr("清除")
                                                background: Rectangle{
                                                    anchors.fill: parent

                                                    border.color: "#169bd5"
                                                    border.width: 1
                                                    radius: 3
                                                }
                                                contentItem: Text {
                                                       text: parent.text
                                                       font: parent.font
                                                       opacity: enabled ? 1.0 : 0.3
                                                       color: "#169BD5" // 设置文本颜色为黑色
                                                       horizontalAlignment: Text.AlignHCenter
                                                       verticalAlignment: Text.AlignVCenter
                                                       elide: Text.ElideRight
                                                }

                                                onClicked: {
                                                    receiveArea.text = ""
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Rectangle{
                                width: parent.width
                                height: parent.height/4
                                anchors.bottom:parent.bottom
                                border.color: "#dedede"
                                border.width: 1

                                Grid{
                                    id:lpGrid
                                    width: parent.width
                                    height: parent.height-100
                                    anchors.topMargin: 20
                                    rows:2
                                    columns:1
                                    rowSpacing: 10
                                    columnSpacing: 5
                                    anchors.top: parent.top

                                    Row{
                                        width: parent.width
                                        height: 30
                                        spacing: 10
                                        Label{
                                            text: qsTr("并口测试")
                                            width: 100
                                            height:parent.height
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignRight
                                        }
                                    }

                                    Row{
                                        width: parent.width
                                        height: 30
                                        spacing: 10
                                        Rectangle{
                                            width: parent.width
                                            height:parent.height
                                            Label{
                                                id:lpLabel
                                                text: qsTr("请接一台并口打印机，然后按")
                                                width: 180
                                                height:parent.height
                                                verticalAlignment: Text.AlignVCenter
                                                horizontalAlignment: Text.AlignRight
                                            }
                                            Button{
                                                width: 70
                                                height:parent.height
                                                text: "测试"
                                                background: Rectangle{
                                                    anchors.fill: parent

                                                    border.color: "#169bd5"
                                                    border.width: 1
                                                    radius: 3
                                                }
                                                contentItem: Text {
                                                       text: parent.text
                                                       font: parent.font
                                                       opacity: enabled ? 1.0 : 0.3
                                                       color: "#169BD5" // 设置文本颜色为黑色
                                                       horizontalAlignment: Text.AlignHCenter
                                                       verticalAlignment: Text.AlignVCenter
                                                       elide: Text.ElideRight
                                                }
                                                anchors.left: lpLabel.right
                                                anchors.leftMargin: 10

                                                onClicked: {
                                                    serialService.sendToLp(testView.serialList[4])
                                                }
                                            }
                                        }


                                    }
                                }
                            }
                        }
                    }

                    Control11.Tab {
                        title: "网络ping测试"


                        Rectangle {
                            anchors.fill: parent
                            Grid{
                                id:pingGrid
                                width: parent.width-50
                                height: parent.height-60
                                rows:6
                                columns:1
                                rowSpacing: 10
                                columnSpacing: 5
                                anchors.centerIn: parent


                                Row{
                                    width: parent.width
                                    height: 30
                                    spacing: 10

                                    Label{
                                        text: qsTr("IP")
                                        width: 50
                                        height:parent.height
                                        horizontalAlignment: Text.AlignHCenter // 让文本水平居中

                                    }
                                    TextField {
                                        id:ip
                                        width: 300
                                        height:parent.height
                                        selectByMouse: true
                                    }
                                    Button{
                                        // width: 80
                                        height:parent.height
                                        text: qsTr("ping")
                                        background: Rectangle{
                                            anchors.fill: parent
                                            color: "#f9f9f9"
                                            border.color: "#dedede"
                                            border.width: 1
                                        }

                                        onClicked: {
                                            console.log(ip.text)
                                            var resMsg = serialService.ping(ip.text);
                                            console.log(resMsg)
                                            ipArea.text = resMsg;
                                        }
                                    }
                                }

                                Row{
                                    width: parent.width
                                    height: 100
                                    spacing: 10

                                    Label{
                                        text: qsTr("ping结果")
                                        width: 50
                                        height:parent.height
                                        horizontalAlignment: Text.AlignHCenter // 让文本水平居中

                                    }
                                    ScrollView {
                                        id: ipView
                                        width: 300
                                        height: 100
                                        background: Rectangle {
                                            anchors.fill: parent
                                            border.color: "gray"
                                            radius: 5
                                        }

                                        TextArea {
                                            id: ipArea
                                            wrapMode: TextArea.WrapAnywhere
                                            font.pixelSize: 15
                                            selectByMouse: true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // FileDialog {
        //     id: fileDialog
        //     title: "Select a File"
        //     folder: "/dev" // 设置默认打开的文件夹为用户主目录
        //     selectFolder: false // 是否只允许选择文件，而不是文件夹
        //     selectMultiple: false // 是否允许选择多个文件
        //     nameFilters: ["Text files (*.txt)", "All files (*)"] // 文件过滤器
        //     onAccepted: {
        //         console.log("Selected file:", fileUrl)
        //         // 处理选中的文件
        //     }
        //     onRejected: {
        //         console.log("Dialog Rejected")
        //         // 处理对话框被取消的情况
        //     }
        // }

        Component.onCompleted: {
            tabView.currentIndex = 0; // 默认显示第二个选项卡页
        }



    }



}
