import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml.Models
import qmlListview 1.0

Rectangle {
    id: root

    property int spacingSize: 8
    property int buttonSize: 40

    color: "#e0e0e0"

    enum ModelType {
        UseInt = 1,
        UseListModel,
        UseQAbstractListModel
    }
    property int modelType: ListView1.ModelType.UseListModel

    // int model
    property int size: 3

    // ListModel
    ListModel {
        id: ffmodel
        ListElement { name: "aaa" }
        ListElement { name: "bbb" }
        ListElement { name: "ccc" }
    }

    // QAbstractListModel
    ItemsPageModel {
        id: pageMode
    }

    RowLayout {
        id: rowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: root.spacingSize
        spacing: root.spacingSize
        height: buttonSize + 10

        Control {
            id: naviCol
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentItem: ListView {
                id: naviView
                orientation: ListView.Horizontal
                boundsBehavior: Flickable.StopAtBounds //禁止列表首尾滑动
                spacing: 2
                clip: true
                model: {
                    if (root.modelType === ListView1.ModelType.UseListModel) {
                        return ffmodel
                    } else if (root.modelType === ListView1.ModelType.UseQAbstractListModel) {
                        return pageMode
                    } else {
                        return root.size
                    }
                }
                delegate: Rectangle {
                    width: height
                    height: naviView.height
                    opacity: (hoverHandler.hovered || mainView.currentIndex === index) ? 1 : 0.5
                    Text {
                        anchors.centerIn: parent
                        text: index
                    }
                    HoverHandler {
                        id: hoverHandler
                        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                        cursorShape: Qt.PointingHandCursor
                    }
                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: {
                            mainView.currentIndex = index
                        }
                    }
                }
            }
        }

        Button {
            id: addBtn
            Layout.preferredWidth: buttonSize
            Layout.preferredHeight: buttonSize
            text: "+"
            onClicked: {
                if (root.modelType === ListView1.ModelType.UseListModel) {
                    let lastpage = ffmodel.count
                    if (lastpage < 100) {
                        var data = { "name": "add" + lastpage};
                        ffmodel.append(data)
                        mainView.currentIndex = lastpage
                    }
                } else if (root.modelType === ListView1.ModelType.UseQAbstractListModel) {
                    var count = pageMode.rowCount()
                    if (count < 100) {
                        var curIndex = pageMode.addPage("add" + count)
                        mainView.currentIndex = curIndex
                    }
                } else {
                    root.size = root.size + 1
                    mainView.currentIndex = root.size - 1
                }
            }
        }

        Button {
            id: delBtn
            Layout.preferredWidth: buttonSize
            Layout.preferredHeight: buttonSize
            text: "-"
            onClicked: {
                if (root.modelType === ListView1.ModelType.UseListModel) {
                    var lastpage = ffmodel.count
                    if (lastpage > 3) {
                        ffmodel.remove(lastpage - 1)
                    }
                } else if (root.modelType === ListView1.ModelType.UseQAbstractListModel) {
                    var count = pageMode.rowCount()
                    if (count > 3) {
                        pageMode.delPage()
                    }
                } else {
                    if (root.size > 3) {
                        root.size = root.size - 1
                    }
                }
            }
        }
    }

    ListView {
        id: mainView

        anchors.top: rowLayout.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        snapMode: ListView.SnapOneItem //将切换模式设置为单张切换
        orientation: ListView.Horizontal //将列表改成水平浏览模式
        highlightRangeMode: ListView.StrictlyEnforceRange //currentIndex跟随动态变化

        // 控制 listview 滚动速度，如果没有设置，listview滚动速度很慢
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 500
        highlightMoveVelocity: -1

        currentIndex: indicator.currentIndex

        model: {
            if (root.modelType === ListView1.ModelType.UseListModel) {
                return ffmodel
            } else if (root.modelType === ListView1.ModelType.UseQAbstractListModel) {
                return pageMode
            } else {
                return root.size
            }
        }

        delegate: Rectangle {
            id: item
            width: mainView.width
            height: mainView.height
            color: index % 2 == 0 ? "red" : "green"

            Text {
                anchors.centerIn: parent
                text: root.modelType === ListView1.ModelType.UseInt ? "" : name
                font.bold: true
                font.pixelSize: 20
            }

            Text {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text: "index:" + index + " - " + "currentIndex:" + mainView.currentIndex
            }
        }

        onCurrentIndexChanged: {
            console.log("-------", currentIndex)
        }
    }

    PageIndicator {
        id: indicator

        anchors.top: mainView.top
        anchors.topMargin: 10
        anchors.horizontalCenter: mainView.horizontalCenter
        count: {
            if (root.modelType === ListView1.ModelType.UseListModel) {
                return ffmodel.count
            } else if (root.modelType === ListView1.ModelType.UseQAbstractListModel) {
                return pageMode.rowCount()
            } else {
                return root.size
            }
        }

        currentIndex: mainView.currentIndex
        interactive: true
        spacing: 10
        z: mainView.z + 1
        delegate: Rectangle {
            width: 10
            height: 10
            radius: width / 2
            color: Qt.rgba(0, 1, 1, index === indicator.currentIndex ? 0.9 : pressed ? 0.5 : 0.2)
        }
    }
}
