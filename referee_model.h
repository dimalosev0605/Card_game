#ifndef REFEREE_MODEL_H
#define REFEREE_MODEL_H

#include <QDebug>
#include <algorithm>
#include <random>
#include "base_model.h"
#include "card.h"

class Referee_model: public Base_model
{
    Q_OBJECT

    QVector<Card> all_cards;
    QVector<QVector<Card>> distributed_cards;
    QVector<QVector<Card>> collected_cards;

    bool is_opened_cards = false;

private:
    void distribute_cards();

public:
    explicit Referee_model(QObject* parent = nullptr);
    virtual int rowCount(const QModelIndex &index = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex& index, int role) const override;

public slots:
    void shuffle_cards();
    QVector<Card> give_cards_for_player(int user);
    void receive_card(const Card& card);
    void set_is_opened_cards(bool new_value);
    void determine_winner();

signals:
    void change_curr_item_img(const QString& path_to_img);
    void winner_id(int id);
    void start_new_round();
    void push_opened_cards_view();
    void pop_opened_cards_view();
};

#endif // REFEREE_MODEL_H
