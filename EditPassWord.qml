import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import ComputerServiceObj 1.0
Window {

    id:edit_window
    width: 400
    height: 250
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 250
    maximumHeight: 250
    title: "修改密码"
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
            width: parent.width-200
            height: parent.height-80
            anchors.centerIn: parent
            Grid{
                anchors.fill: parent
                rows: 3
                columns: 1
                rowSpacing: 10
                Row{
                    width: parent.width
                    height: 30
                    Text {
                        width: 50
                        height: parent.height
                        text: qsTr("用户名")
                    }
                    Rectangle{
                        width: 150
                        height: parent.height
                        border.color: "#d2d2d2"
                        border.width: 1
                        TextInput{
                            id:userName
                            width: 140
                            height: parent.height-10
                            verticalAlignment: TextInput.AlignVCenter
                            leftPadding: 10
                            clip: true
                            font.pixelSize: 16
                            font.family: "Source Han Sans CN"
                            anchors.centerIn: parent
                            selectByMouse: true
                        }
                    }
                }
                Row{
                    width: parent.width
                    height: 30
                    Text {
                        width: 50
                        height: parent.height
                        text: qsTr("原密码")
                    }
                    Rectangle{
                        width: 150
                        height: parent.height
                        border.color: "#d2d2d2"
                        border.width: 1
                        TextInput{
                            id:oldPassword
                            width: 140
                            height: parent.height-10
                            verticalAlignment: TextInput.AlignVCenter
                            leftPadding: 10
                            echoMode: TextInput.Password
                            clip: true
                            font.pixelSize: 16
                            font.family: "Source Han Sans CN"
                            color: "black"
                            anchors.centerIn: parent
                        }
                    }

                }
                Row{
                    width: parent.width
                    height: 30
                    Text {
                        width: 50
                        height: parent.height
                        text: qsTr("新密码")
                    }
                    Rectangle{
                        width: 150
                        height: parent.height
                        border.color: "#d2d2d2"
                        border.width: 1
                        TextInput{
                            id:newPassword
                            width: 140
                            height: parent.height-10
                            verticalAlignment: TextInput.AlignVCenter
                            leftPadding: 10
                            echoMode: TextInput.Password
                            clip: true
                            font.pixelSize: 16
                            font.family: "Source Han Sans CN"
                            color: "black"
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        width: parent.width
        height: 50
        anchors.bottom: parent.bottom
        color: "white"
        Rectangle{
            width: parent.width-220
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
                    var flag = computerService.editPassword(userName.text,oldPassword.text,newPassword.text);
                    if(flag){
                        edit_window.close()
                    }else{
                        console.log(111)
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
                    edit_window.close()
                }
            }

        }
    }
}
