import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15

import sushione.QMLGlobalData 1.0

Window {
    id: root
    width: 1050
    height: 600
    visible: true
    title: qsTr("SushiOne")
    color: "black"

    property int pageIdx: 0

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            id: headerBlock
            height: 50
            color: "#292D3E"
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Rectangle {
                height: 1
                color: "black"
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
            }

            Text {
                text: "SushiOne"
                color: "#F23E46"
                anchors.centerIn: parent
                font { pointSize: 18 }
            }
        }
        RowLayout {
            spacing: 0
            Rectangle {
                Layout.alignment: Qt.AlignLeft
                id: leftPanel
                Layout.preferredWidth: 70
                Layout.fillHeight: true
                color: "#292D3E"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10
                    Image {
                        id: tasksIcon
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignCenter
                        source: "qrc:///pics/tasks.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: pageIdx == QMLGlobalData.OrderList ? "#F23E46" : "#51586F"
                            antialiasing: true
                        }

                        Rectangle {
                            width: 20
                            height: 20
                            radius: 10
                            color: "#b9000b"
                            anchors { right: parent.right; top: parent.top }
                            border.color: "black"
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                color: "white"
                                text: "24"
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                pageIdx = QMLGlobalData.OrderList
                            }
                        }
                    }

                    Image {
                        id: addTaskIcon
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignCenter
                        source: "qrc:///pics/addTasks.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: pageIdx == QMLGlobalData.AddOrder ? "#F23E46" : "#51586F"
                            transform: rotation
                            antialiasing: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                pageIdx = QMLGlobalData.AddOrder
                            }
                        }
                    }

                    Image {
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignCenter
                        source: "qrc:///pics/menu.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: pageIdx == QMLGlobalData.Menu ? "#F23E46" : "#51586F"
                            transform: rotation
                            antialiasing: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                pageIdx = QMLGlobalData.Menu
                            }
                        }
                    }

                    Image {
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignCenter
                        source: "qrc:///pics/profit-report.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: pageIdx == QMLGlobalData.Stats ? "#F23E46" : "#51586F"
                            transform: rotation
                            antialiasing: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                pageIdx = QMLGlobalData.Stats
                            }
                        }
                    }

                    Image {
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignCenter
                        source: "qrc:///pics/settings.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: pageIdx == QMLGlobalData.Settings ? "#F23E46" : "#51586F"
                            transform: rotation
                            antialiasing: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                pageIdx = QMLGlobalData.Settings
                            }
                        }
                    }
                }
            }
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true

                // QMLGlobalData.Page; Changing order in enum you must change order in array below!
                Loader {
                    anchors.fill: parent
                    source: {
                        const pages = ["OrderList.qml", "AddOrder.qml", "Menu.qml", "Stats.qml", "Settings.qml"]
                        return pages[pageIdx]
                    }
                }
            }
        }
    }
}
