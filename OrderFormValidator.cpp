#include "OrderFormValidator.h"

#include <QDebug>

OrderFormValidator::OrderFormValidator( const FormData &formData )
    : m_formData(formData)
{

}

bool OrderFormValidator::validate()
{
    PhoneValidator phoneValidator(m_formData.phoneNumber);
    DateIsNotPastValidator dateValidator(m_formData.expectedDate);
    Validator validator;

    phoneValidator.setNext(&dateValidator);
    validator.setChainList(&phoneValidator);
    Error *err = validator.isValid();
    if (err != nullptr)
    {
        qDebug() << "Error in " << err->validator << ": " << err->description << Qt::endl;
        delete err;
        return false;
    }
    return true;
}
