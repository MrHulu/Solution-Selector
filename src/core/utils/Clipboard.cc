#include "Clipboard.h"

#include <QGuiApplication>
#include <QClipboard>

Clipboard::Clipboard(QObject *parent)
    :   QObject{parent},
    m_clip{QGuiApplication::clipboard()}
{

}

void Clipboard::setText(QString text)
{
    m_clip->setText(text,QClipboard::Clipboard);
}
