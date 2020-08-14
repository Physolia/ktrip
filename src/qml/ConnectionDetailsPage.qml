/**
 * SPDX-FileCopyrightText: 2019 Nicolas Fella <nicolas.fella@gmx.de>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */

import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.4
import org.kde.kirigami 2.4 as Kirigami
import org.kde.kpublictransport 1.0
import org.kde.ktrip 1.0

Kirigami.ScrollablePage
{
    id: root
    title: i18nc("@title", "Details")

    property var journey

    Kirigami.CardsListView {
        model: root.journey.sections

        delegate: Loader {
            sourceComponent: {
                switch(model.modelData.mode) {
                    case JourneySection.Walking: return walking
                    case JourneySection.Waiting: return waiting
                    case JourneySection.Transfer: return transfer
                    default: return cardComponent
                }
            }
            property var theData: model.modelData
        }
    }

    Component {
        id: walking
        Label {
            text: i18np("Walking (%1 minute)", "Walking (%1 minutes)", theData.duration / 60)
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Component {
        id: waiting
        Label {
            text: i18np("Waiting (%1 minute)", "Waiting (%1 minutes)", theData.duration / 60)
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Component {
        id: transfer
        Label {
            text: i18np("Transfer (%1 minute)", "Transfer (%1 minutes)", theData.duration / 60)
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Component {
        id: cardComponent

        Kirigami.AbstractCard {
            id: cardDelegate

            header: Column {

                RowLayout {
                    Kirigami.Icon {
                        visible: theData.route.line.hasLogo
                        source: theData.route.line.logo
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                    }

                    Kirigami.Heading {
                        id: headerLabel
                        level: 4
                        font.strikeout: theData.disruptionEffect == Disruption.NoService
                        color: theData.disruptionEffect == Disruption.NoService ? Kirigami.Theme.negativeTextColor : Kirigami.Theme.textColor
                        text: theData.route.line.name
                    }
                }

                Item {
                    width: 1
                    height: cardDelegate.topPadding
                }

                Kirigami.Separator {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: -cardDelegate.leftPadding
                    anchors.rightMargin: -cardDelegate.rightPadding
                }
            }

            contentItem: Column {
                id: topLayout

                RowLayout {
                    width: parent.width
                    Label {
                        text: theData.scheduledDepartureTime.toLocaleTimeString(Locale.ShortFormat)
                    }

                    Label {
                        text: theData.expectedDepartureTime.toLocaleTimeString(Locale.ShortFormat)
                        visible: theData.departureDelay > 0
                        color: Kirigami.Theme.negativeTextColor
                    }

                    Label {
                        text: theData.from.name
                        wrapMode: Text.Wrap
                    }

                    Button {
                        visible: theData.from.hasCoordinate
                        icon.name: "mark-location-symbolic"
                        flat: true
                        onClicked: Controller.showOnMap(theData.from)
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Label {
                        text: theData.scheduledDeparturePlatform
                    }
                }

                RowLayout {
                    width: parent.width
                    Label {
                        text: theData.scheduledArrivalTime.toLocaleTimeString(Locale.ShortFormat)
                    }

                    Label {
                        text: theData.expectedArrivalTime.toLocaleTimeString(Locale.ShortFormat)
                        visible: theData.arrivalDelay > 0
                        color: Kirigami.Theme.negativeTextColor
                    }

                    Label {
                        text: theData.to.name
                        wrapMode: Text.Wrap
                    }

                    Button {
                        visible: theData.to.hasCoordinate
                        icon.name: "mark-location-symbolic"
                        flat: true
                        onClicked: Controller.showOnMap(theData.to)
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Label {
                        text: theData.scheduledArrivalPlatform
                    }
                }

                Label {
                    text: theData.notes.join("<br>")
                    onLinkActivated: link => Qt.openUrlExternally(link)
                    topPadding: Kirigami.Units.largeSpacing
                    width: parent.width
                    wrapMode: Text.Wrap
                }
            }
        }
    }
}
