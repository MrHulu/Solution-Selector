cmake_minimum_required(VERSION 3.14)

find_package(Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)

set(SOFTWARE_NAME "方案选择助手")
set(SOFTWARE_ICON_PATH "${CMAKE_CURRENT_SOURCE_DIR}/build/LOGO.ico")
set(X_VERSION "1")
set(Y_VERSION "0")
set(Z_VERSION "0")
set(SOFTWARE_VERSION "${X_VERSION}.${Y_VERSION}.${Z_VERSION}")

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/build/softwareInfo.rc.cmakein softwareInfo.rc @ONLY)
set(CMAKE_AUTORCC_OPTIONS -compress 2 -threshold 3)


enable_testing()

# ----------------  UtilsHelper ----------------------
add_library(Utils STATIC)
target_sources(Utils PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/core/UtilsHelper.h
    ${CMAKE_CURRENT_SOURCE_DIR}/core/UtilsHelper.cc

    ${CMAKE_CURRENT_SOURCE_DIR}/core/utils/Clipboard.h
    ${CMAKE_CURRENT_SOURCE_DIR}/core/utils/Clipboard.cc
    )
set_target_properties(Utils PROPERTIES
    AUTOUIC ON
    AUTOMOC ON
    AUTORCC ON
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
    INCLUDE_CURRENT_DIR ON)
target_include_directories(Utils PUBLIC
    Qt5::Core)
target_link_libraries(Utils PRIVATE
    Qt5::Core Qt5::Gui)


add_executable(Solution-Selector)
target_sources(Solution-Selector PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/qml/qml.qrc
    ${CMAKE_CURRENT_BINARY_DIR}/softwareInfo.rc
)
set_target_properties(Solution-Selector PROPERTIES
    AUTOUIC ON
    AUTOMOC ON
    AUTORCC ON
    #CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
    INCLUDE_CURRENT_DIR ON
    LINK_FLAGS "/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup"
    OUTPUT_NAME "${SOFTWARE_NAME}")
target_include_directories(Solution-Selector PUBLIC
    Qt5::Core Qt5::Quick Qt5::QuickControls2)
target_link_libraries(Solution-Selector PRIVATE
    Qt5::Core Qt5::Quick Qt5::QuickControls2
    Utils
    )


#installer
install(TARGETS Solution-Selector
    RUNTIME DESTINATION bin)

## Resource
#qt5_add_binary_resources(
#     resources ${CMAKE_CURRENT_SOURCE_DIR}/src/qml/resources.qrc
#     DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/resources.rcc
#)

