#ifndef QMLGLOBALDATA_H
#define QMLGLOBALDATA_H

#include <QObject>

class QMLGlobalData
{
    Q_GADGET
public:
    QMLGlobalData();

    enum PageIndex {
        OrderList = 0,
        AddOrder = 1,
        Menu = 2,
        Settings = 3,
        Stats = 4
    };
    Q_ENUM(PageIndex)
};

#endif // QMLGLOBALDATA_H
