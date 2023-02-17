include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)

# include(${CMAKE_CURRENT_LIST_DIR}/../fmt/config.cmake)

include(FetchContent)
set(FETCHCONTENT_QUIET FALSE)


FetchContent_Declare(protobuf
        GIT_REPOSITORY https://github.com/protocolbuffers/protobuf.git
        GIT_TAG v21.4)

FetchContent_MakeAvailable(protobuf)


include_directories(${protobuf_INCLUDE_DIRS})


