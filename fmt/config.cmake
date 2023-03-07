cmake_minimum_required(VERSION 3.17)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)
set(BUILD_OFFLINE_LIB OFF)

set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(FMT_ROOT ${THIRD_PARTY_PREFIX}/fmt)

include(FetchContent)

FetchContent_Declare(fmt
        URL https://github.com/fmtlib/fmt/archive/refs/tags/8.0.1.tar.gz
        SOURCE_DIR ${FMT_ROOT}
        BINARY_DIR ${FMT_ROOT})

FetchContent_MakeAvailable(fmt)

message("third party fmt_SOURCE_DIR: ${fmt_SOURCE_DIR}")
include_directories(${fmt_SOURCE_DIR}/include)

