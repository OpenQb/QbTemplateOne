import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


QbPage {
    id: objPage
    title: "QbPaths"
    isClosable: false

    QbPaths{
        id: objPaths
    }
    onPageCreated: {
        logIt.append(objPaths.qtbin());
        logIt.append(objPaths.qtdata());
        logIt.append(objPaths.qtlibrary());
        logIt.append(objPaths.qtplugins());
        logIt.append(objPaths.qtqml());
    }

    TextEdit{
        id: logIt
        anchors.fill: parent
        anchors.centerIn: parent
        wrapMode: Text.Wrap
    }
}
