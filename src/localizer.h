/*
    Copyright (C) 2018 Volker Krause <vkrause@kde.org>

    This program is free software; you can redistribute it and/or modify it
    under the terms of the GNU Library General Public License as published by
    the Free Software Foundation; either version 2 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#ifndef LOCALIZER_H
#define LOCALIZER_H

#include <QObject>

class Localizer
{
    Q_GADGET
public:
    Q_INVOKABLE QString countryName(const QString &isoCode) const;
    /** Emoji representation of @p isoCode.
     *  @see https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
     */
    Q_INVOKABLE QString countryFlag(const QString &isoCode) const;
};

#endif // LOCALIZER_H
