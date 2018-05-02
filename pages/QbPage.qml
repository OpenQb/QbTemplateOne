import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0

import "../app.js" as App
import "../app.js" as Appc

Page{
    id: objPage
    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    signal pageOpened();
    signal pageHidden();
    signal pageClosing();
    signal pageCreated();

    Component.onCompleted: {
        objPage.pageCreated();
    }

    Component.onDestruction: {
        objPage.pageClosing();
    }

    property string appId: App.objAppUi.appId;
    property var appJS: App
    property var appcJS: Appc

    property Component leftBar: null
    property Component rightBar: null
    property Component topBar: Component{
        Item{
            anchors.fill: parent
            Label{
                anchors.fill: parent
                text: objPage.title
                font.bold: true
                //font.family: "Times New Roman"
                //font.pixelSize: parent.height*0.4
                verticalAlignment: Label.AlignVCenter
            }
        }
    }
    property Component bottomBar: null
}
