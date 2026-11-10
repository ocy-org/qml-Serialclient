import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import ComputerServiceObj 1.0
Window {

    id:pwdcheck_window
    width: 400
    height: 400
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200
    title: "客户端配置"
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    property bool m_visible: false
    property int m_modality: Qt.ApplicationModal
    property bool isfirstcheck: false // 自定义属性
    property bool ischeck_OK: false // 自定义属性
    property bool textedit: true

    visible: m_visible
    modality: m_modality
    flags: Qt.Window  | Qt.WindowCloseButtonHint

    ComputerService{
        id:computerService
    }
    // 重写关闭按钮事件处理
    onClosing: {
        //未输入过密码的，可以直接关闭窗口登录，如果输入密码就必须校验--#20240046BUG优化项
        var pwdck = computerService.checkloaclpwd("");
        if(pwdck===true) ischeck_OK=true;
        if (!ischeck_OK) {
            pwdcheck_window.close()//关闭自己的窗口--如果不关闭自己，关闭主窗口是无效的操作
            mainWindow.close()//关闭窗口
        }
    }
    //完成初始化并准备好使用时触发的信号
    onVisibleChanged: {
        if (visible) {
            //校验配置文件中，验证密码是不是空，如果是空说明是首次验证
            var pwdck = computerService.checkloaclpwd("");
            //console.log("pwdck:",pwdck);
            if(pwdck===true){
                errormsg.text="提醒：当前为首次登录，请输入需要保存的验证密码";
                errormsg.visible = true;
                pwdcheck_window.isfirstcheck = true;
            }
        }
        /*if(ischeck_OK){

        }*/
    }

    Rectangle{
        width: parent.width
        height: parent.height-50

        Rectangle{
            width: parent.width
            height: 1
            anchors.top: parent.top
            color: "#d2d2d2"
        }

        Rectangle{
            width: parent.width-100
            height: parent.height-60   //与窗口顶框的距离
            anchors.centerIn: parent
            //color: "red" // 调试颜色
            Grid{
                anchors.fill: parent
                rows: 3
                columns: 1
                rowSpacing: 10
                Row{
                    width: parent.width
                    height: 30
                    Text {
                        id: userNameText
                        width: parent.width
                        height: parent.height
                        text: qsTr("密码验证")
                        horizontalAlignment: Text.AlignHCenter  // 水平居中对齐
                        verticalAlignment: Text.AlignVCenter    // 垂直居中对齐
                        font {
                            bold: true
                            pixelSize: 18 // 或者 pointSize: 16
                        }
                    }
                }
                Row{
                    width: parent.width
                    height: 30
                    Text {
                        id: passwordText
                        width: 40
                        height: parent.height
                        text: qsTr("密码")
                    }
//                    TextField{
//                        id:password
//                        width: 150
//                        height: parent.height
//                        selectByMouse: true
//                    }
                    Rectangle{
                        width: 250
                        height: parent.height
                        border.color: "#d2d2d2"
                        border.width: 1
                        //color:"red"
                        TextInput{
                            id:password
                            width: 240
                            height: parent.height-10
                            verticalAlignment: TextInput.AlignVCenter
                            leftPadding: 10
                            echoMode: TextInput.Password
                            clip: true
                            font.pixelSize: 16
                            font.family: "Source Han Sans CN"
                            color: "black"
                            anchors.centerIn: parent
                            visible:textedit
                            focus: true  // 默认聚焦到这个 TextField
                        }
                    }
                }
                Row{
                    width: parent.width
                    height: 30
                    Text {
                        id: errormsg
                        width: 50
                        height: parent.height
                        text: qsTr("提醒：")
                        color: "red"
                        visible: false
                    }
                }
            }
        }
    }
    Rectangle{
        width: parent.width
        height: 70
        anchors.bottom: parent.bottom
        color: "white"
        //color: "blue" // 调试颜色
        Rectangle{
            width: parent.width-120
            height: 30
            anchors.centerIn: parent

            Button{
                width: 70
                height:parent.height
                contentItem: Text{
                    text: qsTr("确定")
                    color: "white"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.left: parent.left
                background: Rectangle{
                    anchors.fill: parent
                    color: "#2E8DED"
                    border.color: "#dedede"
                    border.width: 1
                }

                onClicked: {
                    var passwordText = password.text;
                    if(passwordText == ""){
                        errormsg.text="提醒：请输入验证密码";
                        errormsg.visible=true;
                    }else{
                        //如果是首次验证，把密码写入到配置文件中
                        if(pwdcheck_window.isfirstcheck){
                            //errormsg.text="提醒：isfirstcheck";
                            computerService.SaveCheckpwd(passwordText);
                        }
                        var flag = computerService.checkloaclpwd(passwordText);
                        if(flag){
                            errormsg.text="提醒：验证成功";
                            errormsg.visible=true;
                            ischeck_OK=true;
                            password.text=passwordText;
                            pwdcheck_window.close()//关闭窗口
                        }else{
                            errormsg.text="提醒：您输入的验证密码错误,请重新输入";
                            errormsg.visible=true;
                        }
                    }
                }
            }
            Button{
                width: 70
                height:parent.height
                text: qsTr("取消")
                anchors.right: parent.right
                background: Rectangle{
                    anchors.fill: parent
                    color: "#f9f9f9"
                    border.color: "#dedede"
                    border.width: 1
                }

                onClicked:{
                    //未输入过密码的，可以直接关闭窗口登录，如果输入密码就必须校验--#20240046BUG优化项
                    var pwdck = computerService.checkloaclpwd("");
                    if(pwdck===true) ischeck_OK=true;
                    pwdcheck_window.close()//关闭自己的窗口--如果不关闭自己，关闭主窗口是无效的操作
                    if (!ischeck_OK) {
                        mainWindow.close()//关闭窗口
                    }
                }
            }

        }
    }
}

