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
    // this code probably never execute
    if(!cards.isEmpty()) {
        beginRemoveRows(QModelIndex(), 0, cards.size() - 1);
        cards.clear();
        endRemoveRows();
    }
    // end this code probably never execute

    beginInsertRows(QModelIndex(), 0, new_cards.size() - 1);
    cards = new_cards;
    endInsertRows();


    /* Debug info
    qDebug() << this << "Bot after receiving cards";
    for(int i = 0; i < cards.size(); ++i) {
        qDebug() << cards[i].get_img_path()
                 << (int)cards[i].get_suit()
                 << (int)cards[i].get_value()
                 << (int)cards[i].get_owner();
    }
    */
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
