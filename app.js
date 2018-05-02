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
