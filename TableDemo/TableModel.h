#include <qqml.h>
#include <QAbstractTableModel>
#include <vector>

class TableModel : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT

public:

    int rowCount(const QModelIndex & = QModelIndex()) const override
    {
        return m_rowCount;
    }

    int columnCount(const QModelIndex & = QModelIndex()) const override
    {
        return m_columnCount;
    }

    QVariant data(const QModelIndex &index, int role) const override
    {
        switch (role) {
            case Qt::DisplayRole:
                return QString("%1, %2 - %3").arg(index.column()).arg(index.row()).arg(requestCount(index.column(), index.row()));
            default:
                break;
        }

        return QVariant();
    }

    QHash<int, QByteArray> roleNames() const override
    {
        return { {Qt::DisplayRole, "display"} };
    }

    Q_INVOKABLE void add()
    {
        beginInsertRows(QModelIndex(), m_rowCount, m_rowCount);

        ++m_rowCount;

        endInsertRows();
    }

    Q_INVOKABLE void resetModel()
    {
        beginResetModel();

        endResetModel();
    }

    Q_INVOKABLE void resetCounter()
    {
        beginResetModel();

        requests.clear();

        endResetModel();
    }

private:

    size_t requestCount(int col, int row) const
    {
        const size_t index = static_cast<size_t>(row * m_columnCount + col);

        if (requests.size() < index + 1u)
        {
            requests.resize(index + 1u);
        }

        return ++requests[index];
    }

    mutable std::vector<std::size_t> requests;

    int m_columnCount = 200;
    int m_rowCount = 200;
};
