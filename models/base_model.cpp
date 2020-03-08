#include "base_model.h"

Base_model::Base_model(QObject *parent)
    : QAbstractListModel(parent)
{
    m_roles[static_cast<int>(RolesNames::img_path)] = "img_path";
}

int Base_model::get_bot_delay_ms() const
{
    return bot_delay_ms;
}

QHash<int, QByteArray> Base_model::roleNames() const
{
    return m_roles;
}

