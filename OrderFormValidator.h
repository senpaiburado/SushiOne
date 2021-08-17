#ifndef ORDERFORMVALIDATOR_H
#define ORDERFORMVALIDATOR_H

#include <QString>
#include <QTime>
#include <QDate>

#include "Validators.h"

struct FormData {
    QString clientName;
    QString phoneNumber;
    QTime expectedTime;
    QDate expectedDate;
    short clientsCount;
    bool isDevivery;
};

class OrderFormValidator
{
public:
    OrderFormValidator( const FormData &formData );

    bool validate();
    ValidatorErrorPtr validateErr();

private:
    FormData m_formData;
};

#endif // ORDERFORMVALIDATOR_H
