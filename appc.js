.pragma library
.import "app.js" as App

/**************************************************************************************************
  Keep all custom global js code here
***************************************************************************************************/

function setup(){
    App.onGridStateChanged(function(){console.log(App.gridState())});
    App.addPage("/pages/TestPage.qml");
    App.addPage("/pages/TestPage2.qml");
    App.addPage("/pages/TestPage3.qml");
}
