import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    color: "black"

    property string placeholderText: ""
    property string label: ""

    property alias validator: input.validator
    property alias inputEnabled: input.enabled
    property alias text: input.text
    property alias inputMethodHints: input.inputMethodHints
    property bool isTimeInput: false

    width: 150
    height: 50

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Text {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            font { pointSize: 10; weight: Font.Bold }
            color: input.focus ? "white" : "#5E6977"
            text: label

            Behavior on color {

                ColorAnimation {
                    duration: 100
                }
            }
        }

        Rectangle {
            color: root.color
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout {
                anchors.fill: parent
                Image {
                    id: icon
                }
                TextInput {
                    id: input
                    font.pointSize: 11
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Text {
                        property string prevText: ""

                        id: placeholder
                        anchors.fill: input
                        visible: !input.length && !input.inputMethodComposing
                        color: "#5E6977"
                        font: input.font
                        text: placeholderText
                        verticalAlignment: Text.AlignVCenter
                        onTextChanged: {
                            if ( root.isTimeInput && text.length === 2 && prevText.length < 2)
                            {
                                text += ":"
                            }
                            prevText = text;
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            Layout.preferredHeight: 2
            color: input.focus ? "white" : "#5E6977"
            Behavior on color {

                ColorAnimation {
                    duration: 100
                }
            }
        }
    }
}
