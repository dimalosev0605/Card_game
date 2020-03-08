#include "referee_model.h"

Referee_model::Referee_model(QObject* parent)
    : Base_model(parent),
      all_cards(),
      distributed_cards(Constants::count_of_players, QVector<Card>()),
      collected_cards()
{
    for(int i = 0; i < Constants::count_of_players; ++i) {
        for(int j = 0; j < Constants::count_of_cards_for_player; ++j) {
            all_cards.push_back(Card(Card::Suit(i), Card::Value((int)Card::Value::six + j)));
        }
    }
    shuffle_cards();
}

void Referee_model::shuffle_cards()
{
    auto temp = all_cards.toStdVector();
    srand(time(0));
    std::default_random_engine dre(rand() % 1000000);
    int count_of_shuffles = 5;
    for(int i = 0; i < count_of_shuffles; ++i) {
        std::shuffle(temp.begin(), temp.end(), dre);
    }
    all_cards = QVector<Card>::fromStdVector(temp);
    distribute_cards();
}

void Referee_model::distribute_cards()
{
    for(int i = 0; i < distributed_cards.size(); ++i) {
        distributed_cards[i].clear();
    }

    for(int i = 0; i < Constants::count_of_players; ++i) {
        for(int j = 0; j < Constants::count_of_cards_for_player; ++j) {
            all_cards[i * Constants::count_of_cards_for_player + j].set_owner(Card::Owner(i));
            distributed_cards[i].push_back(all_cards[i * Constants::count_of_cards_for_player + j]);
        }
    }
}

QVector<Card> Referee_model::give_cards_for_player(int user)
{
    if(user < 0 || user >= Constants::count_of_players) {
        qDebug() << "Invalid user";
        std::abort();
    }

    /* Debug info
    for(int i = 0; i < distributed_cards[user].size(); ++i) {
        qDebug() << distributed_cards[user].at(i).get_img_path()
                 << (int)distributed_cards[user].at(i).get_suit()
                 << (int)distributed_cards[user].at(i).get_value()
                 << (int)distributed_cards[user].at(i).get_owner();
    }
    */

    return distributed_cards[user];
}

void Referee_model::set_is_opened_cards(bool new_value)
{
    is_opened_cards = new_value;
}

void Referee_model::receive_card(const Card &card)
{
    if(collected_cards.isEmpty() || collected_cards.back().size() == Constants::count_of_cards_in_heap) {
        beginInsertRows(QModelIndex(), collected_cards.size(), collected_cards.size());
        collected_cards.push_back(QVector<Card>{});
        endInsertRows();
    }

    collected_cards.back().push_back(card);
    switch (collected_cards.back().size()) {
    case 2: emit change_curr_item_img(Constants::path_to_backs_imgs + Constants::backs.value(2)); break;
    case 3: emit change_curr_item_img(Constants::path_to_backs_imgs + Constants::backs.value(3)); break;
    case 4: emit change_curr_item_img(Constants::path_to_backs_imgs + Constants::backs.value(4)); break;
    }

    if(collected_cards.size() == Constants::count_of_heaps &&
       collected_cards.back().size() == Constants::count_of_cards_in_heap) {
        is_opened_cards = true;
        emit push_opened_cards_view();
        QTimer::singleShot(2000, this, &Referee_model::determine_winner);
    }
}

int Referee_model::rowCount(const QModelIndex&) const
{
    if(is_opened_cards) {
        int size = 0;
        for(int i = 0; i < collected_cards.size(); ++i) {
            size += collected_cards[i].size();
        }
        return size;
    }
    else {
        return collected_cards.size();
    }
}

QVariant Referee_model::data(const QModelIndex &index, int role) const
{
    int row = index.row();

    if(is_opened_cards) {
        if(row < 0 || row >= Constants::count_of_cards) return QVariant();
        int i = row / Constants::count_of_players;
        int j = row % Constants::count_of_players;
        return collected_cards[i].at(j).get_img_path();
    }
    else {
        if(row < 0 || row >= Constants::count_of_heaps) return QVariant();
        return Constants::path_to_backs_imgs + Constants::backs.value(1);
    }
    return QVariant();
}

void Referee_model::determine_winner()
{
    if(collected_cards.isEmpty()) {
        is_opened_cards = false;
        emit pop_opened_cards_view();
        emit start_new_round();
        return;
    }

    auto cards = collected_cards.front();
    auto max_card = cards[0];
    for(int i = 0; i < cards.size(); ++i) {
        if(cards[i] > max_card) max_card = cards[i];
    }

    int max_card_repeating = 0;
    for(int i = 0; i < cards.size(); ++i) {
        if(cards[i] == max_card) ++max_card_repeating;
    }
    if(max_card_repeating > 1) {
        max_card.set_owner(Card::Owner(4));
    }

    int winner = (int)max_card.get_owner();
    emit winner_id(winner);

    beginRemoveRows(QModelIndex(), 0, cards.size() - 1);
    collected_cards.pop_front();
    endRemoveRows();

    QTimer::singleShot(2000, this, &Referee_model::determine_winner);
}
