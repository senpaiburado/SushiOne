import QtQuick 2.0

Rectangle {
    id: root
    property int count: 1
    property string name: "Test"
    property string imgName: ""
    property color borderColor: "white"

    height: 40

    Rectangle {
        width: root.width
        height: 40
        color: parent.color

        Image {
            id: img
            width: 60
            height: parent.height
            source: "qrc:///pics/" + imgName
        }

        Text {
            anchors.leftMargin: 10
            anchors.left: img.right
            anchors.top: parent.top;
            anchors.bottom: parent.bottom
            color: "white"
            text: root.name
            verticalAlignment: Qt.AlignVCenter
            font { pointSize: 10; weight: Font.Medium }
        }

        Rectangle {
            width: 20
            height: 20
            radius: 10
            color: "#b9000b"
            anchors { right: img.right; top: img.top }
            border.color: "black"
            border.width: 1

            Text {
                anchors.centerIn: parent
                color: "white"
                text: String(root.count)
            }
        }
    }
}
