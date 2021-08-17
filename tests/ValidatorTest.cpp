#include "ValidatorTest.h"

#include "OrderFormValidator.h"

void ValidatorTest::fillBlankOrderData()
{
    FormData data;
    OrderFormValidator validator(data);
    bool res = validator.validate();
    QVERIFY(res == false);
}

void ValidatorTest::fillWellOrderData()
{
    FormData data;
    data.clientName = "Vlad";
    data.clientsCount = 2;
    data.expectedDate = QDate(2021, 8, 21);
    data.expectedTime = QTime();
    data.phoneNumber = "0666122552";
    data.isDevivery = false;

    OrderFormValidator validator(data);
    bool res = validator.validate();
    QVERIFY(res == true);
}

void ValidatorTest::fillBadOrderData()
{
    FormData data;
    data.clientName = "Vlad";
    data.clientsCount = 2;
    data.expectedDate = QDate(2000, 1, 1);
    data.expectedTime = QTime();
    data.phoneNumber = "0666152";
    data.isDevivery = true;

    OrderFormValidator validator(data);
    bool res = validator.validate();
    QVERIFY(res == false);
}

void ValidatorTest::fillDiffErrs()
{
    FormData data;
    data.clientName = "Vlad";
    data.clientsCount = 2;
    data.expectedDate = QDate(2000, 1, 1);
    data.expectedTime = QTime();
    data.phoneNumber = "0666122552";
    data.isDevivery = true;

    OrderFormValidator validator(data);
    ValidatorErrorPtr firstErr = validator.validateErr();

    data.expectedDate = QDate(2030, 1, 1);
    data.phoneNumber = "+380xxxx000";
    validator = OrderFormValidator(data);
    ValidatorErrorPtr secondErr = validator.validateErr();

    QVERIFY(firstErr != nullptr);
    QVERIFY(secondErr != nullptr);
    QVERIFY( firstErr->validator() != secondErr->validator() );
}

void ValidatorTest::fillSameErrs()
{
    FormData data;
    data.clientName = "Vlad";
    data.clientsCount = 2;
    data.expectedDate = QDate(2030, 1, 1);
    data.expectedTime = QTime();
    data.phoneNumber = "+3806.66122552";
    data.isDevivery = true;

    QBENCHMARK {

        OrderFormValidator validator(data);
        ValidatorErrorPtr firstErr = validator.validateErr();

        data.phoneNumber = "";
        validator = OrderFormValidator(data);
        ValidatorErrorPtr secondErr = validator.validateErr();

        QVERIFY(firstErr != nullptr);
        QVERIFY(secondErr != nullptr);
        QCOMPARE(firstErr->validator(), secondErr->validator());

    }
}

QTEST_MAIN(ValidatorTest)
//#include "validatortest.moc"
