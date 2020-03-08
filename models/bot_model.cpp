#include "bot_model.h"

Bot_model::Bot_model(QObject* parent)
    : Base_model(parent)
{
}

int Bot_model::rowCount(const QModelIndex&) const
{
    return cards.size();
}

QVariant Bot_model::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= cards.size()) return QVariant();

    switch(role) {
    case static_cast<int>(RolesNames::img_path):
        return is_rotate ? Constants::path_to_backs_imgs + Constants::backs.value(0) :
                           Constants::path_to_backs_imgs + Constants::backs.value(1);
    }

    return QVariant();
}

bool Bot_model::get_is_rotate() const
{
    return is_rotate;
}

void Bot_model::set_is_rotate(bool v)
{
    is_rotate = v;
}

void Bot_model::receive_cards(const QVector<Card>& new_cards)
{
    beginInsertRows(QModelIndex(), 0, new_cards.size() - 1);
    cards = new_cards;
    endInsertRows();
}

Card Bot_model::pop_last_card()
{
    if(cards.isEmpty()) return Card();
    auto poped_card = cards.back();
    beginRemoveRows(QModelIndex(), cards.size() - 1, cards.size() - 1);
    cards.pop_back();
    endRemoveRows();
    QTimer::singleShot(get_bot_delay_ms(), this, &Bot_model::activate_next_bot);
    return poped_card;
}
