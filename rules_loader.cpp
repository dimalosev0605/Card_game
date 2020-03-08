#include "rules_loader.h"

const QString Rules_loader::path_to_rules_file = ":/rules.txt";
const QString Rules_loader::error_message = "While opening rules.txt error occurred.";

Rules_loader::Rules_loader(QObject *parent)
    : QObject (parent)
{

}

QString Rules_loader::load_rules() const
{
    QFile rules_file(path_to_rules_file);
    if(rules_file.open(QIODevice::ReadOnly)) {
        QString rules = rules_file.readAll();
        rules_file.close();
        return rules;
    }
    else {
        return error_message;
    }
}
