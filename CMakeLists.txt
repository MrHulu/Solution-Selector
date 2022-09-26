cmake_minimum_required(VERSION 3.14)

project(Solution-Selector)

include_directories(src)

set(QTDIR $ENV{QTDIR})
set(RootPath ${CMAKE_CURRENT_SOURCE_DIR})
set(ReleasePath ${CMAKE_CURRENT_SOURCE_DIR}/release)
set(ConfigPath ${CMAKE_CURRENT_SOURCE_DIR}/config)
set(DataPath ${CMAKE_CURRENT_SOURCE_DIR}/data)
set(QtInstallerFrameworkPath ${QTDIR}/../../Tools/QtInstallerFramework/4.4/bin)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /utf-8 /std:c++latest")

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

add_subdirectory(src)
add_subdirectory(tests)
