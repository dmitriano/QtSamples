#pragma once

#include <type_traits>

#include <memory>

#include <QObject>

namespace qtil
{
    class ElementModel : public QObject
    {
        Q_OBJECT

    public:

        Q_PROPERTY(QString type READ type CONSTANT)

        ElementModel() = default;

        ~ElementModel();

        const char* type() const
        {
            const QMetaObject* mo = metaObject();

            return mo->className();
        }

        virtual void onCreated();
    };

    template <class T, class Model> requires std::is_base_of_v<ElementModel, T>
    inline std::shared_ptr<T> makeObject(Model m)
    {
        std::shared_ptr<T> p = std::make_shared<T>(std::move(m));

        p->onCreated();

        return p;
    }
}
