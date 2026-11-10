import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import ComputerServiceObj 1.0
Window {
    id:port_window
    width: 500
    height: 600
    minimumWidth: 500
    maximumWidth: 500
    minimumHeight: 600
    maximumHeight: 600
    title: "选择外设命令"
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    property bool m_visible: false
    property int m_modality: Qt.application
    visible: m_visible
    modality: Qt.NonModal
    flags: Qt.Window | Qt.WindowSystemMenuHint | Qt.WindowCloseButtonHint

    Rectangle{
        width: parent.width
        height: 1
        border.color: "gray"
        border.width: 1
    }
    Rectangle{
        width: parent.width-50
        height: parent.height
        anchors.centerIn: parent
        


        ScrollView {

            width: parent.width-20
            height: parent.height-20
            background: Rectangle {
                anchors.fill: parent
                border.color: "gray"
                border.width: 1
                radius: 5
            }

            TextArea {
                id: commandText
                wrapMode: TextArea.WrapAnywhere
                font.pixelSize: 15
                selectByMouse: true
                readOnly: true
                text: "==注意，鼠标选择指定区域后，ctl+c可进行复制===
磁卡机控制命令
  1.写命令（第二道〕
         ESC  t   要写的数据  GS  ESC  \\
         1B   74  要写的数据  1D  1B   5C
  2.写命令（第三道）
         ESC  t   A   要写的数据  GS  ESC  \\
         1B   74  41  要写的数据  1D   1B  5C
  3.写命令（双道）
         ESC  t  二道的数据  A  三道的数据  GS   ESC   \\
         1B  74  二道的数据  41 三道的数据  1D    1B    5C
  4.读命令（第二道）
         ESC  ] （1B  5D）
     拉卡正确，回送  ESC  s  磁条上的数据   ？ FS
                     1B   73 磁条上的数据   3F 1C
  5.读命令（第三道）
         ESC  T  ] （1B  54  5D）
     拉卡正确，回送  ESC  s  A   磁条上的数据  ？ FS
                     1B  73  41  磁条上的数据 3F  1C
  6.读命令（双道）
         ESC  B  ] （1B  42  5D）
     拉卡正确，回送
         ESC  s  二道的数据  A  三道的数据  ？ FS
         1B  73  二道的数据  41  三道的数据 3F  1C
     注：磁条数据：读成功为磁条上的数据
                   读失败为DEL（7F）
  7. 软复位命令                ESC 0（1B 30）
  8. 读写操作状态回送命令     ESC  j （1B 6A）
     第二道读写数据返回码     ESC  r     p/q/r（1B 72 70/71/72）
     第三道读写数据返回码     ESC  T  r  p/q/r（1B 54 72 70/71/72）
       双道读写数据返回码     ESC  B  r  p/q/r（1B 42 72 70/71/72）
     注：返回状态码的最后一位p表示成功，q表示失败，r表示无读写操作。


--------------------------------------------------------------------
密码键盘控制命令：
     ESC   I  （1B   49）
     操作步骤：灯亮
     输入密码后按“确认”
     数据回送主机

     ESC   E  （1B   45）
     操作步骤：灯闪
     输入密码后按“确认”
     数据回送主机

     ESC  F  ESC  I  （1B 46 1B 49）
    操作步骤：灯亮
    输入密码后按“确认”
    等待ESC G取数据


     ESC  F  ESC  E  （1B 46 1B 45）
    操作步骤：灯闪
    输入密码后按“确认”
    等待ESC G取数据

     ESC  G （1B 47） 将缓存的输入数据回送主机
     ESC  M （1B 4D） 键入数据实时回送主机
     ESC  R （ 1B 52 ）退出键盘口，选通A口

  ★注：1.当使用ESC F ESC I/E 命令时，在ESC G 取数命令前不允许退出键盘口。
         2.使用ESC I/E 命令后，用户键入的数据以如下格式返回：
               STX键入的数据 ETX     （02H键入的数据03H）
         3.使用ESC M 命令后，用户键入的数据实时返回，“清除”键值为08H
          “确认”键值为0DH。只有退出键盘口，才能取消ESC M 命令所设定的状态。

  10. 选择扩展接口命令
        对于带扩展接口的各型产品，在开机或硬件复位自检后自动选通PORT－A口，

ESC ％ A （1B 25 41） 选通PORT－A口，断开其它扩展口
ESC ％ B （1B 25 42） 选通PORT－B口，断开其它扩展口
ESC ％ C （1B 25 43） 选通PORT－C口，断开其它扩展口
ESC ％ K （1B 25 4B） 选通PORT－K口，断开其它扩展口

"
            }
        }
    }
}
