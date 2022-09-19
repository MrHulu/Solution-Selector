#include "UtilsHelper.h"
#include "utils/Clipboard.h"

#include <QGuiApplication>

UtilsHelper::UtilsHelper()
    : m_clipboard( new Clipboard(this))
{

}

UtilsHelper &UtilsHelper::instance()
{
    static UtilsHelper _instance;
    return _instance;
}
