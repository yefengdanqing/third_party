cmake_minimum_required(VERSION 3.17)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)
set(BUILD_OFFLINE_LIB OFF)

include(FetchContent)

FetchContent_Declare(fmt
        URL https://github.com/fmtlib/fmt/archive/refs/tags/8.0.1.tar.gz)

FetchContent_MakeAvailable(fmt)

message("third party fmt_SOURCE_DIR: ${fmt_SOURCE_DIR}")
include_directories(${fmt_SOURCE_DIR}/include)

