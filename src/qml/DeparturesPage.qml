/**
 * Copyright 2019 Nicolas Fella <nicolas.fella@gmx.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.4
import org.kde.kirigami 2.4 as Kirigami
import org.kde.kpublictransport 1.0 as KPT
import org.kde.ktrip 1.0

Kirigami.ScrollablePage
{
    title: i18nc("@title", "Departures")

    header: Kirigami.InlineMessage {
        type: Kirigami.MessageType.Error
        text: theModel.errorMessage
        visible: theModel.errorMessage != ""
    }

    ListView {

        model: KPT.DepartureQueryModel {
            id: theModel
            request: Controller.createDepartureRequest()
            manager: _manager
        }

        delegate: Kirigami.AbstractListItem {
            RowLayout {
                Label {
                    text: i18n("%3 %1 (%2)", departure.route.line.name, departure.route.direction, _formatter.formatTime(departure.scheduledDepartureTime))
                    Layout.fillWidth: true
                }
                Label {
                    text: departure.scheduledPlatform
                }
            }
        }

        footer: ToolButton {
            width: parent.width
            visible: theModel.canQueryNext
            onClicked: theModel.queryNext()
            icon.name: "arrow-down"
        }

        BusyIndicator {
            running: theModel.loading
            anchors.centerIn: parent
        }
    }
}


