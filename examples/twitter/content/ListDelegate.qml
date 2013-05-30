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
    id: root
    width: parent.width
    height: textitem.contentHeight + 2 * 40

    property alias text: textitem.text
    signal clicked

    Settings { id: settings }

    Rectangle {
        anchors.fill: parent
        color: "#5787c2"
        visible: mouse.pressed
        z: 1
    }
    Rectangle {
        id: whiteLine
        anchors.left: textitem.left
        anchors.right: textitem.right
        y: parent.height
        height: Utils.scaleLine(1)
        color: "white"
        visible: index < (listView.count - 1)
    }
    Rectangle {
        id: grayLine
        anchors.left: textitem.left
        anchors.right: textitem.right
        y: parent.height - 1
        height: Utils.scaleLine(1)
        color: "#d3d1cb"
        visible: whiteLine.visible
    }
    Text {
        id: textitem

        function richStatus(text) {
            return text.replace(/([#@][\w]+)/g, '<span style="color:#80c43d;">$&</span>')
                .replace(/(http:\/\/)([^ \n\t]+)/g, '<a href="$1$2" style="color:#80c43d;text-decoration:none;">$2</a>');
        }
        text: '<html><body style="">'
              + '<span style="text-transform:uppercase;color:'
              + (mouse.pressed ? '#cccccc' : '#999999')
              + ';">'
              + Utils.prettyDate(model.date)
              + '</span><br/>'
              + '<span style="color:'
              + (mouse.pressed ? 'white' : 'black')
              + ';">'
              + richStatus(model.statusText)
              + '</span></body></html>'
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - x * 2
        x: 30
        y: 40
        z: 2

        anchors.rightMargin: 30
        anchors.bottomMargin: 40
        wrapMode: Text.Wrap
        textFormat: Text.RichText
        font.family: settings.defaultFont
        font.pixelSize: 36
        elide: Text.ElideLeft
        MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
