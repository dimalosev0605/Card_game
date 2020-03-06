#ifndef CARD_H
#define CARD_H

#include "Constants.h"

class Card
{
public:
    enum class Suit {
        clubs = 0,
        diamonds = 1,
        hearts = 2,
        spades = 3
    };

    enum class Value {
        six = 6,
        seven = 7,
        eight = 8,
        nine = 9,
        ten = 10,
        jack = 11,
        queen = 12,
        king = 13,
        ace = 14
    };

    enum class Owner {
        human = 0,
        left_bot = 1,
        top_bot = 2,
        right_bot = 3,
        no_owner = 4
    };

    Card() = default;
    Card(Suit suit, Value value);

    QString get_img_path() const;
    Suit get_suit() const;
    Value get_value() const;
    Owner get_owner() const;

    void set_owner(Owner new_owner);

    bool operator>(const Card& rhs);
    bool operator==(const Card& rhs);

private:
    QString img_path;
    Suit suit;
    Value value;
    Owner owner;
};

#endif // CARD_H
