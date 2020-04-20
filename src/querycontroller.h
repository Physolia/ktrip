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

#pragma once

#include <QObject>
#include <QVariant>
#include <QDate>

#include <KPublicTransport/DepartureRequest>
#include <KPublicTransport/JourneyRequest>
#include <KPublicTransport/Location>
#include <KPublicTransport/LocationRequest>

class QueryController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(KPublicTransport::Location start READ start WRITE setStart NOTIFY startChanged)
    Q_PROPERTY(KPublicTransport::Location destination READ destination WRITE setDestination NOTIFY destinationChanged)
    Q_PROPERTY(QDate departureDate READ departureDate WRITE setDepartureDate NOTIFY departureDateChanged)
    Q_PROPERTY(QString departureTime READ departureTime WRITE setDepartureTime NOTIFY departureTimeChanged)

public:
    explicit QueryController(QObject *parent = nullptr);

    KPublicTransport::Location start() const;
    void setStart(const KPublicTransport::Location start);

    KPublicTransport::Location destination() const;
    void setDestination(const KPublicTransport::Location destination);

    QDate departureDate() const;
    void setDepartureDate(const QDate &date);

    QString departureTime() const;
    void setDepartureTime(const QString &time);

    Q_INVOKABLE KPublicTransport::JourneyRequest createJourneyRequest();
    Q_INVOKABLE KPublicTransport::LocationRequest createLocationRequest(const QString name);
    Q_INVOKABLE KPublicTransport::DepartureRequest createDepartureRequest();

Q_SIGNALS:
    void startChanged();
    void destinationChanged();
    void departureDateChanged();
    void departureTimeChanged();

private:
    KPublicTransport::Location m_start;
    KPublicTransport::Location m_destination;
    QDate m_departureDate;
    QString m_departureTime;
};
