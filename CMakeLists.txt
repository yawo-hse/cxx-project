cmake_minimum_required(VERSION 3.18)

set(PROJECT_NAME cxx-project)
set(EXE_NAME cxx-project)

option(CODE_COVERAGE "Enable coverage reporting" OFF)

project(${PROJECT_NAME} CXX)

find_package(Threads REQUIRED)

add_executable(${EXE_NAME})

add_library(coverage_config INTERFACE)

target_link_libraries(${EXE_NAME} PUBLIC coverage_config)

if(CODE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  target_compile_options(coverage_config INTERFACE -O0 -g --coverage)

  if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.13)
    target_link_options(coverage_config INTERFACE --coverage)
  else()
    target_link_libraries(coverage_config INTERFACE --coverage)
  endif()
endif(CODE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")

add_library(Sockets INTERFACE)

set_property(
  TARGET ${EXE_NAME} PROPERTY CXX_STANDARD 20
)

if(MSVC)
  set_target_properties(
    ${EXE_NAME} PROPERTIES LINK_FLAGS "/SUBSYSTEM:CONSOLE"
  )
endif()

if(WIN32)
  add_compile_definitions(_CONSOLE UNICODE _UNICODE)

  target_link_libraries(
    Sockets INTERFACE ws2_32
  )
endif()

add_subdirectory(source)

target_link_libraries(
  ${EXE_NAME}
    Threads::Threads gtest benchmark
)

target_link_directories(
  ${EXE_NAME}
    PUBLIC lib
)

target_include_directories(
  ${EXE_NAME}
    PUBLIC include
)

enable_testing()

add_test(
  NAME unittests
  COMMAND ${EXE_NAME}
)
