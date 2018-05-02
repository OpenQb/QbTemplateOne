.pragma library
.import "app.js" as App

/**************************************************************************************************
  Keep all custom global js code here
***************************************************************************************************/

function setup(){
    App.addPage("/pages/TestPage.qml");
    App.addPage("/pages/TestPage2.qml");
    App.addPage("/pages/TestPage3.qml");
}
