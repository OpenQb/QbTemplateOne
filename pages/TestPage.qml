import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


QbPage {
    id: objPage
    title: "TestPage"

    leftBar: Component{Rectangle{color: "yellow"}}
    rightBar: Component{Rectangle{color: "green"}}
    //topBar: Component{Rectangle{color: "red"}}
    bottomBar: Component{Rectangle{color: "blue"}}

    Text{
        anchors.fill: parent
        anchors.centerIn: parent
        wrapMode: Text.Wrap
        text: "A Qucik Brown fox jumps over the lazy dog. A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog.A Qucik Brown fox jumps over the lazy dog."
    }
}
