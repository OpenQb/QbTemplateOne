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

    addPage("/pages/TestPage.qml");
    addPage("/pages/TestPage2.qml");
    addPage("/pages/TestPage3.qml");
}

function addPage(page){
    objAppUi.pushPage(page);
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
