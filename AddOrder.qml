import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    color: "black"

    property bool isDatePickerOpen: false
    property bool isTimePickerOpen: false

    DatePicker {
        anchors.centerIn: isDatePickerOpen ? parent : null
        visible: isDatePickerOpen
        z: 999

        onDateChanged: {
            if (!Date.prototype.withoutTime)
            {
                Date.prototype.withoutTime = function () {
                    var d = new Date(this);
                    d.setHours(0, 0, 0, 0);
                    return d;
                }
            }

            isDatePickerOpen = false

            let withoutTimeDate = date.withoutTime();
            let todayWithoutTime = (new Date()).withoutTime();

            if ( withoutTimeDate.getDate() === todayWithoutTime.getDate() )
                dateField.text = "Сьогодні";
            else
                dateField.text = date.toDateString()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 15

        Text {
            id: title
            color: "white"
            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
            text: "Створити замовлення"
            font { pointSize: 18 }
        }

        ScrollView {
            id: scrollView
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true

            ColumnLayout {
                anchors { left: parent.left; right: parent.right; }

                Rectangle {
                    color: root.color
                    Layout.fillWidth: true
                    Layout.preferredHeight: 70
                    Layout.alignment: Qt.AlignCenter

                    RowLayout {
                        spacing: 20
                        anchors.centerIn: parent
                        STextField {
                            Layout.alignment: Qt.AlignCenter
                            placeholderText: "Іван"
                            label: "Ім'я*"
                            Layout.preferredHeight: 55
                            Layout.preferredWidth: 230
                        }
                        STextField {
                            Layout.alignment: Qt.AlignCenter
                            label: "Телефон*"
                            placeholderText: "+380"
                            Layout.preferredHeight: 55
                            Layout.preferredWidth: 230
                        }
                        STextField {
                            Layout.alignment: Qt.AlignCenter
                            placeholderText: "1"
                            label: "Кількість персон*"
                            Layout.preferredHeight: 55
                            Layout.preferredWidth: 230
                            inputMethodHints: Qt.ImhDigitsOnly
                            validator: IntValidator { bottom: 1; top: 9999 }
                        }
                    }
                }
                Rectangle {
                    color: root.color
                    Layout.fillWidth: true
                    Layout.preferredHeight: 70
                    Layout.alignment: Qt.AlignCenter

                    RowLayout {
                        spacing: 20
                        anchors.centerIn: parent
                        STextField {
                            Layout.alignment: Qt.AlignCenter
                            placeholderText: "Якомога швидше"
                            label: "Час"
                            Layout.preferredHeight: 55
                            Layout.preferredWidth: 230
                            inputMethodHints: Qt.ImhDigitsOnly
                            validator: RegExpValidator { regExp: /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$ / }
                            isTimeInput: true

                        }
                        STextField {
                            id: dateField
                            Layout.alignment: Qt.AlignCenter
                            label: "Дата"
                            placeholderText: "День"
                            Layout.preferredHeight: 55
                            Layout.preferredWidth: 230
                            inputEnabled: false

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    console.log("Select date")
                                    isDatePickerOpen = true
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    color: root.color
                    Layout.fillWidth: true
                    Layout.preferredHeight: 70
                    Layout.alignment: Qt.AlignCenter

                    ButtonGroup {
                        id: deliveryState
                        onClicked: {
                            console.log(checkedButton.stateId)
                        }
                    }

                    RowLayout {
                        spacing: 20
                        anchors.centerIn: parent
                        RadioButton {
                            id: selfpickupBtn
                            property int stateId: 0
                            text: "Самовивіз"
                            ButtonGroup.group: deliveryState
                            checked: true

                            contentItem: Text {
                                    text: selfpickupBtn.text
                                    font: selfpickupBtn.font
                                    opacity: enabled ? 1.0 : 0.3
                                    color: selfpickupBtn.down ? "#17a81a" : "#21be2b"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }
                        }
                        RadioButton {
                            property int stateId: 1
                            text: "Доставка"
                            ButtonGroup.group: deliveryState
                        }
                    }
                }
            }
        }
    }
}
