cmake_minimum_required(VERSION 3.18)

find_package(Qt5 COMPONENTS Test REQUIRED Network)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /utf-8")
enable_testing()


project(tst_test LANGUAGES CXX)
add_executable(tst_test)
target_sources(tst_test PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/tst_test.cc)
set_target_properties(tst_test PROPERTIES
    AUTOUIC ON
    AUTOMOC ON
    AUTORCC ON
    #CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
    INCLUDE_CURRENT_DIR ON)
target_include_directories(tst_test PUBLIC
    Qt5::Test Qt5::Network)
target_link_libraries(tst_test PRIVATE
    Qt5::Test Qt5::Network)

add_test(NAME tst_test
    COMMAND tst_test)
