#ifndef BASE_MODEL_H
#define BASE_MODEL_H

#include <QAbstractListModel>
#include <QTimer>

class Base_model: public QAbstractListModel
{
    Q_OBJECT

    QHash<int, QByteArray> m_roles;
    QHash<int, QByteArray> roleNames() const override;

    const int bot_delay_ms = 500;

public:
    explicit Base_model(QObject* parent = nullptr);

    enum class RolesNames {
        img_path = Qt::UserRole,
    };

    int get_bot_delay_ms() const;
};

#endif // BASE_MODEL_H
