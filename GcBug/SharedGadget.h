#pragma once

#include <QObject>

#include <memory>

namespace qtil
{
    class WeakGadget;
        
    class SharedGadget
    {
        Q_GADGET

        Q_PROPERTY(QObject* p READ pointer CONSTANT);
        Q_PROPERTY(bool empty READ empty CONSTANT);
        Q_PROPERTY(int useCount READ useCount);

    public:

        SharedGadget() = default;

        SharedGadget(std::shared_ptr<QObject> p) : m_p(std::move(p)) {}

        template <class T> requires std::is_base_of_v<QObject, T>
        SharedGadget(std::shared_ptr<T> p_t) : SharedGadget(std::static_pointer_cast<QObject>(p_t)) {}

        SharedGadget(const SharedGadget& other) = default;
        SharedGadget(SharedGadget&& other) = default;

        SharedGadget& operator = (const SharedGadget& other) = default;
        SharedGadget& operator = (SharedGadget&& other) = default;

        Q_INVOKABLE SharedGadget clone() const
        {
            return *this;
        }

        Q_INVOKABLE WeakGadget weak() const;

        //For accessing from C++
        const std::shared_ptr<QObject>& sp() const
        {
            return m_p;
        }

        template <class T>
        std::shared_ptr<T> cast() const
        {
            return std::dynamic_pointer_cast<T>(m_p);
        }

    private:

        QObject* pointer() const
        {
            return m_p.get();
        }

        bool empty() const
        {
            return m_p == nullptr;
        }

        int useCount() const
        {
            return m_p.use_count();
        }

        std::shared_ptr<QObject> m_p;
    };

    class WeakGadget
    {
        Q_GADGET

        Q_PROPERTY(bool empty READ empty CONSTANT);
        Q_PROPERTY(int useCount READ useCount);
        Q_PROPERTY(bool expired READ expired);

    public:

        WeakGadget() = default;

        WeakGadget(std::weak_ptr<QObject> p) : m_p(std::move(p)) {}

        template <class T> requires std::is_base_of_v<QObject, T>
        WeakGadget(std::weak_ptr<T> p_t) : SharedGadget(std::static_pointer_cast<QObject>(p_t)) {}

        WeakGadget(const WeakGadget& other) = default;
        WeakGadget(WeakGadget&& other) = default;

        WeakGadget& operator = (const WeakGadget& other) = default;
        WeakGadget& operator = (WeakGadget&& other) = default;

        Q_INVOKABLE WeakGadget clone() const
        {
            return *this;
        }

        Q_INVOKABLE SharedGadget lock() const
        {
            return m_p.lock();
        }

        Q_INVOKABLE SharedGadget safeLock() const
        {
            std::shared_ptr<QObject> p = m_p.lock();

            if (!p)
            {
                throw std::runtime_error("Non-null pointer expected.");
            }

            return p;
        }

        //For accessing from C++
        const std::weak_ptr<QObject>& sp() const
        {
            return m_p;
        }

        template <class T>
        std::weak_ptr<T> cast() const
        {
            return std::dynamic_pointer_cast<T>(m_p);
        }

    private:

        bool empty() const
        {
            using wt = std::weak_ptr<QObject>;
            return !m_p.owner_before(wt{}) && !wt{}.owner_before(m_p);
        }

        int useCount() const
        {
            return m_p.use_count();
        }

        bool expired() const
        {
            return m_p.expired();
        }

        std::weak_ptr<QObject> m_p;
    };

    inline WeakGadget SharedGadget::weak() const
    {
        return WeakGadget(m_p);
    }
}

Q_DECLARE_METATYPE(qtil::SharedGadget)
Q_DECLARE_METATYPE(qtil::WeakGadget)
