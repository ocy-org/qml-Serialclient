import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import VncMshServiceObj 1.0
import ComputerServiceObj 1.0
import SerialServiceObj 1.0
import "."

Item {
    id:vncconfigContainer
    property int mWidth: 400
    property int mHeight: 600

    property int ktitleheight: 40
    property int rbuttonsize: 16
    //调用其他的页面
    SelectPort{
        id:selectcom1
        visible: false
    }
    SelectPort{
        id:selectcom2
        visible: false
    }
    SelectPort{
        id:selectcom3
        visible: false
    }
    SelectPort{
        id:selectcom4
        visible: false
    }
    SelectPort{
        id:selectlpt
        visible: false
    }
    SerialService{
        id:serialService
    }
    //signal serialchange(var map_msg)

    width: mWidth
    height: mHeight
    //
    Rectangle{
        width: parent.width-30
        height: parent.height
        anchors.centerIn: parent
        color: "transparent"

        VncMshService{
            id:vncMsgService
        }
        ComputerService{
            id:computerService
        }
        Component.onCompleted: {
            var map = vncMsgService.getVncMsg();
            if(typeof(map) == "undefined"){
                console.log("Map 为: undefined" );
            }else{
                //console.log("Map bu为: undefined" );
                if(map["Allow"] === 0){
                    forbid.checked = true;
                }else if(map["Allow"] === 1){
                    ask.checked = true;
                    assginContainer.visible = true;
                }else if(map["Allow"] === 2){
                    allow.checked = true;
                    assginContainer.visible = true;
                }

                if(map["Assitant"] === 0){
                    read.checked = true;
                }else{
                    option.checked = true;
                }

                if(map["Assign"] === 1){
            }



                //assignCheck.checked = true;
                assignIp.text = map["AssignIp"];
            }


            var portMap = computerService.getCntCnf();
            ftpPort.text = portMap["FTP_PORT"];
            tepPort.text = portMap["TEP_PORT"];
            receivePort.text = portMap["RECEIVE_PORT"];
            udpPort.text = portMap["UDP_PORT"];
            //console.log("=getCntCnf=",ftpPort.text,tepPort.text,receivePort.text,udpPort.text)

            var serialmap = computerService.getSerialMsg();
            comPort1.text = serialmap["COM1_PATH"];
            comPort2.text = serialmap["COM2_PATH"];
            comPort3.text = serialmap["COM3_PATH"];
            comPort4.text = serialmap["COM4_PATH"];
            lptPort.text = serialmap["LPT_PATH"];
        }
        //第一个卡片：远程监控配置
        Rectangle{
            id:vncContainer
            width: parent.width
            //height: 250
            height: 220
            anchors.top: parent.top // 把Rectangle放置在父组件的顶部
            anchors.topMargin: 12   // 距离父组件顶部的距离为 20 像素
            //color: "red"

            Grid{
                id:grid
                width: parent.width
                height: parent.height
                rows:4
                columns:1
                rowSpacing: 10
                columnSpacing: 5

                //卡片标题栏
                Row{
                    width: parent.width
                    height: ktitleheight
                    spacing: 10

                    Rectangle{
                        width: parent.width
                        height:parent.height
                        //color: "blue"
                        // 底部边框着色--相当于划分割线效果
                        Rectangle {
                            width: parent.width-10
                            height: 1 // 底部边框的宽度
                            color: "black" // 底部边框的颜色
                            anchors.bottom: parent.bottom
                        }
                        Image {
                            id: vncImg
                            width: 20
                            height:20
                            source: "qrc:/img/vnc.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.top: parent.top// 把Rectangle放置在父组件的顶部
                            anchors.topMargin: 10// 距离父组件顶部的距离为 10 像素
                            /*Rectangle {
                                width: parent.width
                                height:parent.height
                                //color: "blue" // 底部边框的颜色
                            }*/
                        }
                        Text {
                            id:vncopt
                            text: qsTr("远程监控配置")
                            font.pixelSize: 16
                            //font.weight: Font.Bold
                            anchors.left: vncImg.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top// 把Rectangle放置在父组件的顶部
                            anchors.topMargin: 10// 距离父组件顶部的距离为 10 像素
                            /*Rectangle {
                                width: parent.width+20
                                height:parent.height
                                //color: "red" // 底部边框的颜色
                            }*/
                        }
                        Button{
                            width: 100
                            height:parent.height-10
                            contentItem: Text{
                                text: qsTr("保存")
                                color: "white"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.rightMargin: 20
                            background: Rectangle{
                                anchors.fill: parent
                                color: "#2E8DED"
                                border.color: "#dedede"
                                border.width: 1
                                radius: 5
                            }

                            onClicked: {
                                var map = {};
                                if(forbid.checked){
                                    map["Allow"]=0;
                                }else {
                                    if(ask.checked){
                                        map["Allow"]=1;
                                    }else{
                                        map["Allow"]=2;
                                    }
                                    if(read.checked){
                                        map["Assitant"] = 0;
                                    }else{
                                        map["Assitant"] = 1;
                                    }
                                }
                                if(assignCheck.checked){
                                    map["Assign"] = 1;
                                    map["AssignIp"] = assignIp.text;
                                }
                                // else{
                                //     map["Assign"] = 1;
                                // }

                                vncMsgService.saveOrUpdateVncMsg(map);

                                var dia = Qt.createComponent("MyMessge.qml")
                                var dlg = dia.createObject(computerService)
                                dlg.message = vncopt.text+"保存成功!"
                                dlg.btnType = dlg.mb_OK
                                dlg.closing.connect(function ret(){
                                    if(dlg.retValue === dlg.mb_YES)
                                    {
                                        //do something
                                    }
                                    dlg.destroy()
                                })
                                dlg.show()
                            }
                        }
                    }
                }
                //监控内容行
                Row{

                    width: parent.width
                    height: 120
                    spacing: 10

                    ButtonGroup {
                        id: allowGroup
                    }
                    ButtonGroup {
                        id: assignGroup
                    }
                    //分成左右两个布局---这是左布局
                    Rectangle{
                        width: parent.width/2 //分成左右两个布局
                        height: parent.height
//color:"red"
                        Grid{
                            id:contentGrid
                            width: parent.width-40
                            height: parent.height
                            rows:4
                            columns:1
                            columnSpacing: 5
                            anchors.centerIn: parent
                            Row{
                                width: parent.width
                                height:parent.height/5
                                Label{
                                    text: qsTr("监控允许：")
                                    font.pixelSize: 16
                                    anchors.top: parent.top
                                }
                            }

                            Row{
                                width: parent.width
                                height:parent.height/5
                                RadioButton {
                                    id:forbid
                                    // width: 100
                                    // height: 30
                                    text: "禁止监控我"
                                    indicator.width: rbuttonsize
                                    indicator.height: rbuttonsize
                                    Component.onCompleted:allowGroup.addButton(this)
                                    onClicked: {
                                        assginContainer.visible = false;
                                    }
                                }
                            }
                            Row{
                                width: parent.width
                                height:parent.height/5
                                RadioButton {
                                    id:ask
                                    text: "监控我之前，需要询问我是否同意"
                                    indicator.width: rbuttonsize
                                    indicator.height: rbuttonsize
                                    Component.onCompleted:allowGroup.addButton(this)
                                    onClicked: {
                                        assginContainer.visible = true;
                                    }
                                }
                            }
                            Row{
                                width: parent.width
                                height:parent.height/5
                                RadioButton {
                                    id:allow
                                    indicator.width: rbuttonsize
                                    indicator.height: rbuttonsize
                                    text: "监控我时，不需要我同意"
                                    Component.onCompleted:allowGroup.addButton(this)
                                    onClicked: {
                                        assginContainer.visible = true;
                                    }
                                }
                            }
                        }


                    }
                    //分成左右两个布局---这是右布局
                    Rectangle{
                        id:assginContainer
                        width: parent.width/2-20
                        height: parent.height
                        visible: false
                        Grid{
                            id:assignGrid
                            width: parent.width-40
                            height: parent.height
                            rows:3
                            columns:1
                            columnSpacing: 5
                            anchors.centerIn: parent
//color:"blue"
                            Row{
                                width: parent.width
                                height:parent.height/4
                                Label{
                                    text: qsTr("协助模式:")
                                    font.pixelSize: 16
                                }
                            }

                            Row{
                                width: parent.width
                                height:parent.height/4
                                RadioButton {
                                    id:read
                                    indicator.width: rbuttonsize
                                    indicator.height: rbuttonsize
                                    text: "管理员只允许查看我的屏幕，不允许操作我的电脑"
                                    Component.onCompleted:assignGroup.addButton(this)
                                }
                            }
                            Row{
                                width: parent.width
                                height:parent.height/4
                                RadioButton {
                                    id:option
                                    indicator.width: rbuttonsize
                                    indicator.height: rbuttonsize
                                    text: "管理员可以跟我共同操作"
                                    Component.onCompleted:assignGroup.addButton(this)
                                }
                            }
                        }
                    }
                }
                //IP允许
                Row{
                    width: 16
                    height: 16
                    spacing: 10
                    Rectangle{
                        id:assignre
                        width: parent.width
                        height:parent.height
                        //color: "red"  // 设置为透明以便看到后面的内容
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        CheckBox {
                            id:assignCheck
                            enabled: false // 设置复选框不允许点击--v1.1版本暂不支持此功能
                            indicator: Rectangle{
                                implicitWidth: 16
                                implicitHeight: 16
                                radius: 3
                                border.color: assignCheck.checked ? "blue" : "#CCCCCC"
                                border.width: 2
                                //color: "transparent"

                                Text {
                                    anchors.centerIn: parent
                                    visible: assignCheck.checked
                                    text: assignCheck.checked ? "\u2713" : ""
                                }
                            }
                            // 可以在这里添加复选框的其他属性和信号处理程序
                            onClicked: {
                                if(assignCheck.checked){
                                    assignIp.enabled=true
                                }else{
                                    assignIp.enabled=false
                                }
                            }
                        }
                    }
                    Rectangle{
                        id : contre
                        width: 180
                        height: 20
                        anchors.left: assignre.right
                        anchors.leftMargin: 2
                        Text {
                            text: "只允许指定IP对我进行实时监控"
                        }
                    }
                    Rectangle{
                        id:ckipre
                        width: 180
                        height: 25
                        anchors.left: contre.right
                        anchors.leftMargin: 5
                        TextField {
                            id:assignIp
                            width: 180
                            height:parent.height
                            enabled: false
                        }
                    }
                    Rectangle{
                        width: 180
                        height: 20
                        anchors.left: ckipre.right
                        anchors.leftMargin: 2
                        Text {
                            text: "(暂不支持)"
                            color:"red"
                        }
                    }
                }

            }
        }
        //第二个卡片：通讯端口配置
        Rectangle{
            id:cntContainer
            width: parent.width
            //height: 250
            height: 160
            anchors.top: vncContainer.bottom //放在第一个卡片底部后面
            anchors.topMargin: 12
            Grid{
                id:cntGrid
                width: parent.width
                height: 30
                //anchors.topMargin: 16
                rows:1
                columns:1
                rowSpacing: 10
                columnSpacing: 5
                anchors.top: parent.top
                Row{
                    width: parent.width
                    height: ktitleheight
                    spacing: 10

                    Rectangle{
                        width: parent.width
                        height:parent.height
                        //color:"blue"
                        // 底部边框
                        Rectangle {
                            width: parent.width-10
                            height: 1 // 底部边框的宽度
                            color: "black" // 底部边框的颜色
                            anchors.bottom: parent.bottom
                        }
                        Image {
                            id: cntImg
                            width: 20
                            height:20
                            source: "qrc:/img/port.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Text {
                            id:socketopt
                            text: qsTr("通讯端口配置")
                            font.pixelSize: 16
                            //font.weight: Font.Bold
                            anchors.left: cntImg.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Button{
                            width: 100
                            height:parent.height-10
                            contentItem: Text{
                                text: qsTr("保存")
                                color: "white"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.rightMargin: 20
                            background: Rectangle{
                                anchors.fill: parent
                                color: "#2E8DED"
                                border.color: "#dedede"
                                border.width: 1
                                radius: 5
                            }

                            onClicked: {
                                var ftp = ftpPort.text
                                var tep = tepPort.text
                                var receive = receivePort.text
                                var udp = udpPort.text

                                computerService.savePort(ftp,tep,receive,udp);

                                var dia = Qt.createComponent("MyMessge.qml")
                                var dlg = dia.createObject(computerService)
                                dlg.message = socketopt.text+"保存成功!"
                                dlg.btnType = dlg.mb_OK
                                dlg.closing.connect(function ret(){
                                    if(dlg.retValue === dlg.mb_YES)
                                    {
                                        //do something
                                    }
                                    dlg.destroy()
                                })
                                dlg.show()
                            }

                        }

                    }
                }


            }

            Grid{
                id:tabGrid
                width: parent.width
                height: parent.height-60
                rows:2
                columns:2
                rowSpacing: 20
                anchors.top: cntGrid.bottom
                anchors.topMargin: 30

                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("文件互传端口(tcp)")
                        width: 160
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:ftpPort
                        width: 200
                        height:parent.height
                        selectByMouse: true
                    }
                }


                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("实时控制端口(tep)")
                        width: 160
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:tepPort
                        width: 200
                        height:parent.height
                        selectByMouse: true
                    }
                }

                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("消息接收端口(tcp)")
                        width: 160
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:receivePort
                        width: 200
                        height:parent.height
                        selectByMouse: true
                    }
                }

                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("实时控制端口(udp)")
                        width: 160
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:udpPort
                        width: 200
                        height:parent.height
                        selectByMouse: true
                    }
                }
            }

        }
        //第三个卡片：串并口设备文件设置
        Rectangle{
            id:serialContainer
            width: parent.width
            //height: 250
            height: 190
            anchors.top: cntContainer.bottom
            anchors.topMargin: 12   // 距离父组件顶部的距离为 20 像素
            //color: "red"

            Grid{
                id:srlGrid
                width: parent.width
                height: 30
                //anchors.topMargin: 16
                rows:1
                columns:1
                rowSpacing: 10
                columnSpacing: 5
                anchors.top: parent.top
                Row{
                    width: parent.width
                    height: ktitleheight
                    spacing: 10

                    Rectangle{
                        width: parent.width
                        height:parent.height
                        //color:"blue"
                        // 底部边框
                        Rectangle {
                            width: parent.width-10
                            height: 1 // 底部边框的宽度
                            color: "black" // 底部边框的颜色
                            anchors.bottom: parent.bottom
                        }
                        Image {
                            id: srlImg
                            width: 20
                            height:20
                            source: "qrc:/img/serialPort.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Text {
                            id:srlopt
                            text: qsTr("串并口设备文件设置")
                            font.pixelSize: 16
                            //font.weight: Font.Bold
                            anchors.left: srlImg.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Button{
                            width: 100
                            height:parent.height-10
                            contentItem: Text{
                                text: qsTr("保存")
                                color: "white"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.rightMargin: 20
                            background: Rectangle{
                                anchors.fill: parent
                                color: "#2E8DED"
                                border.color: "#dedede"
                                border.width: 1
                                radius: 5
                            }

                            onClicked: {
                                var dia = Qt.createComponent("MyMessge.qml")
                                var dlg = dia.createObject(computerService)
                                dlg.message = "保存成功!"

                                var com1 = comPort1.text
                                var com2 = comPort2.text
                                var com3 = comPort3.text
                                var com4 = comPort4.text
                                var lpt = lptPort.text   //并口要保存全路径才行"/dev/"+

                                if(com1==""&&com2==""&&com3==""&&com4==""&&lpt=="")
                                    dlg.message = "配置错误，请选择并配置有效的设备文件!"
                                else{
                                    computerService.saveSerialMag(com1,com2,com3,com4,lpt);//保存串并口配置信息到配置文件
                                    // var map_msg = {
                                    //     "COM1_PATH": com1,
                                    //     "COM2_PATH": com2,
                                    //     "COM3_PATH": com3,
                                    //     "COM4_PATH": com4,
                                    //     "LPT_PATH" : lpt
                                    // };
                                    // serialchange(map_msg)
                                }

                                dlg.btnType = dlg.mb_OK
                                dlg.closing.connect(function ret(){
                                    if(dlg.retValue === dlg.mb_YES)
                                    {
                                        //do something
                                    }
                                    dlg.destroy()
                                })
                                dlg.show()
                            }

                        }

                    }
                }


            }

            Grid{
                id:srltabGrid
                width: parent.width
                height: parent.height-60
                rows:3
                columns:2
                rowSpacing: 10
                anchors.top: srlGrid.bottom
                anchors.topMargin: 30
                // anchors.left: parent.left
                // anchors.leftMargin: 50

                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        id:com1lab
                        text: qsTr("串口1")
                        width: 80
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:comPort1
                        width: 220
                        height:parent.height
                        selectByMouse: true
                        //anchors.left: com1lab.right
                        //anchors.leftMargin: 5
                    }
                    Button{
                        width: 50
                        height: parent.height
                        contentItem: Text{
                            text: qsTr("选择")
                            color: "black"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        onClicked:{
                            selectcom1.portType=0
                            selectcom1.visible=true
                        }
                        // 定义一个槽来接收消息信号
                        Connections {
                            target: selectcom1 // 指定信号的发送者
                            onSendSerial: {
                                // 当发送者发送消息时，执行以下代码
                                comPort1.text = path
                            }
                        }
                    }
                }


                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("串口3")
                        width: 80
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:comPort3
                        width: 220
                        height:parent.height
                        selectByMouse: true
                    }
                    Button{
                        width: 50
                        height: parent.height
                        contentItem: Text{
                            text: qsTr("选择")
                            color: "black"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        onClicked:{
                            selectcom3.portType=0
                            selectcom3.visible=true
                        }
                        // 定义一个槽来接收消息信号
                        Connections {
                            target: selectcom3 // 指定信号的发送者
                            onSendSerial: {
                                // 当发送者发送消息时，执行以下代码
                                comPort3.text = path
                            }
                        }
                    }
                }

                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("串口2")
                        width: 80
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:comPort2
                        width: 220
                        height:parent.height
                        selectByMouse: true
                    }
                    Button{
                        width: 50
                        height: parent.height
                        contentItem: Text{
                            text: qsTr("选择")
                            color: "black"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        onClicked:{
                            selectcom2.portType=0
                            selectcom2.visible=true
                        }
                        // 定义一个槽来接收消息信号
                        Connections {
                            target: selectcom2 // 指定信号的发送者
                            onSendSerial: {
                                // 当发送者发送消息时，执行以下代码
                                comPort2.text = path
                            }
                        }
                    }
                }

                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("串口4")
                        width: 80
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:comPort4
                        width: 220
                        height:parent.height
                        selectByMouse: true
                    }
                    Button{
                        width: 50
                        height: parent.height
                        contentItem: Text{
                            text: qsTr("选择")
                            color: "black"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        onClicked:{
                            selectcom4.portType=0
                            selectcom4.visible=true
                        }
                        // 定义一个槽来接收消息信号
                        Connections {
                            target: selectcom4 // 指定信号的发送者
                            onSendSerial: {
                                // 当发送者发送消息时，执行以下代码
                                comPort4.text = path
                            }
                        }
                    }
                }
                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10

                    Label{
                        text: qsTr("并口打印机")
                        width: 80
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }

                    TextField {
                        id:lptPort
                        width: 220
                        height:parent.height
                        selectByMouse: true
                    }
                    Button{
                        width: 50
                        height: parent.height
                        contentItem: Text{
                            text: qsTr("选择")
                            color: "black"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        onClicked:{
                            selectlpt.portType=0
                            selectlpt.visible=true
                        }
                        // 定义一个槽来接收消息信号
                        Connections {
                            target: selectlpt // 指定信号的发送者
                            onSendSerial: {
                                // 当发送者发送消息时，执行以下代码
                                lptPort.text = path
                            }
                        }
                    }
                }
                Row{
                    width: (parent.width-30)/2
                    height: 30
                    spacing: 10
                    Label{
                        text: qsTr("")
                        width: 80
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }
                    Label{
                        text: qsTr("提示：如果没有/dev/lp0、/dev/lp1,\n需要关闭虚拟机，并在这里重建")
                        color: "red"
                        width: 220
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        //horizontalAlignment: Text.AlignRight
                    }
                    Button{
                        width: 50
                        height: parent.height
                        contentItem: Text{
                            text: qsTr("重建lp")
                            color: "black"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        onClicked:{
                            var dia = Qt.createComponent("MyMessge.qml")
                            var dlg = dia.createObject(vncconfigContainer)
                            //检测虚拟机是否运行，如果运行需要提醒先关闭虚拟机
                            var vboxstatus = serialService.checkvboxstatus()
                            if(vboxstatus===true){
                                dlg.message = "虚拟机为开启状态，请关闭虚拟机后,再进行【重建lp】操作。"
                                dlg.btnType = dlg.mb_OK
                                dlg.closing.connect(function ret(){
                                    if(dlg.retValue === dlg.mb_YES)
                                    {
                                        //do something
                                    }
                                    dlg.destroy()
                                })
                                dlg.show()
                            }else{
                                console.log("===rebuildlpt====")
                                var bret=vncMsgService.rebuildlpt();
                                if(bret===0){
                                    dlg.message = "并口文件(/dev/lp0、/dev/lp1)重建异常。"
                                    dlg.btnType = dlg.mb_OK
                                    dlg.closing.connect(function ret(){
                                        if(dlg.retValue === dlg.mb_YES)
                                        {
                                            //do something
                                        }
                                        dlg.destroy()
                                    })
                                    dlg.show()
                                }else{
                                    dlg.message = "并口文件重建成功。"
                                    dlg.btnType = dlg.mb_OK
                                    dlg.closing.connect(function ret(){
                                        if(dlg.retValue === dlg.mb_YES)
                                        {
                                            //do something
                                        }
                                        dlg.destroy()
                                    })
                                    dlg.show()
                                }
                            }

                        }
                    }
                }
            }

        }
    }



}
