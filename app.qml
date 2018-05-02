import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0
import "app.js" as App
import "appc.js" as Appc

QbApp {
    id: objAppUi
    minimumHeight: 400
    minimumWidth: 450
    property string gridState: "xs"
    property int leftSideBarWidth: 0
    property int rightSideBarWidth: 0

    onWidthChanged: {
        appResized();
    }

    onAppClosing: {
    }

    Keys.forwardTo: [objShortcut,objContentPlaceHolder]

    Item{
        id: objShortcut
        Shortcut {
            sequence: "Shift+H"
            enabled: true
            onActivated: {
                if(objLeftDock.isOpened){
                    objLeftDock.close();
                }
                else{
                    objLeftDock.open();
                }
            }
        }
    }

    Component.onCompleted: {
        App.objAppTheme = objAppTheme;
        App.objPackageReader = objPackageReader;

        App.objTopToolBar = objTopToolBar;
        App.appToolBarLoader = objTopToolBar.appToolBar;
        App.appStatusBarLoader = objTopToolBar.appStatusBar;

        App.objMainView = objMainView;

        App.objBottomToolBar = objBottomToolBar;
        App.appBottomBarLoader = objBottomToolBar.appBottomBar;

        App.objLeftSideBar = objLeftSideBar;
        App.objRightSideBar = objRightSideBar;

        App.appLeftSideBarLoader = objLeftSideBar.appSideBar;
        App.appRightSideBarLoader = objRightSideBar.appSideBar;

        App.objLeftDock = objLeftDock;

        App.setup(objAppUi);
        Appc.setup();
    }

    QbMetaTheme{
        id: objAppTheme
    }

    QbAppPackageReader{
        id: objPackageReader
    }

    Rectangle{
        id: objLeftDock
        width: QbCoreOne.scale(50)
        height: parent.height
        color: objAppTheme.changeTransparency("#000",200)
        x:-objLeftDock.width
        y:0
        visible: false
        z: -10000000
        focus: false
        property bool isOpened: false
        Behavior on x{
            NumberAnimation{
                duration: 100
                easing.type: Easing.InOutQuad
                onRunningChanged: {
                    if(objLeftDock.x !== 0){
                        if(!running){
                            objLeftDock.z = -100000;
                            objLeftDock.visible = false;
                        }
                    }
                }
            }
        }

        function open(){
            objLeftDock.visible = true;
            objLeftDock.z = 10000000;
            isOpened = true;
            objLeftDock.x = 0
        }

        function close(){
            isOpened = false;
            objLeftDock.x = - objLeftDock.width;
        }

        function addIcon(data){
            objLeftDockModel.append(data);
        }

        function insertIcon(index,data){
            objLeftDockModel.insert(index,data);
        }

        function removeIcon(index){
            try{
                objLeftDockModel.remove(index);
            }
            catch(e){};
        }

        function clearAllIcons(){
            objLeftDockModel.clear();
        }

        Component{
            id: compMenuItem
            MenuItem{
                property int index: 0
                highlighted: false
                onTriggered: {
                    objMainView.currentIndex = index;
                    objLeftDock.close();
                }
            }
        }

        function addRunningPage(title){
            var index = objRunningPageList.count;
            var item = compMenuItem.createObject(listButton,{"text":title,"index":index});
            objRunningPageList.insertItem(index,item);
        }

        function removeRunningPage(index){
            var mi = objRunningPageList.itemAt(index);
            objRunningPageList.removeItem(mi);
            //update indexes of all items
            for(var i = 0;i<objRunningPageList.count;++i){
                objRunningPageList.itemAt(i).index = i;
            }
        }

        ListModel{
            id: objLeftDockModel
        }

        Rectangle{
            id: topButton
            width: objLeftDock.width
            height: width
            anchors.top: parent.top
            color: "black"
            Image{
                id: objLogo
                anchors.fill: parent
                sourceSize.width: width*2
                sourceSize.height: height*2
                smooth: true
                mipmap: true
                fillMode: Image.Image.PreserveAspectFit
                source: objAppUi.absoluteURL("/images/logo.png")
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        objLeftDock.close();
                    }
                }
            }
        }

        Item{
            id: listButton
            width: objLeftDock.width
            height: width
            anchors.top: topButton.bottom

            Menu {
                id: objRunningPageList
            }

            Text{
                anchors.fill: parent
                anchors.centerIn: parent
                text: QbMF3.icon("mf-widgets")
                color: "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                font.family: QbMF3.family
                font.bold: true
                font.pixelSize: parent.height*0.50
            }

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    objRunningPageList.popup(listButton.width,0);
                }
            }
        }


        Rectangle{
            id: bottomButton
            width: objLeftDock.width
            height: width
            anchors.bottom: parent.bottom
            color: "black"
            property color textColor: "white"
            Text{
                anchors.fill: parent
                anchors.centerIn: parent
                text: QbMF3.icon("mf-power_settings_new")
                color: bottomButton.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                font.family: QbMF3.family
                font.bold: true
                font.pixelSize: parent.height*0.50
            }
            MouseArea{
                anchors.fill: parent
                preventStealing: true
                hoverEnabled: true
                onClicked: {
                    objAppUi.close();
                }
                onEntered: {
                    bottomButton.color = "black";
                    bottomButton.textColor = "red";
                }
                onExited: {
                    bottomButton.color = "black";
                    bottomButton.textColor = "white";
                }
            }
        }

        ListView{
            anchors.top: listButton.bottom
            anchors.bottom: bottomButton.top
            width: parent.width
            clip: true
            model: objLeftDockModel
        }
    }

    Pane{
        id: objContentPlaceHolder

        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0
        focus: true

        Material.primary: objAppTheme.primary
        Material.accent: objAppTheme.accent
        Material.background: objAppTheme.background
        Material.foreground: objAppTheme.foreground
        Material.theme: objAppTheme.theme === "dark"?Material.Dark:Material.Light

        anchors.fill: parent

        TopToolBar{
            id: objTopToolBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            focus: true
            height: QbCoreOne.os() === "android"?QbCoreOne.scale(75):QbCoreOne.scale(50)
            appStatusBarHeight: QbCoreOne.os() === "android"?QbCoreOne.scale(25):0
            appLogo: objAppUi.absoluteURL("/images/logo.png")
            appPrevButtonVisible: objMainView.currentIndex>0
            appNextButtonVisible: objMainView.currentIndex<(objMainView.count-1)
            appCloseButtonVisible: objMainView.currentIndex>0
            z: 10000

            onLogoClicked: {
                objLeftDock.open();
            }

            onPrevClicked: {
                prevPage();
            }
            onNextClicked: {
                nextPage();
            }
            onCloseClicked: {
                popPage();
            }

            onLeftSideBarClicked: {
                toggleLeftSideBar();
            }
            onRightSideBarClicked: {
                toggleRightSideBar();
            }
        }

        SideBar{
            id: objLeftSideBar
            anchors.top: objTopToolBar.bottom
            anchors.bottom: objBottomToolBar.top
            anchors.left: parent.left
            width: 0
            z: 10000
            onWidthChanged: {
                if(objAppUi.gridState === "md" || objAppUi.gridState === "lg" ||objAppUi.gridState === "xl"){
                    if(objLeftSideBar.width === 0){
                        objMainView.anchors.left = objTopToolBar.left;
                    }
                    else{
                        objMainView.anchors.left = objLeftSideBar.right;
                    }
                }
                else{
                    objMainView.anchors.left = objTopToolBar.left;
                }
            }
            Behavior on width {
                NumberAnimation { duration: 300 }
            }
        }

        SideBar{
            id: objRightSideBar
            anchors.top: objTopToolBar.bottom
            anchors.bottom: objBottomToolBar.top
            anchors.right: parent.right
            width: 0
            z: 10000
            onWidthChanged: {
                if(objAppUi.gridState === "lg" ||objAppUi.gridState === "xl"){
                    if(objRightSideBar.width === 0){
                        objMainView.anchors.right = objTopToolBar.right;
                    }
                    else{
                        objMainView.anchors.right = objRightSideBar.left;
                    }
                }
                else{
                    objMainView.anchors.right = objTopToolBar.right;
                }
            }

            Behavior on width {
                NumberAnimation { duration: 300 }
            }
        }

        SwipeView{
            id: objMainView
            interactive: false
            anchors.top: objTopToolBar.bottom
            anchors.bottom: objBottomToolBar.top
            anchors.left: parent.left
            anchors.right: parent.right
            onCurrentIndexChanged: {
                try{
                    setupPage2(objMainView.currentItem);
                }
                catch(e){
                }
            }
        }

        BottomToolBar{
            id: objBottomToolBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: objBottomToolBar.hasBottomBar?QbCoreOne.scale(10):0
            z: 10000
        }
    }


    function appResized(){

        var w = objAppUi.width;
        if(w<576){
            objAppUi.gridState = "xs";
        }
        else if(w>=576 && w<768){
            objAppUi.gridState = "sm";
        }
        else if(w>=768 && w<960){
            objAppUi.gridState = "md";
        }
        else if(w>=960 && w<1200){
            objAppUi.gridState = "lg";
        }
        else{
            objAppUi.gridState = "xl";
        }

        objTopToolBar.appLeftSiderBarVisible = objLeftSideBar.hasSideBar;
        objTopToolBar.appRightSiderBarVisible = objRightSideBar.hasSideBar;

        if(objAppUi.gridState === "xs" || objAppUi.gridState === "sm"){
            if(objLeftSideBar.hasSideBar){
                objAppUi.leftSideBarWidth = QbCoreOne.scale(200);
                if(objLeftSideBar.width!=0){
                    objLeftSideBar.width = objAppUi.leftSideBarWidth;
                }
            }
            else{
                objAppUi.leftSideBarWidth = 0;
                objLeftSideBar.width = 0;
            }

            if(objRightSideBar.hasSideBar){
                objAppUi.rightSideBarWidth = QbCoreOne.scale(200);
                if(objRightSideBar.width!=0){
                    objRightSideBar.width = objAppUi.rightSideBarWidth;
                }
            }
            else{
                objAppUi.rightSideBarWidth = 0;
                objRightSideBar.width = 0;
            }

            objMainView.anchors.left = objTopToolBar.left;
            objMainView.anchors.right = objTopToolBar.right;
        }

        else if(objAppUi.gridState === "md"){
            if(objLeftSideBar.hasSideBar){
                objAppUi.leftSideBarWidth = QbCoreOne.scale(200);
                if(objLeftSideBar.width!=0){
                    objLeftSideBar.width = objAppUi.leftSideBarWidth;
                }
                objMainView.anchors.left = objLeftSideBar.right;
            }
            else{
                objLeftSideBar.width = 0;
                objAppUi.leftSideBarWidth = 0;
                objMainView.anchors.left = objTopToolBar.left;
            }

            if(objRightSideBar.hasSideBar){
                objAppUi.rightSideBarWidth = QbCoreOne.scale(200);
                if(objRightSideBar.width!=0){
                    objRightSideBar.width = objAppUi.rightSideBarWidth;
                }
            }
            else{
                objRightSideBar.width = 0;
                objAppUi.rightSideBarWidth = 0;
            }

            objMainView.anchors.right = objTopToolBar.right;
        }

        else if(objAppUi.gridState === "lg" || objAppUi.gridState === "xl"){
            if(objLeftSideBar.hasSideBar){
                objAppUi.leftSideBarWidth = QbCoreOne.scale(250);
                objMainView.anchors.left = objLeftSideBar.right;
                if(objLeftSideBar.width!=0){
                    objLeftSideBar.width = objAppUi.leftSideBarWidth;
                }
            }
            else{
                objLeftSideBar.width = 0;
                objAppUi.leftSideBarWidth = 0;
                objMainView.anchors.left = objTopToolBar.left;
            }

            if(objRightSideBar.hasSideBar){
                objAppUi.rightSideBarWidth = QbCoreOne.scale(250);
                objMainView.anchors.right = objRightSideBar.left;
                if(objRightSideBar.width!=0){
                    objRightSideBar.width = objAppUi.rightSideBarWidth;
                }
            }
            else{
                objRightSideBar.width = 0;
                objAppUi.rightSideBarWidth = 0;
                objMainView.anchors.right = objTopToolBar.right;
            }
        }
    }

    function pushPage(page){
        var component = Qt.createComponent(objAppUi.absoluteURL(page));
        var incubator = component.incubateObject(objMainView);
        if (incubator.status !== Component.Ready) {
            incubator.onStatusChanged = function(status) {
                if (status === Component.Ready) {
                    setupPage(incubator.object);
                }
            }
        }
        else {
            setupPage(incubator.object);
        }
    }

    function popPage(){
        if(objMainView.count>1){
            try{
                objLeftDock.removeRunningPage(objMainView.currentIndex);
                delete objMainView.takeItem(objMainView.currentIndex);
            }
            catch(e){
            }
        }
    }

    function removePage(index){
        if(objMainView.count>1){
            try{
                objLeftDock.removeRunningPage(index);
                delete objMainView.takeItem(index);
            }
            catch(e){
            }
        }
    }

    function prevPage(){
        if(objMainView.currentIndex>0){
            objMainView.setCurrentIndex(objMainView.currentIndex-1);
        }
    }
    function nextPage(){
        if(objMainView.currentIndex<(objMainView.count-1)){
            objMainView.setCurrentIndex(objMainView.currentIndex+1);
        }
    }

    function toggleLeftSideBar(){
        if(objLeftSideBar.width === objAppUi.leftSideBarWidth){
            objLeftSideBar.width = 0;
        }
        else{
            objLeftSideBar.width = objAppUi.leftSideBarWidth;
        }
    }

    function hideLeftSideBar(){
        objLeftSideBar.width = 0;
    }

    function toggleRightSideBar(){
        if(objRightSideBar.width === objAppUi.rightSideBarWidth){
            objRightSideBar.width = 0;
        }
        else{
            objRightSideBar.width = objAppUi.rightSideBarWidth;
        }
    }

    function hideRightSideBar(){
        objRightSideBar.width = 0;
    }

    function setupPage(objPage){
        var cpage = objPage;
        objLeftDock.addRunningPage(cpage.title);
        objTopToolBar.appToolBar.sourceComponent = cpage.topBar;
        objBottomToolBar.appBottomBar.sourceComponent = cpage.bottomBar;
        objLeftSideBar.appSideBar.sourceComponent = cpage.leftBar;
        objRightSideBar.appSideBar.sourceComponent = cpage.rightBar;
        objMainView.insertItem(objMainView.count,cpage);
        cpage.visible = true;
        objMainView.currentIndex = objMainView.count-1;

        appResized();
        hideLeftSideBar();
        hideRightSideBar();
        objTopToolBar.resetAnimationState();
    }

    function setupPage2(objPage){
        var cpage = objPage;

        objTopToolBar.appToolBar.sourceComponent = cpage.topBar;
        objBottomToolBar.appBottomBar.sourceComponent = cpage.bottomBar;
        objLeftSideBar.appSideBar.sourceComponent = cpage.leftBar;
        objRightSideBar.appSideBar.sourceComponent = cpage.rightBar;

        appResized();
        hideLeftSideBar();
        hideRightSideBar();
        objTopToolBar.resetAnimationState();
    }
}