#include "human_model.h"

Human_model::Human_model(QObject* parent)
    : Base_model(parent)
{
}

int Human_model::rowCount(const QModelIndex& ) const
{
    return cards.size();
}

QVariant Human_model::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= cards.size()) return QVariant();

    switch(role) {
    case static_cast<int>(RolesNames::img_path):
        return cards[row].get_img_path();
    }

    return QVariant();
}

void Human_model::receive_cards(const QVector<Card>& new_cards)
{
    beginInsertRows(QModelIndex(), 0, new_cards.size() - 1);
    cards = new_cards;
    endInsertRows();
}

void Human_model::remove_card(int index)
{
    if(index < 0 || index >= cards.size()) return;

    beginRemoveRows(QModelIndex(), index, index);
    cards.removeAt(index);
    endRemoveRows();
    QTimer::singleShot(get_bot_delay_ms(), this, &Human_model::activate_bots);
}

Card Human_model::get_card(int index) const
{
    if(index < 0 || index >= cards.size()) return Card();
    return cards[index];
}
