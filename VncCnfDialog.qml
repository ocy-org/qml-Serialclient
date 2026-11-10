//从文件作废
import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import VncMshServiceObj 1.0
Window {

    id:vnc_window
    width: 500
    height: 450
    minimumWidth: 500
    maximumWidth: 500
    minimumHeight: 450
    maximumHeight: 450
    title: "远程监控配置"
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    property bool m_visible: false
    property int m_modality: Qt.ApplicationModal


    visible: m_visible
    modality: m_modality
    flags: Qt.Window  | Qt.WindowCloseButtonHint

    VncMshService{
        id:vncMsgService
    }

    onVisibleChanged: {
        if (visible) {

            var map = vncMsgService.getVncMsg();

            // console.log("Allow:"+map["Allow"]);
            // console.log("Assitant:"+map["Assitant"]);
            // console.log("Assign:"+map["Assign"])s;
            // console.log("AssignIp:"+map["AssignIp"]);


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
                assignCheck.checked = true;
                assignIp.text = map["AssignIp"];
            }

        }
    }
    Rectangle{
        width: parent.width
        height: 1
        anchors.top: parent.top
        color:"#d2d2d2"
    }


    Grid{
        id:grid
        width: parent.width-50
        height: parent.height-60
        rows:3
        columns:1
        rowSpacing: 10
        columnSpacing: 5
        anchors.centerIn: parent

        Row{

            width: parent.width
            height: 30
            spacing: 10

            Label{
                text: qsTr("监控权限设置")
                width: 50
                height:parent.height

                // anchors.left: parent.left
                // anchors.leftMargin: 20
                // verticalAlignment: Text.AlignVCenter
                // horizontalAlignment: Text.AlignRight
            }
        }


        Row{
            width: parent.width
            height: 250
            spacing: 10
            Rectangle{
                width: parent.width
                height: parent.height
                border.color: "#d2d2d2"
                border.width: 1

                ButtonGroup {
                    id: allowGroup
                }
                ButtonGroup {
                    id: assignGroup
                }
                Rectangle{
                    width: parent.width-60
                    height: parent.height/2-20
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    Grid{
                        id:contentGrid
                        width: parent.width
                        height: parent.height
                        rows:4
                        columns:1
                        columnSpacing: 5
                        anchors.centerIn: parent

                        Row{
                            width: parent.width
                            height:parent.height/4
                            Label{
                                text: qsTr("监控允许：")
                            }
                        }

                        Row{
                            width: parent.width
                            height:parent.height/4
                            RadioButton {
                                id:forbid
                                // width: 100
                                // height: 30
                                text: "禁止监控我"
                                indicator.width: 20
                                indicator.height: 20
                                Component.onCompleted:allowGroup.addButton(this)
                                onClicked: {
                                    assginContainer.visible = false;
                                }
                            }
                        }
                        Row{
                            width: parent.width
                            height:parent.height/4
                            RadioButton {
                                id:ask
                                text: "监控我之前，需要询问我是否同意"
                                indicator.width: 20
                                indicator.height: 20
                                Component.onCompleted:allowGroup.addButton(this)
                                onClicked: {
                                    assginContainer.visible = true;
                                }
                            }
                        }
                        Row{
                            width: parent.width
                            height:parent.height/4
                            RadioButton {
                                id:allow
                                indicator.width: 20
                                indicator.height: 20
                                text: "监控我时，不需要我同意"
                                Component.onCompleted:allowGroup.addButton(this)
                                onClicked: {
                                    assginContainer.visible = true;
                                }
                            }
                        }
                    }

                }
                Rectangle{
                    id:assginContainer
                    width: parent.width-60
                    height: parent.height/2-20
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    visible: false

                    Grid{
                        id:assignGrid
                        width: parent.width
                        height: parent.height
                        rows:3
                        columns:1
                        columnSpacing: 5
                        anchors.centerIn: parent

                        Row{
                            width: parent.width
                            height:parent.height/4
                            Label{
                                text: qsTr("协助模式")
                            }
                        }

                        Row{
                            width: parent.width
                            height:parent.height/4
                            RadioButton {
                                id:read
                                indicator.width: 20
                                indicator.height: 20
                                text: "管理员只允许查看我的屏幕，不允许操作我的电脑"
                                Component.onCompleted:assignGroup.addButton(this)
                            }
                        }
                        Row{
                            width: parent.width
                            height:parent.height/4
                            RadioButton {
                                id:option
                                indicator.width: 20
                                indicator.height: 20
                                text: "管理员可以跟我共同操作"
                                Component.onCompleted:assignGroup.addButton(this)
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


            CheckBox {
                id:assignCheck

                text: "只允许指定IP对我进行实时监控"
                // 可以在这里添加复选框的其他属性和信号处理程序
                onClicked: {
                    if(assignCheck.checked){
                        //assignIp.enabled=true
                    }else{
                        //assignIp.enabled=false
                    }


                }
            }
            TextField {
                id:assignIp
                width: 180
                height:parent.height
                enabled: false
            }
        }


    }

    Rectangle{
        width: parent.width
        height: 60
        anchors.bottom: parent.bottom
        Rectangle{
            width: 200
            height:30
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

                    vnc_window.close()
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
                    vnc_window.close()
                }
            }
        }
    }

}
