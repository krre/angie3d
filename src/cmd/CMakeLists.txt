cmake_minimum_required(VERSION 2.8)
project(al)
set(CMAKE_CXX_FLAGS "-O0 -Wall -pedantic -std=c++11")
add_executable(al main.cpp)
include_directories("../")
find_library(LIBS NAMES angie3d PATHS ${PROJECT_SOURCE_DIR}/../../lib)
target_link_libraries(al ${LIBS})
install(TARGETS al DESTINATION ${PROJECT_SOURCE_DIR}/../../lib)

