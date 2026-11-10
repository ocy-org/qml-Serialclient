import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.1

import ComputerServiceObj 1.0

Window {

    id:register_window
    width: 400
    height: 500
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 500
    maximumHeight: 500
    title: "选择部门"
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    property bool m_visible: false
    property int m_modality: Qt.ApplicationModal
    property int m_x: 0
    property int m_y: 0

    visible: m_visible
    modality: m_modality
    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.WindowCloseButtonHint

    signal sendCurrentItem(var departmentId,var departmentName)


    function setModel(){
        register_window.setTestDataA();
    }

    function getAllName(nodeId,departMap){
        var currentNode = departMap[nodeId];
        var path = currentNode.DepartmentName;

        while (currentNode.ParentDepartmentId !== undefined) {
            currentNode = departMap[currentNode.ParentDepartmentId];
            if(currentNode === undefined) break;
            path = currentNode["DepartmentName"] + "/" + path;
        }
        return path;
    }

    ComputerService{
        id:computerService
    }

    ColumnLayout {
         anchors.fill: parent

         Rectangle {
             Layout.preferredHeight: 30 // 第一部分的高度为 100
             Layout.fillWidth: true
         }

         Rectangle {
             id:tree_contain
             Layout.fillWidth: true
             Layout.fillHeight: true // 第二部分会填充剩余空间
             TreeView{
                 id: item_tree
                 height: parent.height
                 width: parent.width -60
                 anchors.left: parent.left
                 anchors.leftMargin: 30
                 Component.onCompleted: {
                     // register_window.setTestDataA();
                 }

             }
         }

         Rectangle {
             Layout.preferredHeight: 70 // 第三部分的高度为 200
             Layout.fillWidth: true
             Button{
                 width: 70
                 height:30
                 contentItem: Text{
                     text: qsTr("确定")
                     color: "white"
                     anchors.fill: parent
                     horizontalAlignment: Text.AlignHCenter
                     verticalAlignment: Text.AlignVCenter
                     // anchors.centerIn: parent
                 }

                 anchors.left: parent.left
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: 20
                 anchors.leftMargin: 90
                 background: Rectangle{
                     anchors.fill: parent
                     color: "#2E8DED"
                     border.color: "#dedede"
                     border.width: 1
                 }


                 onClicked: {
                     var map = computerService.getDeparmentMap();
                     var department = map[item_tree.departmentId];
                     var fullName = getAllName(department["DepartmentId"],map);
                     sendCurrentItem(department["DepartmentId"],"/"+fullName)
                     register_window.close()
                 }
             }
             Button{
                 width: 70
                 height:30
                 text: qsTr("取消")
                 anchors.right: parent.right
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: 20
                 anchors.rightMargin: 90
                 background: Rectangle{
                     anchors.fill: parent
                     color: "#f9f9f9"
                     border.color: "#dedede"
                     border.width: 1
                 }

                onClicked: {
                    register_window.close()
                }
             }
         }
     }


    // MyMessge{
    //     id:mess
    //     mVisible: false
    // }

    function buildTree(parentKey,departmentMap) {
        var result = [];
        for (var key in departmentMap) {
            if(key != "2" && key != "3"){
                var department = departmentMap[key];
                if (department["ParentDepartmentId"] === parentKey) {
                    var childObject = {
                        "text":department["DepartmentName"],
                        "row":department["Row"],
                        "istitle":department["isTitle"] === 1?true:false,
                        "isoption":department["isTitle"] === 0?true:false,
                        "departmentId": department["DepartmentId"],
                        "departmentName": department["DepartmentName"],
                        "subnodes": buildTree(department["DepartmentId"],departmentMap)
                    };
                    result.push(childObject)
                    // result[key] = childObject;
                }
            }
        }
        return result;
    }

    function setTestDataA(){
        var map = computerService.getDeparmentMap();
        var json = buildTree("0",map);
        item_tree.model=json
    }

}
