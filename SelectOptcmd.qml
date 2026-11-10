import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import ComputerServiceObj 1.0
Window {
    id:devoptcmd_window
    width: 400
    height: 440
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 400
    maximumHeight: 440
    title: "选择外设命令"
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    property bool m_visible: false
    property int m_modality: Qt.ApplicationModal
    property int portType: 0
    property string selecttext: ""
    property var cmdtypemap:{"": ""}
    // property var cmdtypemap: {
    //     "磁卡读二道": "<1B>]",
    //     "磁卡读三道": "<1B>T]",
    //     "磁卡读二三道": "<1B>B]",
    //     "磁卡机复位": "<1B>0"}

    visible: m_visible
    modality: m_modality
    flags: Qt.Window  | Qt.WindowCloseButtonHint

    ComputerService{
        id:computerService
    }
    signal sendOptcmd(string optcmdstr);

    Component.onCompleted: {

        var map =computerService.getdevoptcmd();//从配置文件中获取命令列表
        for (var key in map) {
            console.log(key + ": " + map[key]); // 输出键和值
            listRouteModel.insert(0,{path:key})
            cmdtypemap[key]=map[key]
        }
    }


    Rectangle {
        id: listRect
        //anchors.fill: parent
        width: parent.width
        height:parent.height-60
        //color:"red"
        Rectangle{
            width: parent.width
            height: 1
            color: "gray"
            anchors.top:parent.top
        }

        //菜单
        ListModel {
            id: listRouteModel
        }

        ListView {
            id: listRouteView
            width: 250
            height: parent.height-20
            anchors.centerIn: parent
            orientation: ListView.Vertical//垂直列表
            interactive: true;//元素可拖动
            clip: true //
            ScrollBar.vertical: ScrollBar {
                id: scrollBar
                onActiveChanged: {
                    active = true;
                }
                Component.onCompleted: {
//                    scrollBar.handle.color = "yellow"
//                    scrollBar.active = true;
//                    scrollBar.handle.width = 10;
                    //console.log("Component.onCompleted========================")
                }
            }

            model: listRouteModel;
            focus: true
            delegate: tabDelegate

        }
        //Component
        Component {
            id: tabDelegate
            Rectangle {
                width: 400; height: 30;
                color: (listRouteView.currentIndex === index) ? "#2E8DED": "transparent"
                border.color: "black"//"#f2f2f2"
                border.width: 1
                //标题
                Text {
                    width: parent.width - 3; height: 25;
                    anchors.left: parent.left;
                    anchors.leftMargin: 0;
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    font.pixelSize: 16;
                    color: (listRouteView.currentIndex === index) ? "white" : "black"
                    text: path
                    horizontalAlignment: Text.AlignLeft; //文字水平居中对齐
                    verticalAlignment: Text.AlignLeft;//文字垂直居中对齐
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listRouteView.currentIndex = index
                        selecttext =listRouteView.model.get(index).path;
                    }
                    onDoubleClicked: {
                        listRouteView.currentIndex = index
                        var text =listRouteView.model.get(index).path;
                        var cmdstr = cmdtypemap[text];
                        devoptcmd_window.sendOptcmd(cmdstr);
                        devoptcmd_window.close()
                    }
                }
            }
        }//end Component


    }
    Rectangle {
        width: parent.width
        height:60
        anchors.top: listRect.bottom
        //color:"blue"
        Button{
            width: 100
            height:30
            contentItem: Text{
                text: qsTr("确定")
                color: "white"
                //anchors.top: listRouteView.Bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.top: parent.top
            //anchors.topMargin: 10
            anchors.centerIn: parent
            background: Rectangle{
                anchors.fill: parent
                color: "#2E8DED"
                border.color: "#dedede"
                border.width: 1
                radius: 5
            }
            onClicked: {
                var cmdstr = cmdtypemap[selecttext];
                devoptcmd_window.sendOptcmd(cmdstr);
                devoptcmd_window.close()
            }
        }
    }
}
