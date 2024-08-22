import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml.Models

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ListView1 {
        id: listview
        anchors.fill: parent
    }
}
