#include "ElementModel.h"

#include <QDebug>

using namespace qtil;

void ElementModel::onCreated()
{
    //To avoid calling type() from destructor.
    setObjectName(type());

    qDebug() << objectName() << " constructor. ";
}

ElementModel::~ElementModel()
{
    if (!objectName().isEmpty())
    {
        qDebug() << objectName() << " destructor. ";
    }
}
