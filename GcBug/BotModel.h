#pragma once

#include "ElementModel.h"

#include <QObject>
#include <QString>

namespace gcbug
{
    class BotModel : public qtil::ElementModel, public std::enable_shared_from_this<BotModel>
    {
        Q_OBJECT

        using BaseObject = qtil::ElementModel;

    public:

        Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

    signals:

        void nameChanged();

    public:

        BotModel(QString name) : m_name(name) {}

        using BaseObject::BaseObject;

        const QString& name() const
        {
            return m_name;
        }

        void setName(QString val)
        {
            if (val != m_name)
            {
                m_name = val;

                emit nameChanged();
            }
        }

    private:

        QString m_name;
    };

    using BotPtr = std::shared_ptr<BotModel>;
}

Q_DECLARE_METATYPE(gcbug::BotModel*)
