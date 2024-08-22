// SPDX-FileCopyrightText: 2024 UnionTech Software Technology Co., Ltd.
//
// SPDX-License-Identifier: GPL-3.0-or-later

#include "itemspagemodel.h"

ItemsPageModel::ItemsPageModel(QObject *parent)
    : QAbstractListModel{parent}
{
    m_page.append("000");
    m_page.append("111");
    m_page.append("222");
}

int ItemsPageModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return m_page.count();
}

QVariant ItemsPageModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_page.count()) {
        return QVariant();
    }

    int row = index.row();
    if (role == NameRole) {
        return m_page.at(row);
    }

    return QVariant();
}

QHash<int, QByteArray> ItemsPageModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(NameRole, QByteArrayLiteral("name"));
    return roles;
}

int ItemsPageModel::addPage(QString name)
{
    beginInsertRows(QModelIndex(), m_page.count(), m_page.count());
    m_page.append(name);
    endInsertRows();

    return m_page.indexOf(name);
}

void ItemsPageModel::delPage()
{
    beginRemoveRows(QModelIndex(), m_page.count()-1, m_page.count()-1);
    m_page.removeLast();
    endRemoveRows();
}
