#ifndef SUSHI_H
#define SUSHI_H

#include <QObject>
#include <QString>

class Sushi : public QObject
{
    Q_OBJECT
public:
    explicit Sushi(QObject *parent = nullptr);

private:
    int m_id;
    QString m_name;
    QString m_description;
    double m_price;
    int m_weight;


signals:

};

#endif // SUSHI_H
