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


    // Flickable {
    //     id: flickable
    //     anchors.fill: parent
    //     contentWidth: 640
    //     contentHeight: 480

    //     ColumnLayout {

    //         anchors.fill: parent
    //         spacing: 20

    //         Rectangle {
    //             Layout.fillWidth: true
    //             Layout.preferredHeight: 100
    //             color: "red"
    //         }

    //         ListView {
    //             id: listview
    //             Layout.fillWidth: true
    //             Layout.fillHeight: true

    //             orientation: ListView.Horizontal
    //             model: 10
    //             spacing: 10

    //             delegate: Rectangle {
    //                 width: 200
    //                 height: listview.height
    //                 color: "blue"
    //             }
    //         }

    //         Rectangle {
    //             Layout.fillWidth: true
    //             Layout.preferredHeight: 100
    //             color: "green"
    //         }
    //     }
    // }

    ListView1 {
        id: listview
        anchors.fill: parent
    }
}
