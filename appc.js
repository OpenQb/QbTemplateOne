.pragma library
.import "app.js" as App

/**************************************************************************************************
  Keep all custom global js code here
***************************************************************************************************/

function testCallback(x,y){
    console.log("X:"+x);
    console.log("Y:"+y);
    console.log("testCallback called");
    App.hideDock();
}

function setup(){
    App.addDockItem("fa-times-circle-o","Times Circle",testCallback);
    App.addDockItem("mf-watch","Watch",testCallback);
    App.addDockItem(App.resolveURL("/app.png"),"Qb Logo",testCallback);

    App.onGridStateChanged(function(){console.log(App.gridState())});
    App.addPage("/pages/TestPage.qml");
    App.addPage("/pages/TestPage2.qml");
    App.addPage("/pages/TestPage3.qml");


}
