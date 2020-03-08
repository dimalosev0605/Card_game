#ifndef BOT_MODEL_H
#define BOT_MODEL_H

#include <QDebug>
#include "base_model.h"
#include "card.h"

class Bot_model: public Base_model
{
    Q_OBJECT

    Q_PROPERTY(bool is_rotate READ get_is_rotate WRITE set_is_rotate NOTIFY is_rotate_changed)
    bool is_rotate;

    QVector<Card> cards;

public:
    explicit Bot_model(QObject* parent = nullptr);
    virtual int rowCount(const QModelIndex &index = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex& index, int role) const override;

    bool get_is_rotate() const;
    void set_is_rotate(bool v);

public slots:
    void receive_cards(const QVector<Card>& new_cards);
    Card pop_last_card();

signals:
    void is_rotate_changed();
    void activate_next_bot();
};

#endif // BOT_MODEL_H
