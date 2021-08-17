#include "OrderFormValidator.h"

#include <QDebug>

OrderFormValidator::OrderFormValidator( const FormData &formData )
    : m_formData(formData)
{

}

bool OrderFormValidator::validate()
{
    ValidatorErrorPtr err = validateErr();
    if (err != nullptr)
    {
        qDebug() << "Error in " << err->validator() << ": " << err->description() << Qt::endl;
        return false;
    }
    return true;
}

ValidatorErrorPtr OrderFormValidator::validateErr()
{
    PhoneValidator phoneValidator(m_formData.phoneNumber);
    DateIsNotPastValidator dateValidator(m_formData.expectedDate);
    Validator validator;

    phoneValidator.setNext(&dateValidator);
    validator.setChainList(&phoneValidator);
    return validator.isValid();
}
