#ifndef VALIDATORTEST_H
#define VALIDATORTEST_H

#include <QObject>
#include <QtTest/QtTest>

class ValidatorTest : public QObject
{
    Q_OBJECT
private slots:
    void fillBlankOrderData();
    void fillWellOrderData();
    void fillBadOrderData();

    void fillDiffErrs();
    void fillSameErrs();
};

#endif // VALIDATORTEST_H
