import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


ToolBar{
    id: objTopToolBar
    property alias appLogo: objLogo.source
    property alias appToolBar: objAppToolBar
    property alias appStatusBar: objAppStatusBar
    property alias appStatusBarHeight: objStatusBarPlaceHolder.height
    property bool appLeftSiderBarVisible: false
    property bool appRightSiderBarVisible: false

    property bool appPrevButtonVisible: false
    property bool appNextButtonVisible: false
    property bool appCloseButtonVisible: false

    signal leftSideBarClicked();
    signal rightSideBarClicked();

    signal prevClicked();
    signal nextClicked();
    signal closeClicked();
    signal logoClicked();

    Material.elevation: 5
    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    function resetAnimationState(){
        objLeftSideBarButton.rotation = 0;
        objRightSideBarButton.rotation = 0;
    }

    CloseButton{
        id: objCloseButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: objToolBarPlaceHolder.height
        width: objToolBarPlaceHolder.height
        visible: appCloseButtonVisible
        z: 1000
        onClicked: {
            closeClicked();
        }
        color: objAppTheme.secondary
        textColor: objAppTheme.isDark(objAppTheme.secondary)?"white":"black"
        hoverBackgroundColor: "black"
        hoverTextColor: "red"
    }

    Column{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: objCloseButton.visible?objCloseButton.left:parent.right
        Item{
            id: objStatusBarPlaceHolder
            width: parent.width
            Loader{
                id: objAppStatusBar
                anchors.fill: parent
            }
        }

        Item{
            id: objToolBarPlaceHolder
            width: parent.width
            height: parent.height - objStatusBarPlaceHolder.height
            Image{
                id: objLogo
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: QbCoreOne.scale(5)
                width: parent.height*0.80
                height: parent.height*0.80
                sourceSize.width: width*2
                sourceSize.height: height*2
                smooth: true
                mipmap: true
                fillMode: Image.Image.PreserveAspectFit
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        objTopToolBar.logoClicked();
                    }
                }
            }

            ToolButton{
                id: objLeftSideBarButton
                anchors.left: objLogo.right
                anchors.top: parent.top
                height: parent.height
                width: height
                text: QbMF3.icon("mf-menu")
                font.family: QbMF3.family
                visible: appLeftSiderBarVisible
                font.pixelSize: width*0.40
                onClicked: {
                    leftSideBarClicked();
                    if(rotation == 0){
                        rotation = 90;
                    }
                    else{
                        rotation = 0;
                    }
                }
                Behavior on rotation{
                    NumberAnimation{duration: 150}
                }
            }

            Item{
                id: objButtonPlaceHolder
                anchors.left: appLeftSiderBarVisible?objLeftSideBarButton.right:objLogo.right
                width: objPrevButton.visible?parent.height*2:parent.height
                height: parent.height
                ToolButton{
                    id: objPrevButton
                    anchors.left: parent.left
                    anchors.top: parent.top
                    height: parent.height
                    width: height
                    visible: appPrevButtonVisible
                    text: QbMF3.icon("mf-keyboard_arrow_left")
                    font.family: QbMF3.family
                    font.pixelSize: width*0.40
                    onClicked: {
                        objLeftSideBarButton.rotation = 0;
                        objRightSideBarButton.rotation = 0;
                        prevClicked();
                    }
                }
                ToolButton{
                    id: objNextButton
                    anchors.right: parent.right
                    anchors.top: parent.top
                    height: parent.height
                    width: height
                    visible: appNextButtonVisible
                    text: QbMF3.icon("mf-keyboard_arrow_right")
                    font.family: QbMF3.family
                    font.pixelSize: width*0.40
                    onClicked: {
                        objLeftSideBarButton.rotation = 0;
                        objRightSideBarButton.rotation = 0;
                        nextClicked();
                    }
                }
            }

            ToolButton{
                id: objRightSideBarButton
                anchors.right: parent.right
                anchors.top: parent.top
                height: parent.height
                width: height
                text: QbMF3.icon("mf-menu")
                font.pixelSize: width*0.40
                font.family: QbMF3.family
                visible: appRightSiderBarVisible
                onClicked: {
                    rightSideBarClicked();
                    if(rotation == 0){
                        rotation = 90;
                    }
                    else{
                        rotation = 0;
                    }
                }
                Behavior on rotation{
                    NumberAnimation{duration: 150}
                }
            }
            Loader{
                id: objAppToolBar
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: objButtonPlaceHolder.right
                anchors.right: objRightSideBarButton.visible?objRightSideBarButton.left:parent.right
            }
        }
    }
}
