#pragma once

#include <QObject>

class Clipboard;

class UtilsHelper : public QObject
{
    Q_OBJECT
    UtilsHelper();

    /** 剪切板 **/
    Q_PROPERTY(Clipboard* clipboard READ clipboard CONSTANT)
public: Clipboard* clipboard() { return m_clipboard; }
private: Clipboard* m_clipboard;

public:
    static UtilsHelper& instance();
};

