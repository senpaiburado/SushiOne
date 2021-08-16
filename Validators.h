#ifndef VALIDATORS_H
#define VALIDATORS_H

#include <QString>
#include <QDate>

#define ClassName(name) #name

struct Error {
    QString validator;
    QString description;
};

class IValidator {
public:
    virtual void setNext(IValidator *next) = 0;
    virtual Error* isValid() = 0;
};

class BaseValidator : public IValidator {
public:
    virtual void setNext(IValidator *next) override final { m_next = next; }
    Error* isValid() override { return nullptr; }

protected:
    IValidator *m_next;
};

class Validator {
public:
    void setChainList(IValidator *m_chainList);
    Error* isValid();

private:
    IValidator *m_chainList;
};

class EmailValidator : public BaseValidator {
public:
    EmailValidator(const QString &email);
    Error* isValid();

private:
    QString m_email;
};

class PhoneValidator : public BaseValidator {
public:
    PhoneValidator(const QString &phone);
    Error* isValid();

private:
    QString m_phone;
};

class DateIsNotPastValidator : public BaseValidator {
public:
    DateIsNotPastValidator(const QDate &date);
    Error* isValid();

private:
    QDate m_date;
};

#endif // VALIDATORS_H
