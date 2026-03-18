import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: container
    anchors.fill: parent  // Dynamically fits your 1440p display
    color: "#1a1b26"      // Tokyo Night Background

    // --- Timer to keep the clock ticking ---
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "h:mm AP")
    }

    // --- Icon Power Controls (Top Right) ---
    Row {
        anchors {
            top: parent.top
            right: parent.right
            margins: 30
        }
        spacing: 20

        // Reboot Icon Button
        Button {
            id: rebootBtn
            onClicked: sddm.reboot()
            hoverEnabled: true
            
            contentItem: Text {
                text: "↻"
                font.pixelSize: 28
                color: rebootBtn.hovered ? "#7aa2f7" : "#565f89"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                implicitWidth: 50
                implicitHeight: 50
                color: rebootBtn.hovered ? "#24283b" : "transparent"
                radius: 25
            }
        }

        // Shutdown Icon Button
        Button {
            id: shutdownBtn
            onClicked: sddm.powerOff()
            hoverEnabled: true

            contentItem: Text {
                text: "⏻"
                font.pixelSize: 28
                color: shutdownBtn.hovered ? "#f7768e" : "#565f89"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                implicitWidth: 50
                implicitHeight: 50
                color: shutdownBtn.hovered ? "#24283b" : "transparent"
                radius: 25
            }
        }
    }

    // --- Main Login Interface (Centered) ---
    Column {
        anchors.centerIn: parent
        spacing: 15
        width: 300

        // 1. Clock (12-hour format)
        Text {
            id: clockText
            text: Qt.formatDateTime(new Date(), "h:mm AP")
            color: "white"
            font.pointSize: 48
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // 2. User Selection
        ComboBox {
            id: userList
            width: parent.width
            model: userModel
            textRole: "name"
            currentIndex: userModel.lastIndex
            editable: true
            
            background: Rectangle {
                color: "#24283b"
                border.color: userList.activeFocus ? "#7aa2f7" : "#414868"
            }
            contentItem: Text {
                text: userList.editText
                color: "white"
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }
        }

        // 3. Password Input
        TextField {
            id: password
            placeholderText: "Password"
            width: parent.width
            echoMode: TextInput.Password
            focus: true
            color: "white"
            placeholderTextColor: "#565f89"
            background: Rectangle {
                color: "#24283b"
                border.color: password.activeFocus ? "#7aa2f7" : "#414868"
            }
            onAccepted: sddm.login(userList.editText, password.text, sessionList.currentIndex)
        }

        // 4. Session Selector
        ComboBox {
            id: sessionList
            width: parent.width
            model: sessionModel
            textRole: "name"
            currentIndex: sessionModel.lastIndex

            background: Rectangle {
                color: "#24283b"
                border.color: sessionList.activeFocus ? "#7aa2f7" : "#414868"
            }
            contentItem: Text {
                text: sessionList.currentText
                color: "#bb9af7"
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }
        }
    }
}
