cmake_minimum_required(VERSION 3.14)

#set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(SOFTWARE_NAME "方案选择助手")
find_package(Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)

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
    #${CMAKE_CURRENT_BINARY_DIR}/resources.rc
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cc
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
    OUTPUT_NAME "${SOFTWARE_NAME}")
target_include_directories(Solution-Selector PUBLIC
    Qt5::Core Qt5::Quick Qt5::QuickControls2)
target_link_libraries(Solution-Selector PRIVATE
    Qt5::Core Qt5::Quick Qt5::QuickControls2
    Utils
    )

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(Solution-Selector)
    qt_finalize_executable(Solution-Selector)
endif()


## Resource
#qt5_add_binary_resources(
#     resources ${CMAKE_CURRENT_SOURCE_DIR}/src/qml/resources.qrc
#     DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/resources.rcc
#)

configure_file(
    ${ReleasePath}/installerFrameworkDeploy.bat.cmakein
    ${CMAKE_CURRENT_BINARY_DIR}/installerFrameworkDeploy.bat
    @ONLY)

#installer
install(FILES
    ${ConfigPath}/qt.conf
    ${OpenSSLPath}/bin/libcrypto-1_1.dll
    ${OpenSSLPath}/bin/libssl-1_1.dll
    #${ROOT_BIN_PATH}/resource.rcc
    DESTINATION bin)

install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/installerFrameworkDeploy.bat
    DESTINATION ./
    PERMISSIONS OWNER_EXECUTE)

install(TARGETS Solution-Selector
    RUNTIME DESTINATION bin)

install(DIRECTORY
    ${ReleasePath}/installerFramework
    DESTINATION ./)
