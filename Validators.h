#ifndef VALIDATORS_H
#define VALIDATORS_H

#include <QString>
#include <QDate>
#include <QSharedPointer>
#include <QTypeInfo>

#define ClassName(name) #name

class ValidatorError : public QObject {
    Q_OBJECT

public:
    QString validator() const { return m_validator; }
    QString description() const { return m_description; }

    void setValidator(const QString &validatorName) { m_validator = validatorName; }
    void setDescription(const QString &desc) { m_description = desc; }

private:
    QString m_validator;
    QString m_description;
};
typedef QSharedPointer<ValidatorError> ValidatorErrorPtr;



class IValidator {
public:
    virtual void setNext(IValidator *next) = 0;
    virtual ValidatorErrorPtr isValid() = 0;
};



class BaseValidator : public QObject, public IValidator {
    Q_OBJECT
public:
    BaseValidator() { m_next = nullptr; }
    virtual void setNext(IValidator *next) override final { m_next = next; }
    ValidatorErrorPtr isValid() override { return nullptr; }

protected:
    IValidator *m_next;

    ValidatorErrorPtr createError(const QString &description)
    {
        ValidatorErrorPtr error = ValidatorErrorPtr(new ValidatorError);
        error->setValidator( metaObject()->className() );
        error->setDescription(description);
        return error;
    }
};

class Validator : public QObject {
    Q_OBJECT
public:
    void setChainList(IValidator *m_chainList);
    ValidatorErrorPtr isValid();

private:
    IValidator *m_chainList;
};

class EmailValidator : public BaseValidator {
    Q_OBJECT
public:
    EmailValidator(const QString &email);
    ValidatorErrorPtr isValid();

private:
    QString m_email;
};

class PhoneValidator : public BaseValidator {
    Q_OBJECT
public:
    PhoneValidator(const QString &phone);
    ValidatorErrorPtr isValid();

private:
    QString m_phone;
};

class DateIsNotPastValidator : public BaseValidator {
    Q_OBJECT
public:
    DateIsNotPastValidator(const QDate &date);
    ValidatorErrorPtr isValid();

private:
    QDate m_date;
};




#endif // VALIDATORS_H
