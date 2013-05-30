/****************************************************************************
**
** Copyright (C) 2013 Jarosław Staniek <staniek@kde.org>
** Contact: http://www.qt-project.org/legal
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.1
import "utils.js" as Utils

Item {
    property string userName: "QtForTizen"
    Rectangle {
        width: Utils.appWidth
        height: Utils.appHeight
        anchors.centerIn: parent
        scale: Math.min(parent.width / width, parent.height / height)
        color: "#f8f6ef"
        Settings { id: settings }

        Text {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 30
            anchors.rightMargin: 30
            anchors.topMargin: 30
            color: "#3b73b6"
            text: qsTr("TWEETS")
            font.family: settings.defaultFont
            font.pixelSize: 36
        }
        Text {
            id: header2
            anchors.top: header.bottom
            anchors.left: header.left
            anchors.right: header.right
            anchors.leftMargin: header.leftMargin
            anchors.rightMargin: header.rightMargin
            height: 14 + contentHeight
            color: header.color
            text: userName
            font.family: settings.defaultFont
            font.pixelSize: 24
        }
        ListView {
            id: listView
            anchors.top: header2.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            clip: true

            delegate: ListDelegate {
            }

            model: TwitterModel {
                id: xmlModel
                user: userName
            }
        }
        ScrollDecorator {
            flickableItem: listView
        }
    }
}
