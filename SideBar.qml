import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Item{
    id: objSideBar
    property alias appSideBar: objSideBarPlaceHolder
    property bool hasSideBar: objSideBarPlaceHolder.status === Loader.Ready
    Loader {
        id: objSideBarPlaceHolder
        anchors.fill: parent
    }
}
