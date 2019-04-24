#ifndef BACK_H
#define BACK_H

#include <QObject>

class Back : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int ind READ ind WRITE setInd NOTIFY indChanged)
    Q_PROPERTY(QStringList cont READ cont WRITE setCont NOTIFY contChanged)

    int m_ind = -1;

    QStringList m_cont = {"A", "B", "C"};

public:

    Q_INVOKABLE void trigInd(int newVar) {
        m_ind = newVar;
        emit indChanged(m_ind);
    }
    explicit Back(QObject *parent = nullptr);

    int ind() const
    {
        return m_ind;
    }

    QStringList cont() const
    {
        return m_cont;
    }

signals:
    void indChanged(int ind);

    void contChanged(QStringList cont);

public slots:
    void setInd(int ind)
    {
        if (m_ind == ind)
            return;

        m_ind = ind;
        emit indChanged(m_ind);
    }
    void setCont(QStringList cont)
    {
        if (m_cont == cont)
            return;

        m_cont = cont;
        emit contChanged(m_cont);
    }
};

#endif // BACK_H
