cmake_minimum_required(VERSION 3.14)

#set(CMAKE_INCLUDE_CURRENT_DIR ON)
find_package(Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)

add_executable(Solution-Selector)
target_sources(Solution-Selector PRIVATE
    #${CMAKE_CURRENT_BINARY_DIR}/d00-pc-gui.rc
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/core/Clipboard.h
    ${CMAKE_CURRENT_SOURCE_DIR}/core/Clipboard.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/qml/qml.qrc
)
set_target_properties(Solution-Selector PROPERTIES
    AUTOUIC ON
    AUTOMOC ON
    AUTORCC ON
    #CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
    INCLUDE_CURRENT_DIR ON
    LINK_FLAGS "/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup"
    OUTPUT_NAME "帮助选择器")
target_include_directories(Solution-Selector PUBLIC
    Qt5::Core Qt5::Quick Qt5::QuickControls2)
target_link_libraries(Solution-Selector PRIVATE
    Qt5::Core Qt5::Quick Qt5::QuickControls2
    )

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(Solution-Selector)
    qt_finalize_executable(Solution-Selector)
endif()


## Resource
#qt5_add_binary_resources(
#     resources ${CMAKE_CURRENT_SOURCE_DIR}/src/qml/qml.qrc
#     DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/qml.rcc
#)
