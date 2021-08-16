#include "Validators.h"

#include <QRegExp>

void Validator::setChainList(IValidator *chainList)
{
    m_chainList = chainList;
}

Error* Validator::isValid()
{
    if (m_chainList != nullptr)
    {
        return m_chainList->isValid();
    }

    Error* error = new Error;
    error->validator = ClassName(Validator);
    error->description = "Chain is not set";
    return error;
}

EmailValidator::EmailValidator(const QString &email)
{
    m_email = email;
}

Error* EmailValidator::isValid()
{
    Error* error = new Error;
    error->validator = ClassName(EmailValidator);

    if (!m_email.length())
    {
        error->description = "Email is not set";
        return error;
    }

    QRegExp mailREX("\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b");
    mailREX.setCaseSensitivity(Qt::CaseInsensitive);
    mailREX.setPatternSyntax(QRegExp::RegExp);

    if (mailREX.exactMatch(m_email))
    {
        delete error;
        if (m_next != nullptr)
            return m_next->isValid();
        return nullptr;
    }

    error->description = "Email is invalid";
    return error;
}

PhoneValidator::PhoneValidator(const QString &phone)
{
    m_phone = phone;
}

Error *PhoneValidator::isValid()
{
    Error* error = new Error;
    error->validator = ClassName(PhoneValidator);

    if (!m_phone.length())
    {
        error->description = "Phone is not set";
        return error;
    }

    QRegExp phoneREX("^\\+?3?8?(0[\\s\\.-]\\d{2}[\\s\\.-]\\d{3}[\\s\\.-]\\d{2}[\\s\\.-]\\d{2})$");
    phoneREX.setCaseSensitivity(Qt::CaseInsensitive);
    phoneREX.setPatternSyntax(QRegExp::RegExp);

    if (phoneREX.exactMatch(m_phone))
    {
        delete error;
        if (m_next != nullptr)
            return m_next->isValid();
        return nullptr;
    }

    error->description = "Phone is invalid";
    return error;
}

DateIsNotPastValidator::DateIsNotPastValidator(const QDate &date)
{
    m_date = date;
}

Error *DateIsNotPastValidator::isValid()
{
    Error* error = new Error;
    error->validator = ClassName(DateIsNotPastValidator);

    if (m_date > QDate())
    {
        delete error;
        if (m_next != nullptr)
            return m_next->isValid();
        return nullptr;
    }

    error->description = "Date is past";
    return error;
}
