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

#include "formatter.h"

QString Formatter::formatDuration(int seconds)
{
    const int minutes = seconds / 60;
    const int hours = minutes / 60;
    const int minutesRemainder = minutes % 60;

    const QString minutesString = minutesRemainder > 9 ? QString::number(minutesRemainder) : QStringLiteral("0") + QString::number(minutesRemainder);

    return QString::number(hours) + QStringLiteral(":") + minutesString;
}
