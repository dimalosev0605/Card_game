#ifndef HUMAN_MODEL_H
#define HUMAN_MODEL_H

#include "base_model.h"
#include "card.h"

class Human_model: public Base_model
{
    Q_OBJECT

    QVector<Card> cards;

public:
    explicit Human_model(QObject* parent = nullptr);
    virtual int rowCount(const QModelIndex &index = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex& index, int role) const override;

public slots:
    void receive_cards(const QVector<Card>& new_cards);
    void remove_card(int index);
    Card get_card(int index) const;

signals:
    void activate_bots();
};

#endif // HUMAN_MODEL_H
