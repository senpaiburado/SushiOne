import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Rectangle {
    property var orders: [

    ]
    color: "black"

    ColumnLayout {
        anchors { fill: parent; topMargin: 15; leftMargin: 15; rightMargin: 15 }
        Text {
            color: "white"
            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
            text: "Список замовлень"
            font { pointSize: 18 }
        }
        ListView {
            id: orderList
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 7
            model: ListModel {
                ListElement {
                    Id: 1
                    name: "Владислав Чолак"
                    number: "+380666122552"
                    date: "16:50"
                    delivery: "Доставка"
                    price: 280
                    personCount: 5
                    products: [
                        ListElement{ count: 6; name: "Філадельфія"; imgName: "filadelfia.jpg" },
                        ListElement{ count: 3; name: "Золотий дракон"; imgName: "gold_dragon.jpg" },
                        ListElement{ count: 1; name: "Матриця"; imgName: "matrix.jpg" }
                    ]
                }
                ListElement {
                    Id: 1
                    name: "Владислав Чолак"
                    number: "+380666122552"
                    date: "16:50"
                    delivery: "Доставка"
                    price: 280
                    personCount: 2
                    products: [
                        ListElement{ count: 6; name: "Філадельфія"; imgName: "filadelfia.jpg" },
                        ListElement{ count: 3; name: "Золотий дракон"; imgName: "gold_dragon.jpg" },
                        ListElement{ count: 1; name: "Матриця"; imgName: "matrix.jpg" }
                    ]
                }
                ListElement {
                    Id: 1
                    name: "Владислав Чолак"
                    number: "+380666122552"
                    date: "16:50"
                    delivery: "Доставка"
                    price: 280
                    personCount: 4
                    products: [
                        ListElement{ count: 6; name: "Філадельфія"; imgName: "filadelfia.jpg" },
                        ListElement{ count: 3; name: "Золотий дракон"; imgName: "gold_dragon.jpg" },
                        ListElement{ count: 1; name: "Матриця"; imgName: "matrix.jpg" }
                    ]
                }
            }
            header: Rectangle {
                color: "black"
                width: orderList.width
                height: 70
                Rectangle {
                    anchors.fill: parent
                    color: parent.color

                    RowLayout {
                        anchors.fill: parent
                        anchors { leftMargin: 10; rightMargin: 10 }

                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: "Ім'я"
                            color: "white"
                            font { pointSize: 13 }
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: "Телефон"
                            color: "white"
                            font { pointSize: 13 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: "Час/дата"
                            color: "white"
                            font { pointSize: 13 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: "Отримання"
                            color: "white"
                            font { pointSize: 13 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: "Ціна"
                            color: "white"
                            font { pointSize: 13 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: "К-сть осіб"
                            color: "white"
                            font { pointSize: 13 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: "Дія"
                            color: "white"
                            font { pointSize: 13 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            delegate: Rectangle {
                id: rowRoot
                width: orderList.width
                height: rowRoot.isMenuOpen ? 60 + getLength(products) * 45 : 60
                color: "#292D3E"
                clip: true

                function getLength(model) {
                    for (let i = 1; ; i++)
                    {
                        if (!model.get(i - 1))
                        {
                           return i - 1;
                        }
                    }
                }

                property bool isMenuOpen: false

                Rectangle {
                    id: rowDescription
                    anchors { top: parent.top; left: parent.left; right: parent.right; }
                    height: 60
                    color: parent.color

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            circleAnimation.stop()

                            rowRoot.isMenuOpen = !rowRoot.isMenuOpen
                        }
                        onPressed: {
                            /* When you click on an element exhibiting the starting coordinates
                                             * of the background for the animation range in element
                                             * */
                            colorRect.x = mouseX
                            colorRect.y = mouseY
                            // Запускаем анимацию
                            circleAnimation.start()
                        }
                        onReleased: circleAnimation.stop()
                        onPositionChanged: circleAnimation.stop()
                        cursorShape: Qt.PointingHandCursor
                    }

                    Rectangle {
                        id: colorRect
                        height: 0
                        width: 0
                        color: "gray"
                        opacity: 0.3

                        /* Property transformation, which will be recalculated starting position,
                                         * that there was a circle in the center of the click
                                         * */
                        transform: Translate {
                            x: -colorRect.width / 2
                            y: -colorRect.height / 2
                        }
                    }

                    PropertyAnimation {
                        id: circleAnimation
                        target: colorRect   // The aim Asking circular background
                        properties: "width,height,radius" // In animation, change the height, width and radius
                        from: 0             // Change the settings from 0 pixels ...
                        to: rowRoot.width*3    // ... to triple the size of the width of the item in the list
                        duration: 300       // within 300 milliseconds

                        // By stopping the animation zero out the height and width of an animated background
                        onStopped: {
                            colorRect.width = 0
                            colorRect.height = 0
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors { leftMargin: 10; rightMargin: 10 }

                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: name
                            color: "white"
                            font { pointSize: 11 }
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: number
                            color: "white"
                            font { pointSize: 11 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: date
                            color: "white"
                            font { pointSize: 11 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: delivery
                            color: "orange"
                            font { pointSize: 11 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: price + "₴"
                            color: "green"
                            font { pointSize: 11; weight: Font.DemiBold }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            Layout.preferredWidth: parent.width / 8
                            text: personCount
                            color: "white"
                            font { pointSize: 11 }
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Button {
                            id: actionButton
                            Layout.preferredWidth: parent.width / 8
                            text: "Подробиці"

                            onClicked: {
                                console.log("Clicked " + Id)
                            }
                        }
                    }
                }
                Rectangle {
                    id: menuList
                    anchors { top: rowDescription.bottom; left: parent.left; right: parent.right; }
                    height: rowRoot.height - 60
                    visible: rowRoot.isMenuOpen
                    color: parent.color

                    ColumnLayout {
                        id: menuLay
                        anchors.fill: parent
                    }

                    Component.onCompleted: {
                        let pattern = Qt.createComponent("BadgeMenuItem.qml");

                        for (let i = 0; i < getLength(products); i++)
                        {
                            let item = products.get(i);

                            if (item)
                            {
                                let obj = pattern.createObject(menuLay, { width: menuList.width, name: item.name, count: item.count, imgName: item.imgName, color: "#292D3E", borderColor: "black" })
                            }
                        }
                    }
                }
            }
        }
    }
}
