cmake_minimum_required(VERSION 3.18)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ../bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ../bin)

set(PROJECT_NAME template-project)
set(EXE_NAME template-project)

project(${PROJECT_NAME} CXX)

find_package(Threads REQUIRED)

add_executable(${EXE_NAME})

set_property(
  TARGET ${EXE_NAME}
  PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded"
)

add_subdirectory(source)

target_link_libraries(
  ${EXE_NAME}
    Threads::Threads
    gtest
)

target_link_directories(
  ${EXE_NAME}
    PUBLIC lib
)

target_include_directories(
  ${EXE_NAME}
    PUBLIC include
)
