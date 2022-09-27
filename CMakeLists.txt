cmake_minimum_required(VERSION 3.14)

project(Solution-Selector LANGUAGES CXX)


include_directories(src)


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /utf-8 /std:c++latest")
set(QTDIR $ENV{QTDIR})
set(RootPath ${CMAKE_CURRENT_SOURCE_DIR})
set(ReleasePath ${CMAKE_CURRENT_SOURCE_DIR}/release)
set(ConfigPath ${CMAKE_CURRENT_SOURCE_DIR}/config)
set(DataPath ${CMAKE_CURRENT_SOURCE_DIR}/data)
set(QtInstallerFrameworkPath ${QTDIR}/../../Tools/QtInstallerFramework/4.4/bin)

# config
install(FILES
    ${ConfigPath}/qt.conf
    DESTINATION bin)


# openSSL
if ($ENV{Platform} MATCHES "x86")
    set(OpenSSLPath ${QTDIR}/../../Tools/OpenSSL/Win_x86)
    file(COPY
        ${OpenSSLPath}/bin/libcrypto-1_1.dll
        ${OpenSSLPath}/bin/libssl-1_1.dll
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
else()
    set(OpenSSLPath ${QTDIR}/../../Tools/OpenSSL/Win_x64)
    file(COPY
        ${OpenSSLPath}/bin/libcrypto-1_1-x64.dll
        ${OpenSSLPath}/bin/libssl-1_1-x64.dll
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
endif()
install(FILES
    ${OpenSSLPath}/bin/libcrypto-1_1.dll
    ${OpenSSLPath}/bin/libssl-1_1.dll
    DESTINATION bin)


# release
configure_file(
    ${ReleasePath}/installerFrameworkDeploy.bat.cmakein
    ${CMAKE_CURRENT_BINARY_DIR}/installerFrameworkDeploy.bat
    @ONLY)
install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/installerFrameworkDeploy.bat
    DESTINATION ./
    PERMISSIONS OWNER_EXECUTE)
install(DIRECTORY
    ${ReleasePath}/installerFramework
    DESTINATION ./)


add_subdirectory(src)
add_subdirectory(tests)
