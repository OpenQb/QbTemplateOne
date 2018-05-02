.pragma library
.import "app.js" as App

/**************************************************************************************************
  Keep all custom global js code here
***************************************************************************************************/

function vpnLockCallback(x,y){
    console.log("VPN LOCK CALLED");
    //App.hideDock();
}

function setup(){
    App.addDockItem("mf-vpn_lock","VPN Lock",vpnLockCallback);

    App.onGridStateChanged(function(){console.log(App.gridState())});
    App.addPage("/pages/TestPage.qml");
    App.addPage("/pages/TestPage2.qml");
    App.addPage("/pages/TestPage3.qml");


}
