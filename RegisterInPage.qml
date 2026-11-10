import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import ComputerServiceObj 1.0
Item {

    id:registerContainer
    property bool m_visible: false
    property bool m_dbopenstatus: false
    property bool m_ljbtnstatus: false
    property bool m_ljstatus: false
    property bool m_tjstatus: false
    property var mnfmdlmap: {}

    Rectangle{
        anchors.fill: parent
        // color: "red"
    }

    ComputerService{
        id:computerService
    }
    //主窗口加载完成后执行的动作
    Component.onCompleted: {
        var serip=computerService.getServerIp();
        ip.text = serip;
        var tmprk=computerService.getDbreMarket();
        tmpremarktext.text=tmprk;

        assetCombo.currentIndex=0;
    }

    function updatecombo(){
        // 清空 ComboBox
        departmentCombo.model.clear();
        departmentCombo.model.append({text:"请选择"});
        var depmap = computerService.getDepartment();
        var keys = Object.keys(depmap); // 获取所有的键
        for (var i = 0; i < keys.length; i++) {
            var key = keys[i];
            var value = depmap[key];
            //console.log(key + ": " + value); // 输出键值对
            departmentCombo.model.append({text:value});
        }
        departmentCombo.currentIndex=0;

        //var mnfmdlmap=computerService.getMnfMdl();
        mnfmdlmap=computerService.getMnfMdl();
        mnfCombo.model.clear();
        mnfCombo.model.append({text:"请选择"});
        var mkeys = Object.keys(mnfmdlmap); // 获取所有的键
        for (var j = 0; j < mkeys.length; j++) {
            var mnf = mkeys[j];
            mnfCombo.model.append({text:mnf});
        }
        mnfCombo.currentIndex=0;


        mdlCombo.model.clear();
        mdlCombo.model.append({text:"请先选择品牌"});
        mdlCombo.currentIndex=0;
    }
    //
    function getmdlbymnf(){
        console.log("mnfCombo.text:" + mnfCombo.currentText); // 输出键值对
        // 清空 ComboBox
        mdlCombo.model.clear();
        if(mnfCombo.currentText==="请选择"){
            mdlCombo.model.append({text:"请先选择品牌"});
        }else{
            var mkeys = Object.keys(mnfmdlmap); // 获取所有的键
            for (var j = 0; j < mkeys.length; j++) {
                var mnf = mkeys[j];
                if(mnf===mnfCombo.currentText){
                    var list = mnfmdlmap[mnf];
                    for(var k =0;k<list.length;k++){
                        var mdl=list[k]
                        mdlCombo.model.append({text:mdl});
                        console.log(mnf + ": " + mdl); // 输出键值对
                    }
                }
            }
        }
        mdlCombo.currentIndex=0;
    }


    Grid{
        id:grid
        width: parent.width
        height: parent.height-100
        anchors.topMargin: 20
        rows:14
        columns:1
        rowSpacing: 10
        columnSpacing: 5
        anchors.top: parent.top


        Row{//显示CPUID
            id:cpumsg
            width: parent.width
            height: 30
            spacing: 10
            //
            function qml_getLocalCpuId() {
                    // 调用外部函数并获取返回值
                var cpuid = computerService.getLocalCpuId();
                console.log(cpuid);
                    return cpuid;
            }
            Label{
                //text: qsTr("如果本机曾经在数据库中登记过，可以点击")
                text: qsTr("本机CpuID:") +cpumsg.qml_getLocalCpuId()//qml_getLocalCpuId()//getLocalCpuId()
                width: 310
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.leftMargin: 40
            }
        }

        Row{//显示两个按钮：联机注册、脱机注册
            width: parent.width
            height: 30
            spacing: 10
            Rectangle{
                width: parent.width
                height: parent.height
                Button{
                    id:ljbtn
                    width: 80
                    height:parent.height
                    contentItem: Text{
                        text: qsTr("联机注册")
                        color: "#2E8DED"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    anchors.left: parent.left
                    anchors.leftMargin: 110
                    background: Rectangle{
                        anchors.fill: parent
                        color: "white"
                        border.color: "#2E8DED"
                        border.width: 1
                    }
                    onClicked: {
                        m_visible=true
                        m_ljbtnstatus=true
                        m_tjstatus=false
                    }
                }
                Button{
                    id:tjbtn
                    width: 80
                    height:parent.height
                    contentItem: Text{
                        text: qsTr("脱机注册")
                        color: "#2E8DED"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    anchors.left: ljbtn.right
                    anchors.leftMargin: 20
                    background: Rectangle{
                        anchors.fill: parent
                        color: "white"
                        border.color: "#2E8DED"
                        border.width: 1
                    }
                    onClicked: {
                        m_visible=true
                        m_ljbtnstatus=false //连接数据的按钮要隐藏
                        m_dbopenstatus=false
                        m_tjstatus = true
                    }
                }
            }
        }

        Row{//服务器IP
            visible: m_visible  // 当 m_visible 为 true 时显示，false 时隐藏
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
                text: ""
                width: 200
                height:parent.height
                //focus: true  // 默认聚焦到这个 TextField
            }

            Button{
                visible: m_ljbtnstatus  // 当 m_ljbtnstatus 为 true 时显示，false 时隐藏
                id:linktest
                width: 80
                height:parent.height
                text: qsTr("连  接")
                background: Rectangle{
                    anchors.fill: parent
                    color: "#f9f9f9"
                    border.color: "#dedede"
                    border.width: 1
                }

                onClicked:{
                    //1.测试IP对应的数据库是否能连接
                    var flag = computerService.linkTest(ip.text);
                    var dia = Qt.createComponent("MyMessge.qml")
                    var dlg = dia.createObject(registerContainer)
                    if(flag){
                        //dlg.message = "连接服务器成功!"
                    }else{
                        dlg.message = "连接服务器失败,请检查服务器IP是否正确，或者进行脱机注册!"
                        //dlg.btnType = dlg.mb_OK | dlg.mb_NO | dlg.mb_CANCEL
                        dlg.btnType = dlg.mb_OK
                        dlg.closing.connect(function ret(){
                            if(dlg.retValue === dlg.mb_YES)
                            {
                                //do something
                            }
                            /*else if(dlg.retValue === dlg.mb_NO)
                            {
                                //do something
                            }
                            else if(dlg.retValue === dlg.mb_CANCEL)
                            {
                                //do something
                            }*/

                            dlg.destroy()
                        })
                        dlg.show()
                    }

                    //2.如果连接成功，获取服务器端保存的数据到本地显示
                    if(flag){
                        m_dbopenstatus = true;
                        updatecombo();//更新下拉框
                        var map = computerService.getLastComputer();
                        if(map){
                            //2.1获取服务器端保存的数据到本地显示
                            location.text=map["Location"];
                            if(map["Department"]!==""){
                                var DepartmentIndex = departmentCombo.find(map["Department"]);
                                console.log("DepartmentIndex:" + DepartmentIndex);
                                departmentCombo.currentIndex=DepartmentIndex;
                            }
                            //指定品牌和型号下拉框的值
                            if(map["Manufacturer"]!==""){
                                var manufacturerIndex = mnfCombo.find(map["Manufacturer"]);
                                console.log("manufacturerIndex:" + manufacturerIndex);
                                mnfCombo.currentIndex=manufacturerIndex;
                                getmdlbymnf();//通过品牌，更新型号下拉框
                            }
                            if(map["Model"]!==""){
                                var ModelIndex = mdlCombo.find(map["Model"]);
                                console.log("ModelIndex:" + ModelIndex);
                                mdlCombo.currentIndex=ModelIndex;
                            }

                            manufactSn.text = map["ManufactSn"];

                            owner.text = map["Owner"];
                            tel.text = map["Tel"];
                            assetNo.text = map["AssetNo"];
                            buyDate.text = map["BuyDate"];

                            if(map["AssetStatus"]!==""){
                                var assetIndex = assetCombo.find(map["AssetStatus"]);
                                assetCombo.currentIndex = assetIndex;
                            }
                        }
                    }else{
                        m_dbopenstatus = false;
                    }
                }
            }
        }

        Row{//自动注册标识---脱机状态下显示
            visible: m_tjstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
            width: parent.width
            height: 30
            spacing: 10
            Label{
                text: qsTr("自动注册标识")
                width: 100
                height:parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id:tmpremarktext
                width: 200
                height:parent.height
            }

        }

        Row{//保存按钮--脱机状态下的按钮
            visible: m_tjstatus  // 当 m_tjstatus 为 true 时显示，false 时隐藏
            width: parent.width
            height: 30
            spacing: 10
            Rectangle{
                width: parent.width
                height: parent.height
                Button{
                    width: 200
                    height:parent.height
                    contentItem: Text{
                        text: qsTr("保 存")
                        color: "white"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    anchors.left: parent.left
                    anchors.leftMargin: 110
                    background: Rectangle{
                        anchors.fill: parent
                        color: "#2E8DED"
                        border.color: "#dedede"
                        border.width: 1
                    }

                    onClicked: {
                        computerService.saveServerIp(ip.text)
                        computerService.saveTmpRemarket(tmpremarktext.text)
                        var dia = Qt.createComponent("MyMessge.qml")
                        var dlg = dia.createObject(registerContainer)
                        dlg.message = "保存成功."
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

        Row{//使用部门--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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

            ComboBox{
                id:departmentCombo
                width: 200
                //model: ["总部"]
                model: ListModel{
                }
                height:parent.height
                background: Rectangle{
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: "#dedede"
                    border.width: 1
                }

            }
        }

        Row{//安装位置--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
        Row{//品牌--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
                id:mnfCombo
                width: 200
                model: ListModel{
                }
                height:parent.height
                background: Rectangle{
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: "#dedede"
                    border.width: 1
                }
                onActivated:{
                    getmdlbymnf()
                }
            }
        }
        Row{//型号--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
            ComboBox{
                id:mdlCombo
                width: 200
                model: ListModel{
                }
                height:parent.height
                background: Rectangle{
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: "#dedede"
                    border.width: 1
                }
            }
        }
        Row{//出厂机号--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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

        Row{//使用人--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
        Row{//联系电话--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
                // 设置验证器，限制只能输入整数---只能输入10位
                //validator: IntValidator { }
                // 使用正则表达式验证手机号码
                validator: RegExpValidator {
                    regExp: /^1[3-9]\d{9}$/  // 正则表达式，匹配 11 位手机号码
                }
            }

        }
        Row{//固定资产编号--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
        Row{//购买日期--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
        Row{//资产状态--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
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
                model: ["请选择","正常","维修","报废"]
                height:parent.height
                background: Rectangle{
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: "#dedede"
                    border.width: 1
                }

            }
        }

        Row{//提交按钮--数据库连接成功后显示
            visible: m_dbopenstatus  // 当 m_dbopenstatus 为 true 时显示，false 时隐藏
            width: parent.width
            height: 30
            spacing: 10
            Rectangle{
                width: parent.width
                height: parent.height
                Button{
                    width: 200
                    height:parent.height
                    contentItem: Text{
                        text: qsTr("提交")
                        color: "white"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    anchors.left: parent.left
                    anchors.leftMargin: 110
                    background: Rectangle{
                        anchors.fill: parent
                        color: "#2E8DED"
                        border.color: "#dedede"
                        border.width: 1
                    }

                    onClicked: {
                        var map = {}
                        map["Ip"] = ip.text
                        if(departmentCombo.currentText==="请选择")
                            map["Department"]=""
                        else
                            map["Department"] = departmentCombo.currentText
                        map["Location"] = location.text
                        if(mnfCombo.currentText==="请选择")
                            map["Manufacturer"]=""
                        else
                            map["Manufacturer"] = mnfCombo.currentText
                        //map["Model"] = model.text
                        if(mdlCombo.currentText==="请先选择品牌")
                            map["Model"]=""
                        else
                            map["Model"] = mdlCombo.currentText

                        //map["Model"] = mdlCombo.currentText
                        map["ManufactSn"] = manufactSn.text

                        map["Owner"] = owner.text
                        map["Tel"] = tel.text
                        map["BuyDate"] = buyDate.text
                        map["AssetNo"] = assetNo.text

                        if(assetCombo.currentText==="请选择")
                            map["AssetStatus"]=""
                        else
                            map["AssetStatus"] = assetCombo.currentText

                        computerService.setComputer(map)
//                            registerContainer.close()
                        var dia = Qt.createComponent("MyMessge.qml")
                        var dlg = dia.createObject(registerContainer)
                        dlg.message = "提交成功."
                        dlg.btnType = dlg.mb_OK
                        dlg.closing.connect(function ret(){
                            if(dlg.retValue === dlg.mb_YES)
                            {
                                //do something
                            }
                            dlg.destroy()
                        })
                        dlg.show()

                        //2.2把IP地址写入到配置文件
                        computerService.saveServerIp(ip.text);
                    }

                }

            }


        }
    }

    MyDialog{
        id:depTree
        m_visible: false

    }

}
