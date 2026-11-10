//这个文件是多余的，删掉保存，暂时保留
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import ComputerServiceObj 1.0
Window {

    id:register_window
    width: 500
    height: 600
    minimumWidth: 500
    maximumWidth: 500
    minimumHeight: 600
    maximumHeight: 600
    title: "注册到服务器"
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    property bool m_visible: false
    property int m_modality: Qt.ApplicationModal


    visible: m_visible
    modality: m_modality
    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.WindowCloseButtonHint

    // 定义窗口可见性变化时触发的函数
    onVisibleChanged: {
        if (visible) {
            // 在窗口显示时执行的操作
            var ipText =  computerService.getConfigIp();
            ip.text = ipText;
        }
    }

    ComputerService{
        id:computerService
    }

    Grid{
        id:grid
        width: parent.width
        height: parent.height-100
        anchors.topMargin: 20
        rows:13
        columns:1
        rowSpacing: 10
        columnSpacing: 5
        anchors.top: parent.top

        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("服务器IP")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:ip
                width: 200
                height:parent.height
            }

            Button{
                width: 80
                height:parent.height
                text: qsTr("连接测试")
                background: Rectangle{
                    anchors.fill: parent
                    color: "#f9f9f9"
                    border.color: "#dedede"
                    border.width: 1
                }

                onClicked:{
                    var flag = computerService.linkTest(ip.text);
                    var dia = Qt.createComponent("MyMessge.qml")
                    var dlg = dia.createObject(register_window)
                    if(flag){
                        dlg.message = "success!"
                    }else{
                        dlg.message = "failed!"
                    }
                    dlg.btnType = dlg.mb_OK | dlg.mb_NO | dlg.mb_CANCEL
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
        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("如果本机曾经在数据库中登记过，可以点击")
                width: 310
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }


            Button{
                // width: 80
                height:parent.height
                text: qsTr("从数据库中读取本机资料")
                background: Rectangle{
                    anchors.fill: parent
                    color: "#f9f9f9"
                    border.color: "#dedede"
                    border.width: 1
                }

                onClicked: {
                    var map = computerService.getLastComputer();
                    if(map){
                        location.text=map["Location"];
                        post.text=map["Duty"];
                        var manufacturerIndex = manufacturerCombo.find(map["Manufacturer"]);
                        manufacturerCombo.currentIndex=manufacturerIndex;
                        model.text = map["Model"];
                        manufactSn.text = map["ManufactSn"];
                        department.text = map["DepartmentName"];
                        department.departmentId =  map["Department"];
                        owner.text = map["Owner"];
                        tel.text = map["Tel"];
                        assetNo.text = map["AssetNo"];
                        buyDate.text = map["BuyDate"];
                        var assetIndex = assetCombo.find(map["AssetStatus"]);
                        assetCombo.currentIndex = assetIndex;
                    }
                }
            }
        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("安装位置")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:location
                width: 200
                height:parent.height
            }

        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("岗位")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:post
                width: 200
                height:parent.height
            }

        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("品牌")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }


            ComboBox{
                id:manufacturerCombo
                width: 200
                model: ["升腾","实达","长城","国光","联想","戴尔","普惠","华硕","组装机","其他品牌"]
                height:parent.height
                background: Rectangle{
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: "#dedede"
                    border.width: 1
                }

            }


        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("型号")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:model
                width: 200
                height:parent.height
            }


        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("出厂机号")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:manufactSn
                width: 200
                height:parent.height
            }


        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("使用部门")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:department
                enabled: false
                width: 200
                height:parent.height
                property string departmentId: ""
                Connections{
                    target: depTree
                    onSendCurrentItem:{
                        // mess.mVisible=true
                        // mess.text=departmentName
                        department.text=departmentName
                        department.departmentId= departmentId
                    }
                }
            }

            Button{
                // width: 80
                height:parent.height
                text: qsTr("从服务器中获取部门列表")
                background: Rectangle{
                    anchors.fill: parent
                    color: "#f9f9f9"
                    border.color: "#dedede"
                    border.width: 1
                }

                onClicked:{
                    depTree.show()
                    depTree.m_visible=true
                    depTree.setModel();
                }
            }
        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("使用人")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:owner
                width: 200
                height:parent.height
            }

        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("联系电话")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:tel
                width: 200
                height:parent.height
            }

        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("固定资产编号")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:assetNo
                width: 200
                height:parent.height
            }

        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("购买日期")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:buyDate
                width: 200
                height:parent.height
                MouseArea {
                    anchors.fill: parent
                    onClicked: calendarPop.open()
                }
            }
            Popup {
                id: calendarPop
                y: -200 // 设置在上方弹出
                x:110
                width: 200
                height: 200
                contentItem: Rectangle {
                    anchors.fill: parent
                    MyCalender{
                        id:calender
                        anchors.fill: parent
                    }
                }

            }
            Connections{
                target: calender
                onDateChanged:{
                    buyDate.text=dateStr
                    calendarPop.close()
                }
            }

        }
        Row{
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("资产状态")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            ComboBox{
                id:assetCombo
                width: 200
                model: ["正常","维修","报废"]
                height:parent.height
                background: Rectangle{
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: "#dedede"
                    border.width: 1
                }

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
                    var map = {}
                    map["Ip"] = ip.text
                    map["Location"] = location.text
                    map["Duty"] = post.text
                    map["Manufacturer"] = manufacturerCombo.currentText
                    map["Model"] = model.text
                    map["ManufactSn"] = manufactSn.text
                    map["Department"] = department.departmentId
                    map["Owner"] = owner.text
                    map["Tel"] = tel.text
                    map["BuyDate"] = buyDate.text
                    map["AssetNo"] = assetNo.text
                    map["AssetStatus"] = assetCombo.currentText
                    if(department.departmentId == ""){
                        var dia = Qt.createComponent("MyMessge.qml")
                        var dlg = dia.createObject(register_window)
                        dlg.message = "failed!"
                        dlg.btnType = dlg.mb_OK | dlg.mb_NO | dlg.mb_CANCEL
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
                    }else{
                        computerService.setComputer(map)
                        register_window.close()
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
                    register_window.close()
                }
            }

        }
    }

    MyDialog{
        id:depTree
        m_visible: false

    }



    // MyMessge{
    //     id:mess
    //     mVisible: false
    // }

}
