import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import ComputerServiceObj 1.0
Item{
    z:1;
    height: 30;
    property bool  isMaximized: false;
    property string version:"";
    ComputerService{
        id:computerService
    }
    //主窗口加载完成后执行的动作
    Component.onCompleted: {
        var baseconfmap = computerService.getbaseconf();
        version = baseconfmap["VERSION"];
        console.log(version)
    }
    //
    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton //只处理鼠标左键
        property bool   isDoubleClicked:false
        property point clickPos: "0,0"
         onPressed:
         {
             isDoubleClicked = false;
             clickPos = Qt.point(mouse.x,mouse.y)
         }
         onPositionChanged: {
             if(!isDoubleClicked && pressed && mainWindow.visibility !== Window.Maximized && mainWindow.visibility !== Window.FullScreen) {
                 var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                 mainWindow.x += delta.x
                 mainWindow.y += delta.y
             }
             if(mainWindow.visibility === Window.Maximized && pressed && !isDoubleClicked)
             {
                 isMaximized = false;
                 mainWindow.showNormal();
                 normBtn.maxImg="qrc:/img/max_two.png";
                 normBtn.maxImg_pressed="qrc:/img/max_two.png";
                 normBtn.maxImg_hover="qrc:/img/max_two.png";
             }
         }
         onDoubleClicked :
         {
             // isDoubleClicked = true; // 这个时候一定不能响应onPositionChanged不然会一直置顶。
             // if(isMaximized){
             //     isMaximized = false;
             //     mainWindow.showNormal();
             //     normBtn.maxImg="qrc:/img/max_two.png";
             //     normBtn.maxImg_pressed="qrc:/img/max_two.png";
             //     normBtn.maxImg_hover="qrc:/img/max_two.png";
             // }else{
             //     isMaximized = true;
             //     mainWindow.showMaximized();
             //     normBtn.maxImg="qrc:/img/max_two.png";
             //     normBtn.maxImg_pressed="qrc/img/max_two.png";
             //     normBtn.maxImg_hover="qrc:/img/max_two.png";
             // }
         }
     }

    Rectangle{
        width:270
        height: 30
        color: "white"
        Rectangle{
            width: 100
            height: parent.height
            color: "#02a7f0"
        }
    }
    //窗口关闭按钮
    Button{
        id:closeBtn
        anchors{right: parent.right; top: parent.top;leftMargin: 10}
        width: 30; height:30;
        hoverEnabled : true;

        background: Rectangle{
            color: closeBtn.hovered ? "#f2f2f2" :Qt.rgba(0,0,0,0);
            Image {
                width: 20
                height: 20
                anchors.centerIn: parent
                source: closeBtn.hovered ? (closeBtn.pressed ? "qrc:/img/close.png" :
                       "qrc:/img/close.png") : "qrc:/img/close.png";
            }
        }

        onClicked: {
            mainWindow.close()
        }
    }
    //窗口缩小按钮
    Button{
         id: minBtn
         anchors{right: closeBtn.left; top: parent.top;}
         width: 30; height:30;
         hoverEnabled : true
         background: Rectangle{
             color: minBtn.hovered ? "#f2f2f2" :Qt.rgba(0,0,0,0);
             Image{
                 width: 20
                 height: 20
                 anchors.centerIn: parent
                 source: minBtn.hovered ? (minBtn.pressed ? "qrc:/img/min.png" :
                         "qrc:/img/min.png") : "qrc:/img/min.png";
             }
         }
         onClicked:{
             mainWindow.showMinimized();
         }
     }

    //自定义按钮-用户登录、修改密码
    Button{
          id: userBtn;

          anchors{right: minBtn.left; top: parent.top;leftMargin: 10 }
          width: 30; height:30;
          hoverEnabled : true
          background: Rectangle{
              color: userBtn.hovered ? "#f2f2f2" :Qt.rgba(0,0,0,0);
              Image {
                  id:userBtnBg;
                  width: 20
                  height: 20
                  anchors.centerIn: parent
                  source: "qrc:/img/user.png";
              }
          }
          onClicked:{
              //userMenu.open() //--暂不开放菜单功能
              pwdcheck.visible = true
              //校验配置文件中，验证密码是不是空，如果是空说明是首次验证
              var pwdck = computerService.checkloaclpwd("");
              //console.log("pwdck:",pwdck);
              if(pwdck===true){
                errormsg.text="提醒：当前为首次登录，请输入需要保存的验证密码";
                errormsg.visible = true;
                pwdcheck_window.isfirstcheck = true;
              }else{
                //pwdcheck.textedit=false;
              }
          }

        Menu{
              id:userMenu
              width: 90
              height: 100
              x:userBtn.width
              y:userBtn.height

              MenuBarItem{
                  id:loginItem
                  width: parent.width
                  height: 50
                  text: "用户登录"
                  hoverEnabled: true
                  Rectangle{
                      anchors.fill: parent
                      color: loginItem.hovered? "#f2f2f2" : "white"
                  }
                  onClicked: {
                      loginDialog.visible = true
                      console.log(2123)
                  }
              }
              MenuBarItem{
                  id:editItem
                  width: parent.width
                  height:50
                  text: "修改密码"
                  hoverEnabled: true
                  Rectangle{
                      anchors.fill: parent
                      color: editItem.hovered? "#f2f2f2" : "white"
                  }
                  onClicked: {
                      edit.visible = true
                  }
              }
              MenuBarItem{
                  id:pwdck
                  width: parent.width
                  height:50
                  text: "密码验证"
                  hoverEnabled: true
                  Rectangle{
                      anchors.fill: parent
                      color: pwdck.hovered? "#f2f2f2" : "white"
                  }
                  onClicked: {
                      pwdcheck.visible = true
                  }
              }

          }
    }

    //窗口版本信息
    Button{
         id: helpBtn
         anchors{right: userBtn.left; top: parent.top;}
         width: 30; height:30;
         hoverEnabled : true
         background: Rectangle{
             color: helpBtn.hovered ? "#f2f2f2" :Qt.rgba(0,0,0,0);
             Image{
                 width: 26
                 height: 26
                 anchors.centerIn: parent
                 source: "qrc:/img/help.png";
            }
        }
        onClicked:{
            var dia = Qt.createComponent("MyMessge.qml")
            var dlg = dia.createObject(computerService)
            dlg.message = "当前版本"+version
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
      //用户登录窗口
      LoginDialog{
          id:loginDialog
          visible: false
      }
      //修改密码窗口
      EditPassWord{
          id:edit
          visible: false
      }
      //密码验证窗口
      PwdCheck{
          id:pwdcheck
          visible: false
      }

}
