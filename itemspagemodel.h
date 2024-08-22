// SPDX-FileCopyrightText: 2024 UnionTech Software Technology Co., Ltd.
//
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef ITEMSPAGEMODEL_H
#define ITEMSPAGEMODEL_H

#include <QtQml/qqml.h>
#include <QAbstractListModel>

class ItemsPageModel : public QAbstractListModel
{
    Q_OBJECT
    QML_NAMED_ELEMENT(ItemsPageModel)

public:
    enum Roles {
        NameRole
    };
    Q_ENUM(Roles)

    explicit ItemsPageModel(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int,QByteArray> roleNames() const override;

    Q_INVOKABLE int addPage(QString name);
    Q_INVOKABLE void delPage();


private:
    QStringList m_page;
};

#endif // ITEMSPAGEMODEL_H
