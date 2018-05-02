import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


QbPage {
    id: objPage
    title: "TestPage2"
    Text{
        anchors.fill: parent
        anchors.centerIn: parent
        wrapMode: Text.Wrap
        text: "Page 2 Contents"
    }
}
