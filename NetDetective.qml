import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3

import SerialServiceObj 1.0
import ComputerServiceObj 1.0
import VncMshServiceObj 1.0

Item {
    id:netdetectContainer
    property int serialHeight:300
    property int parallHeight:100
    property int pingHeight:150
    property int mWidth: 400
    property int mHeight: 400

    property int buttonHeigth: 40
    property int buttonWidth: 20
    property int m_topMargin: 8//12
    property string lpt: ""
    property var serialMap: {
        "串口1": "",
        "串口2": "",
        "串口3": "",
        "串口4": ""}

    width: mWidth
    height: mHeight

    SerialService{
        id:serialService
    }
    ComputerService{
        id:computerService
    }
    //调用其他的页面
    SelectOptcmd{
        id:optcmd
        visible: false
    }
    VncMshService{
        id:vncMsgService
    }

    //主窗口加载完成后执行的动作
    Component.onCompleted: {
        var list  = serialService.getNormalPort();
        for(var i =0;i<list.length;i++){
            var text=list[i]
            //console.log(text)
        }
        init()
    }
    //完成初始化并准备好使用时触发的信号
    function init() {
        // 清空 ComboBox
        serial_Combox.model.clear();
        var serialmap = computerService.getSerialMsg();
        var comPort1 = serialmap["COM1_PATH"];
        var comPort2 = serialmap["COM2_PATH"];
        var comPort3 = serialmap["COM3_PATH"];
        var comPort4 = serialmap["COM4_PATH"];
        lpt = serialmap["LPT_PATH"];
        parall.text=lpt
        var bfind = false;
        //QT的串口功能，不允许带上“/etc/”,以下在展示界面的text加上“/etc/”，仅是为了展示用
        //注意：并口是有/etc/的，因为并口测试是后台命令行，与串口不一样
        if(comPort1 !==""){
            serial_Combox.model.append({text:"串口1"});
            serialMap["串口1"]=comPort1;
            comtext.text = serialMap["串口1"];
            bfind = true;
        }
        if(comPort2 !==""){
            serial_Combox.model.append({text:"串口2"});
            serialMap["串口2"]=comPort2;
            if(bfind == false){comtext.text = serialMap["串口2"];bfind = true;}
        }
        if(comPort3 !==""){
            serial_Combox.model.append({text:"串口3"});
            serialMap["串口3"]=comPort3;
            if(bfind == false){comtext.text = serialMap["串口3"];bfind = true;}
        }
        if(comPort4 !==""){
            serial_Combox.model.append({text:"串口4"});
            serialMap["串口4"]=comPort4;
            if(bfind == false){comtext.text = serialMap["串口4"];bfind = true;}
        }

        //serial_Combox.model.append({text:lpt});
        serial_Combox.currentIndex=0;
        console.log("serial_Combox init finish.")
    }
    SelectPort{
        id:select
        visible: false
    }

    ShowCommand{
        id:command
        visible: false
    }
    property var currentDate: new Date() // 创建一个属性来存储当前日期和时间
    function formatDate(date) {
        var year = date.getFullYear();
        var month = ("0" + (date.getMonth() + 1)).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        var hours = ("0" + date.getHours()).slice(-2);
        var minutes = ("0" + date.getMinutes()).slice(-2);
        var seconds = ("0" + date.getSeconds()).slice(-2);

        return year +  month + day + hours + minutes + seconds;
    }
    FileDialog {
        id: fileDialog
        title: "请选择保存文件的目录,将自动在选中的目录中生成日期格式的log文件"
        width: 640
        height: 460
        nameFilters: ["Text files (*.txt)"]
        folder:"file:///home"  //默认打开的目录为/home
        selectFolder: true // 设置为 true，表示只选择文件夹
        onAccepted: {
            var content = receiveArea.text; // 获取文本框中的内容
            // 当用户选择文件并点击"保存"时，把内容写入文件

            var dirUrl = fileDialog.folder;
            //console.log(fileDialog.folder);
            if (fileUrl !== "") {
                var sdir = dirUrl.toString().replace("file://", ""); // 获取文件路径
                var filepath = sdir +  "/" + formatDate(currentDate) + ".log"
                console.log(filepath);
                computerService.saveSerialrecvMsg(filepath,content);
            }
        }
    }

    Rectangle{
        width: parent.width-30
        height: parent.height
        anchors.centerIn: parent
        color: "transparent"
        //第1个卡片：串口测试
        Rectangle{
            id:serialContainer
            width: parent.width
            height:serialHeight
            anchors.topMargin: 5

            property int status: 0
            //1.标题栏布局
            Grid{
                id:serialGrid
                width: parent.width
                height: 50
                rows:1
                columns:1
                rowSpacing: 10
                columnSpacing: 5


                Row{
                    width: parent.width
                    height: 40
                    spacing: 10

                    Rectangle{
                        width: parent.width
                        height:parent.height

                        // 底部边框
                        Rectangle {
                            width: parent.width-10
                            height: 1 // 底部边框的宽度
                            color: "black" // 底部边框的颜色
                            anchors.bottom: parent.bottom
                        }
                        Image {
                            id: serialImg
                            width: 20
                            height:15
                            source: "qrc:/img/serialPort.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Text {
                            id:bttext
                            text: qsTr("串口测试")
                            font.pixelSize: 16
                            //font.weight: Font.Bold
                            anchors.left: serialImg.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Text {
                            //text: qsTr("注意：串口测试需要关闭虚拟机，并可能需要在root权限运行。sudo /opt/ymore/qtapps/cmmgtRelease/clientrun.sh")
                            color: "red"
                            font.pixelSize: 12
                            //font.weight: Font.Bold
                            anchors.left: bttext.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 15
                        }
                    }
                }
            }
            //2.操作主框架第一行
            Grid{
                width: parent.width
                height: parent.height-50
                anchors.top: serialGrid.bottom
                rows: 3

                //color:"blue"
                //
                Row{
                    width: parent.width
                    height: 30
                    spacing: 10

                    Label{
                        id:comlab
                        text: qsTr("串口选择")
                        font.pixelSize: 14
                        width: 80
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }
                    ComboBox{
                        id:serial_Combox
                        width: 90
                        height: parent.height
                        model: ListModel{
                        }
                        onActivated:{
                            if(currentText ==="串口1") comtext.text = serialMap["串口1"];
                            else if(currentText ==="串口2") comtext.text = serialMap["串口2"];
                            else if(currentText ==="串口3") comtext.text = serialMap["串口3"];
                            else if(currentText ==="串口4") comtext.text = serialMap["串口4"];
                        }
                    }
                    Button{
                        id:openBtn
                        width: 50
                        height: parent.height
                        contentItem: Text{
                            text: qsTr("打 开")
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
                            if(serialContainer.status == 0){
                                console.log("openPort",serial_Combox.currentText,rate.currentText)
                                //var rback=serialService.openPort(serialMap[serial_Combox.currentText],rate.currentText,1)
                                var serial_num= serialMap[serial_Combox.currentText].substring(5); // 从第6个字符开始获取后面的字符串,去掉/dev/
                                console.log(serial_num); // 输出结果为"ttyS0"
                                var rback=serialService.openPort(serial_num,rate.currentText,1)
                                //console.log("openPort",serialContainer.status,rback)
                                //串口操作失败
                                if (rback===-1){
                                    var dia = Qt.createComponent("MyMessge.qml")
                                    var dlg = dia.createObject(serialService)
                                    dlg.message = "打开串口失败!"
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
                                    serialContainer.status = 1;
                                    serial_Combox.enabled = false;
                                    rate.enabled = false;
                                    openBtn.contentItem.text="关 闭"
                                    serialstatus.color="green"
                                    console.log("===打开串口成功===",serial_Combox.currentText)
                                }
                            }else{
                                var ret=serialService.openPort(serial_Combox.currentText,rate.currentText,0)
                                if (ret===-1){
                                    var dia = Qt.createComponent("MyMessge.qml")
                                    var dlg = dia.createObject(serialService)
                                    dlg.message = "打开串口失败!"
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
                                    serialContainer.status = 0;
                                    serial_Combox.enabled = true;
                                    rate.enabled = true;
                                    openBtn.contentItem.text="打 开"
                                    serialstatus.color="red"
                                    //text: qsTr("===22===")
                                    console.log("===关闭串口成功===",serial_Combox.currentText)
                                }
                            }
                        }
                    }
                    Label{
                        id:comdlylab
                        text: qsTr("设备文件")
                        font.pixelSize: 14
                        width: 60
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }
                    TextField {
                        id:comtext
                        width: 100
                        height:parent.height
                        selectByMouse: true
                        enabled:false
                        //anchors.left: com1lab.right
                        //anchors.leftMargin: 5
                    }
                    Label{
                        id:btllab
                        text: qsTr("波特率")
                        font.pixelSize: 14
                        width: 60
                        height:parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }
                    ComboBox{
                        id:rate
                        width: 100
                        height: parent.height
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
                        currentIndex: 3
                    }

                    // Button{
                    //     id:updateBtn
                    //     width: 70
                    //     height: parent.height
                    //     contentItem: Text{
                    //         text: qsTr("更新配置")
                    //         color: "black"
                    //         anchors.fill: parent
                    //         horizontalAlignment: Text.AlignHCenter
                    //         verticalAlignment: Text.AlignVCenter
                    //     }
                    //     background: Rectangle{
                    //         anchors.fill: parent
                    //         color: "transparent"
                    //         border.color: "gray"
                    //         border.width: 1
                    //         radius: 5
                    //     }
                    //     onClicked:{
                    //         console.log("update serial data")
                    //         init()
                    //     }
                    // }

                    Text {
                        width: 76//width: 20
                        height: parent.height
                    }
                    Label {
                        id:statuslab
                        text:qsTr("串口状态:")
                        font.pixelSize: 14
                        width: 60
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                    // 绘制圆圈
                    Rectangle {
                        id:serialstatus
                        width: 24
                        height: 24
                        radius: width / 2
                        //color: "transparent"
                        color: "red"
                        border.color: "black"
                        border.width: 1
                        //anchors.left: statuslab.right
                        // id:serialstatus
                        // width: rbuttonsize
                        // height: rbuttonsize
                        // radius: rbuttonsize
                        // color: "red" // 圆圈的颜色
                        //anchors.centerIn: parent.Center
                    }
                }
                Row{
                    width: parent.width
                    height: parent.height-70
                    spacing: 20
                    Rectangle{
                        width: parent.width/2-20
                        height: parent.height
                        //color: "red"

                        Grid{
                            width: parent.width
                            height: parent.height
                            //anchors.top: serialGrid.bottom
                            rows: 2
                            Row{
                                id:left_row
                                width: parent.width
                                height: 50
                                spacing: 10
                                Rectangle{
                                    width: parent.width
                                    height: parent.height
                                    //color: "red"
                                    Label{
                                        text: qsTr("发送内容")
                                        font.pixelSize: 13
                                        width: 60
                                        height:parent.height
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        verticalAlignment: Text.AlignBottom
                                        horizontalAlignment: Text.AlignRight
                                    }
                                    Button{
                                        id:chooise_page
                                        width: 70
                                        height:30 //parent.height
                                        anchors.right: cmd_page.left
                                        anchors.rightMargin: 10
                                        anchors.top: parent.top
                                        anchors.topMargin: 15
                                        contentItem: Text{
                                            text: qsTr("快捷录入")
                                            color: "#169bd5"
                                            font.pixelSize: 12
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        background: Rectangle{
                                            anchors.fill: parent
                                            color: "transparent"
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        onClicked:{
                                            optcmd.visible=true
                                        }                        // 定义一个槽来接收消息信号
                                        Connections {
                                            target: optcmd // 指定信号的发送者
                                            onSendOptcmd: {
                                                // 当发送者发送消息时，执行以下代码
                                                sendArea.text += optcmdstr
                                            }
                                        }
                                    }
                                    Button{
                                        id:cmd_page
                                        width: 80
                                        height:30 //parent.height
                                        anchors.right: push_clear.left
                                        anchors.rightMargin: 10
                                        anchors.top: parent.top
                                        anchors.topMargin: 15
                                        contentItem: Text{
                                            text: qsTr("常用外设命令")
                                            color: "#169bd5"
                                            font.pixelSize: 12
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        background: Rectangle{
                                            anchors.fill: parent
                                            color: "transparent"
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        onClicked:{
                                            command.visible=true
                                        }
                                    }
                                    Button{
                                        id:push_clear
                                        width: 80
                                        height:30//parent.height
                                        anchors.right: sendbtn.left
                                        anchors.rightMargin: 10
                                        anchors.top: parent.top
                                        anchors.topMargin: 15
    //                                    text: "清空发送区"
                                        contentItem: Text{
                                            text: qsTr("清空发送区")
                                            color: "#169bd5"
                                            font.pixelSize: 12
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        background: Rectangle{
                                            anchors.fill: parent
                                            color: "transparent"
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        onClicked:{
                                            sendArea.text = ""
                                        }
                                    }
                                    Button{
                                        id:sendbtn
                                        width: 60
                                        height:30//parent.height
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.topMargin: 15
                                        contentItem: Text{
                                            text: qsTr("发送")
                                            color: "#169bd5"
                                            font.pixelSize: 12
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        background: Rectangle{
                                            anchors.fill: parent
                                            color: "transparent"
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        onClicked:{
                                            serialService.sendAndReceiveMsg(sendArea.text);
                                            var text = receiveArea.text;
                                            if(text !== "" ){
                                                receiveArea.text = text+"\n";
                                            }
                                        }
                                    }
                                }

                            }
                            //
                            Row{
                                width: parent.width
                                height: parent.height-left_row.height
                                spacing: 10

                                TextField {
                                    id:sendArea
                                    width: parent.width-20
                                    height:parent.height
                                    selectByMouse: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20
                                    horizontalAlignment: TextInput.AlignLeft // 水平对齐方式为左对齐
                                    verticalAlignment: TextInput.AlignTop // 垂直对齐方式为顶部对齐
                                    text: ""
                                    font.pixelSize: 12
                                }
                            }
                        }

                    }
                    Rectangle{
                        width: parent.width/2
                        height: parent.height
                        //color: "blue"
                        Grid{
                            width: parent.width
                            height: parent.height
                            //anchors.top: serialGrid.bottom
                            rows: 2
                            Row{
                                id:right_row
                                width: parent.width
                                height: 50
                                spacing: 10
                                Rectangle{
                                    width: parent.width
                                    height: parent.height
                                    //color: "red"
                                    Label{
                                        text: qsTr("接收内容")
                                        font.pixelSize: 13
                                        width: 50
                                        height:parent.height
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        verticalAlignment: Text.AlignBottom
                                        horizontalAlignment: Text.AlignRight
                                    }
                                    Button{
                                        id:savebtn
                                        width: 60
                                        height:30//parent.height
                                        anchors.right: clearbtn.left
                                        anchors.rightMargin: 10
                                        anchors.top: parent.top
                                        anchors.topMargin: 15
                                        contentItem: Text{
                                            text: qsTr("另存为")
                                            color: "#169bd5"
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        background: Rectangle{
                                            anchors.fill: parent
                                            color: "transparent"
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        onClicked:{
                                            if(receiveArea.text==""){
                                                var dia = Qt.createComponent("MyMessge.qml")
                                                var dlg = dia.createObject(computerService)
                                                dlg.message = "请确保有接收区数据后再进行保存操作！"
                                                dlg.btnType = dlg.mb_OK
                                                dlg.closing.connect(function ret(){
                                                    if(dlg.retValue === dlg.mb_YES)
                                                    {
                                                        //do something
                                                    }
                                                    dlg.destroy()
                                                })
                                                dlg.show()
                                            }else
                                                fileDialog.open()

                                            //onClicked: fileDialog.open()
                                        }
                                    }
                                    Button{
                                        id:clearbtn
                                        width: 80
                                        height:30//parent.height
                                        anchors.right: parent.right
                                        anchors.rightMargin:20
                                        anchors.top: parent.top
                                        anchors.topMargin: 15
                                        contentItem: Text{
                                            text: qsTr("清空缓存区")
                                            color: "#169bd5"
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        background: Rectangle{
                                            anchors.fill: parent
                                            color: "transparent"
                                            border.color: "#169bd5"
                                            border.width: 1
                                            radius: 3
                                        }
                                        onClicked:{
                                            receiveArea.text = ""
                                        }
                                    }

                                }
                            }
                            //接收编辑框
                            Row{
                                width: parent.width-30
                                height: parent.height-left_row.height
                                spacing: 10
                                Rectangle{
                                    width: parent.width
                                    height:parent.height
                                    border.color: "gray"
                                    border.width: 1
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    ScrollView {
                                        id: reView
                                        anchors.fill: parent
                                        background: Rectangle {
                                            anchors.fill: parent
                                            border.color: "gray"
                                            radius: 5
                                        }

                                        TextArea {
                                            id: receiveArea
                                            wrapMode: TextArea.WrapAnywhere
                                            font.pixelSize: 12
                                            selectByMouse: true
                                            readOnly: true
                                        }
                                        // Connections {
                                        //     target: computerService // 连接到 C++ 对象
                                        //     onSerialPathUpdate: {
                                        //         console.log("onSerialPathUpdate:"+serialPath)
                                        //         // 当信号触发时更新文本
                                        //         //serialMap["串口1"]=serialPath;
                                        //         receiveArea.text=serialPath;
                                        //     }
                                        // }
                                        Connections {
                                            target: serialService // 连接到 C++ 对象
                                            onPutReceviceData: {
                                                // 当信号触发时更新文本
                                                var old = receiveArea.text;
                                                receiveArea.text = old+data;
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
                    height: 30
                    spacing: 10
                    Rectangle{
                        width: parent.width
                        height: parent.height
                        //color: "green"
                        Text{
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            color: "#f8ac2f"
                            //text: "说明：发送的字符串中，如果个别数据需要以十六进制表达，则用<>包含起来。如<1B>B]实际发送数据是1BH 42H 5DH \n同样地，接收的数据也是按上述规则显示。"
                            text: "说明：发送的字符串中，如果个别数据需要以十六进制表达，则用<>包含起来。\n如:在手册中，读磁卡的命令是ESC B]，则文本框中输入<1B>B](实际发送数据是1BH 42H 5DH) 。同样地，接收的数据也是按上述规则显示。"
                        }
                    }
                }
            }
        }

        Rectangle{
            id:parallContainer
            width: parent.width
            height: parallHeight
            anchors.top: serialContainer.bottom
            anchors.topMargin: m_topMargin


            Grid{
                id:parallGrid
                width: parent.width
                height: 60
                rows:1
                columns:1
                rowSpacing: 10
                columnSpacing: 5
                anchors.top: parent.top

                Row{
                    width: parent.width
                    height: 40
                    spacing: 10

                    Rectangle{
                        width: parent.width
                        height:parent.height

                        // 底部边框
                        Rectangle {
                            width: parent.width-10
                            height: 1 // 底部边框的宽度
                            color: "black" // 底部边框的颜色
                            anchors.bottom: parent.bottom
                        }
                        Image {
                            id: parallImg
                            width: 20
                            height:17
                            source: "qrc:/img/port.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Text {
                            id:lpttext
                            text: qsTr("并口打印机测试")
                            font.pixelSize: 16
                            //font.weight: Font.Bold
                            anchors.left: parallImg.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Text {
                            //text: qsTr("注意：并口测试需要关闭虚拟机，并可能需要在root权限运行。sudo /opt/ymore/qtapps/cmmgtRelease/clientrun.sh")
                            color: "red"
                            font.pixelSize: 12
                            //font.weight: Font.Bold
                            anchors.left: lpttext.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 15
                        }
                    }
                }


            }

            Rectangle{
                width: parent.width
                height: parent.height-60
                anchors.bottom: parent.bottom
                Rectangle{
                    width: parent.width/2
                    height: parent.height
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    Connections {
                        target: select // 指定信号的发送者
                        onSendParall: {
                            // 当发送者发送消息时，执行以下代码
                            parall.text = path
                        }
                    }
                    Text {
                        id:parallLabel
                        width: 100
                        height: 30
                        text: qsTr("打印机并口文件")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                    }
                    TextField{
                        id:parall
                        width: 180
                        height: 30
                        selectByMouse: true
                        anchors.left: parallLabel.right
                        anchors.leftMargin: 20
                        enabled:false
                    }
                }
                Rectangle{
                    width: parent.width/2
                    height: parent.height
                    anchors.right: parent.right

                    Text {
                        id: parallText
                        width: 180
                        height: parent.height
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        text: qsTr("请接一台并口打印机")
                    }
                    Button{
                        width: 50
                        height: 30
                        anchors.left: parallText.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 15
                        contentItem: Text{
                            text: qsTr("测试")
                            color: "#169bd5"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "#169bd5"
                            border.width: 1
                            radius: 3
                        }
                        onClicked: {
                            var dia = Qt.createComponent("MyMessge.qml")
                            var dlg = dia.createObject(netdetectContainer)
                            //检测虚拟机是否运行，如果运行需要提醒先关闭虚拟机
                            var vboxstatus = serialService.checkvboxstatus()
                            if(vboxstatus===true){
                                dlg.message = "虚拟机为开启状态，请关闭虚拟机并在【系统配置】菜单中进行【重建lp】再进行测试。"
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
                                //检测并口文件是否存在，如果不存在需要重建并口及文件
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
                                }else
                                    serialService.sendToLp(parall.text)
                            }
                        }
                    }

                }


            }
        }

        Rectangle{
            id:netContainer
            width: parent.width
            height: pingHeight
            anchors.top: parallContainer.bottom
            anchors.topMargin: m_topMargin


            Grid{
                id:netGrid
                width: parent.width
                height: 60
//                anchors.topMargin: 20
                rows:1
                columns:1
                rowSpacing: 10
                columnSpacing: 5
                anchors.top: parent.top

                Row{
                    width: parent.width
                    height: 40
                    spacing: 10

                    Rectangle{
                        width: parent.width
                        height:parent.height

                        // 底部边框
                        Rectangle {
                            width: parent.width-20
                            height: 1 // 底部边框的宽度
                            color: "black" // 底部边框的颜色
                            anchors.bottom: parent.bottom
                        }
                        Image {
                            id: netImg
                            width: 20
                            height:20
                            source: "qrc:/img/netPort.png"
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }
                        Text {
                            text: qsTr("网口测试")
                            font.pixelSize: 16
                            //font.weight: Font.Bold
                            anchors.left: netImg.right
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 10
                        }

                    }
                }


            }

            Rectangle{
                width: parent.width
                height: parent.height-50
                anchors.bottom: parent.bottom

                Rectangle{
                    width: (parent.width-50)/2
                    height: parent.height
                    anchors.left: parent.left

                    Grid{
                        width: parent.width
                        height: parent.height
                        rows:1
                        columns:3
                        columnSpacing: 10
                        anchors.centerIn: parent


                        Rectangle{
                            width: parent.width
                            height: parent.height-40
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 22
                            //color: "blue"
                            Text {
                                id:iplab
                                width: 50
                                height: 30
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                text: qsTr("IP地址")
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextField{
                                id:ip
                                width: 200
                                height: 30
                                selectByMouse: true
                                anchors.left: iplab.right
                                anchors.leftMargin: 10

                            }
                            Button{
                            width: 60
                            height: 30
                            anchors.left: ip.right
                            anchors.leftMargin: 10
                            contentItem: Text{
                                text: qsTr("ping")
                                color: "#169bd5"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            background: Rectangle{
                                anchors.fill: parent
                                color: "transparent"
                                border.color: "#169bd5"
                                border.width: 1
                                radius: 3
                            }
                            onClicked: {
                                console.log(ip.text)
                                var resMsg = serialService.ping(ip.text);
                                console.log(resMsg)
                                pingText.text = resMsg;
                            }
                        }
                        }
                    }
                }
                Rectangle{
                    width: (parent.width+50)/2
                    height: parent.height-10
                    anchors.right: parent.right
//color:"red"
                    ScrollView {

                        width: parent.width-20
                        height: parent.height-2
                        background: Rectangle {
                            anchors.fill: parent
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }

                        TextArea {
                            id: pingText
                            wrapMode: TextArea.WrapAnywhere
                            font.pixelSize: 12
                            selectByMouse: true
                        }
                    }
                }
            }
        }

    }

}
