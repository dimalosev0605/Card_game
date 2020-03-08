#ifndef RULES_LOADER_H
#define RULES_LOADER_H

#include <QObject>
#include <QFile>

class Rules_loader: public QObject
{
    Q_OBJECT

    static const QString path_to_rules_file;
    static const QString error_message;

public:
    explicit Rules_loader(QObject* parent = nullptr);

public slots:
    QString load_rules() const;
};

#endif // RULES_LOADER_H
