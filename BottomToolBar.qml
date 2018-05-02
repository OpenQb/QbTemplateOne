import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Item{
    id: objBottomToolBar
    property alias appBottomBar: objBottomToolBarPlacHolder
    property bool hasBottomBar: objBottomToolBarPlacHolder.status === Loader.Ready
    Loader {
        id: objBottomToolBarPlacHolder
        anchors.fill: parent
    }
}
