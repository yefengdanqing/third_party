include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)


include(FetchContent)

FetchContent_Declare(spdlog
        GIT_REPOSITORY https://gitee.com/mai12/spdlog.git
        GIT_TAG v1.4.1)

FetchContent_MakeAvailable(spdlog)
include_directories(${spdlog_SOURCE_DIR}/include)