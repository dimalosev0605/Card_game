#include "card.h"

Card::Card(Suit suit, Value value)
    : img_path(Constants::path_to_qrc + QString("%1/%2" + Constants::cards_imgs_extension).arg(Constants::suit_folders.value(int(suit))).arg(Constants::cards_values.value(int(value)))),
      suit (suit),
      value (value)
{}

QString Card::get_img_path() const
{
    return img_path;
}

Card::Suit Card::get_suit() const
{
    return suit;
}

Card::Value Card::get_value() const
{
    return value;
}

Card::Owner Card::get_owner() const
{
    return owner;
}

void Card::set_owner(Owner new_owner)
{
    owner = new_owner;
}

bool Card::operator>(const Card& rhs)
{
    return (int)value > (int)rhs.value;
}

bool Card::operator==(const Card& rhs)
{
    return (int)value == (int)rhs.value;
}
