#pragma once

#include "BotModel.h"
#include "SharedGadget.h"

#include <QtQml/qqml.h>

namespace gcbug
{
    class BotManager : public QObject
    {
        Q_OBJECT
        QML_ELEMENT

    public:

        Q_INVOKABLE qtil::SharedGadget createBot(QString name)
        {
            return internalCreate(name);
        }

    private:

        BotPtr internalCreate(QString name)
        {
            return qtil::makeObject<BotModel>(name);
        }
    };
}
