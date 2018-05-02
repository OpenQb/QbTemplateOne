.pragma library

var objAppUi;
var objAppTheme;
var objTopToolBar;
var objMainView;
var objBottomToolBar;
var objPackageReader;
var objLeftDock;

var appToolBarLoader;
var appStatusBarLoader;
var appBottomBarLoader;


var objLeftSideBar;
var objRightSideBar;

var appLeftSideBarLoader;
var appRightSideBarLoader;


function setup(appUi){
    objAppUi = appUi;

    var themeOne = {};
    themeOne["primary"] = "#004361";
    themeOne["secondary"] = "#007290";
    themeOne["accent"] = "#007290";
    themeOne["background"] = "white";
    themeOne["foreground"] = "black";
    themeOne["theme"] = "dark";
    objAppTheme.setThemeFromJsonData(JSON.stringify(themeOne));
}

function addPage(page,jsobject){
    objAppUi.pushPage(page,jsobject);
}

function getCurrentPage(){
    return objAppUi.getCurrentPage();
}

function closePage(index){
    objAppUi.removePage(index);
}

function closeCurrentPage(){
    objAppUi.popPage();
}

function removePage(index){
    objAppUi.removePage(index);
}

function isDark(color){
    return objAppTheme.isDark(color);
}


/* Methods for LeftDock */
function addDockItem(icon,title,callable){
    objLeftDock.addIcon({"icon":icon,"title":title});
    objLeftDock.callableList.push(callable);
}

function insertDockItem(index,icon,title,callable){
    objLeftDock.insertIcon(index,{"icon":icon,"title":title});
    objLeftDock.callableList.splice(index, 0, callable);
}

function pushDockItem(icon,title,callable){
    objLeftDock.addDockItem(icon,title,callable);
}

function popDockItem(){
    var i = totalDockItems()-1;
    var di = dockItemAt(i);
    removeDockItemByIndex(i);
    di["callable"] = objLeftDock.callableList[i];
    objLeftDock.callableList.splice(i, 1);
    return di;
}

function totalDockItems(){
    return objLeftDock.totalIcons;
}

function clearDockItems(){
    objLeftDock.clearAllIcons();
    objLeftDock.callableList.clear();
}

function dockItemAt(index){
    var di = objLeftDock.iconAt(index);
    di["callable"] = objLeftDock.callableList[i];
    return di;
}

function removeDockItemByIndex(index){
    try{
        objLeftDock.removeIcon(index);
        objLeftDock.callableList.splice(index, 1);
    }
    catch(e){
        console.log("ERROR on removeDockItemByIndex: "+index);
        console.log(e);
    }
}
/* END Methods for LeftDock */




function onGridStateChanged(callable){
    if(callable){
        objAppUi.gridStateChanged.connect(callable);
        callable();
    }
}

function gridState(){
    return objAppUi.gridState;
}

function showDock(){
    objLeftDock.open();
}

function hideDock(){
    objLeftDock.close();
}
