cmake_minimum_required(VERSION 3.14)

project(Solution-Selector)

include_directories(src)

set(QTDIR $ENV{QTDIR})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /utf-8 /std:c++latest")

add_subdirectory(src)
