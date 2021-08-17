#include "Validators.h"

#include <QRegExp>
#include <QRegularExpression>

void Validator::setChainList(IValidator *chainList)
{
    m_chainList = chainList;
}

ValidatorErrorPtr Validator::isValid()
{
    if (m_chainList != nullptr)
    {
        return m_chainList->isValid();
    }

    ValidatorErrorPtr error = ValidatorErrorPtr(new ValidatorError, &QObject::deleteLater);
    error->setValidator(metaObject()->className());
    error->setDescription("Chain is not set");
    return error;
}

EmailValidator::EmailValidator(const QString &email) : BaseValidator()
{
    m_email = email;
}

ValidatorErrorPtr EmailValidator::isValid()
{
    if (!m_email.length())
        return createError("Email is not set");

    QRegExp mailREX("\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b");
    mailREX.setCaseSensitivity(Qt::CaseInsensitive);
    mailREX.setPatternSyntax(QRegExp::RegExp);

    if (mailREX.exactMatch(m_email))
    {
        if (m_next != nullptr)
            return m_next->isValid();
        return nullptr;
    }

    return createError("Email is invalid");
}

PhoneValidator::PhoneValidator(const QString &phone) : BaseValidator()
{
    m_phone = phone;
}

ValidatorErrorPtr PhoneValidator::isValid()
{
    if (!m_phone.length())
        return createError("Phone is not set");

    QRegExp phoneREX("^\\+?3?8?(0\\d{9})$");
    phoneREX.setPatternSyntax(QRegExp::RegExp);

    if (phoneREX.exactMatch(m_phone))
    {
        if (m_next != nullptr)
            return m_next->isValid();
        return nullptr;
    }

    return createError("Phone is invalid");
}

DateIsNotPastValidator::DateIsNotPastValidator(const QDate &date) : BaseValidator()
{
    m_date = date;
}

ValidatorErrorPtr DateIsNotPastValidator::isValid()
{
    if (m_date > QDate::currentDate())
    {
        if (m_next != nullptr)
            return m_next->isValid();
        return nullptr;
    }

    return createError("Date is past!");
}
