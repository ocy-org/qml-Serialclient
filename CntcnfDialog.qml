import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import ComputerServiceObj 1.0
Window {

    id:cnt_window
    width: 400
    height: 250
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 250
    maximumHeight: 250
    title: "通讯端口配置"
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    property bool m_visible: false
    property int m_modality: Qt.ApplicationModal


    visible: m_visible
    modality: m_modality
    flags: Qt.Window  | Qt.WindowCloseButtonHint

    ComputerService{
        id:computerService
    }

    onVisibleChanged: {
        if (visible) {
            var map = computerService.getCntCnf();
            ftpPort.text = map["FTP_PORT"];
            tepPort.text = map["TEP_PORT"];
            receivePort.text = map["RECEIVE_PORT"];
            udpPort.text = map["UDP_PORT"];
            console.log("getCntCnf",ftpPort.text,tepPort.text,receivePort.text,udpPort.text)
        }
    }

    Grid{
        id:grid
        width: parent.width
        height: parent.height-60
        anchors.topMargin: 20
        rows:4
        columns:1
        rowSpacing: 10
        columnSpacing: 5
        anchors.top: parent.top

        Row{
            width: parent.width
            height: 30
            spacing: 10

            Label{
                text: qsTr("YmoreFtp端口(tcp)")
                width: 180
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:ftpPort
                width: 180
                height:parent.height
            }
        }


        Row{
            width: parent.width
            height: 30
            spacing: 10

            Label{
                text: qsTr("Ymore终端实时控制端口(tep)")
                width: 180
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:tepPort
                width: 180
                height:parent.height
            }
        }

        Row{
            width: parent.width
            height: 30
            spacing: 10

            Label{
                text: qsTr("消息接收端口(tcp)")
                width: 180
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:receivePort
                width: 180
                height:parent.height
            }
        }

        Row{
            width: parent.width
            height: 30
            spacing: 10

            Label{
                text: qsTr("Ymore终端实时控制端口(udp)")
                width: 180
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:udpPort
                width: 180
                height:parent.height
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
                    var ftp = ftpPort.text
                    var tep = tepPort.text
                    var receive = receivePort.text
                    var udp = udpPort.text

                    computerService.savePort(ftp,tep,receive,udp);
                    cnt_window.close()
                    // if(department.departmentId == ""){
                    //     var dia = Qt.createComponent("MyMessge.qml")
                    //     var dlg = dia.createObject(cnt_window)
                    //     dlg.message = "failed!"
                    //     dlg.btnType = dlg.mb_OK | dlg.mb_NO | dlg.mb_CANCEL
                    //     dlg.closing.connect(function ret(){
                    //         if(dlg.retValue === dlg.mb_YES)
                    //         {
                    //         }
                    //         else if(dlg.retValue === dlg.mb_NO)
                    //         {
                    //         }
                    //         else if(dlg.retValue === dlg.mb_CANCEL)
                    //         {
                    //         }

                    //         dlg.destroy()
                    //     })
                    //     dlg.show()
                    // }else{
                    //     cnt_window.close()
                    // }
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
                    cnt_window.close()
                }
            }
        }
    }

}
