#pragma once

#include <QObject>

class QClipboard;

class Clipboard : public QObject
{
    Q_OBJECT
public:
    explicit Clipboard(QObject *parent = nullptr);
    Q_INVOKABLE void setText(QString text);

signals:
private:
    QClipboard *m_clip;

};
