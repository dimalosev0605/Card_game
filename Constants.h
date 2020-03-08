#ifndef CONSTANTS_H
#define CONSTANTS_H

#include <QString>
#include <QMap>

namespace Constants
{
    const int count_of_cards = 36;
    const int count_of_players = 4;
    const int count_of_cards_for_player = count_of_cards / count_of_players;
    const int count_of_heaps = count_of_cards / count_of_players;
    const int count_of_cards_in_heap = count_of_cards / count_of_cards_for_player;
    const int count_of_suits = 4;

    const QString path_to_qrc = "qrc:/cards/";
    const QString path_to_backs_imgs = path_to_qrc + "backs/";
    const QString cards_imgs_extension = ".svg";

    const QMap<int, QString> suit_folders = {
        {0, "clubs"},
        {1, "diamonds"},
        {2, "hearts"},
        {3, "spades"},
    };
    const QMap<int, QString> cards_values = {
        {6, "6"},
        {7, "7"},
        {8, "8"},
        {9, "9"},
        {10, "10"},
        {11, "jack"},
        {12, "queen"},
        {13, "king"},
        {14, "ace"},
    };
    const QMap<int, QString> backs = {
        {0, "rotated_back"},
        {1, "one_back.svg"},
        {2, "two_backs.png"},
        {3, "three_backs.png"},
        {4, "four_backs.png"}
    };
}

#endif // CONSTANTS_H
