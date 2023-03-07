# set(DEPS_INSTALL_DIR "/tmp/third_party" CACHE STRING "library install prefix")
# set(DEPS_PREFIX "/tmp/third_party" CACHE STRING "library install prefix")
# option(BUILD_DEPS "build and install deps" ON)
# option(BUILD_GCC "build gcc" OFF)

include(FetchContent)
# set(FETCHCONTENT_BASE_DIR "${DEPS_INSTALL_DIR}")
include(ExternalProject)

find_program(MAKE_EXECUTABLE NAMES make gmake mingw32-make REQUIRED)

# function(get_cmake_args)
#     #string(REPLACE ";" "|" CMAKE_PREFIX_PATH_STR "${CMAKE_PREFIX_PATH}")
#     #string(REPLACE ";" "\\;" CMAKE_PREFIX_PATH_STR "${CMAKE_PREFIX_PATH}")
#     set(CMAKE_ARGS
#             #-DCMAKE_PREFIX_PATH=$<CMAKE_PREFIX_PATH>
#             -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
#             -DCMAKE_BUILD_TYPE=Release
#             -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_DIR}/${DEP_NAME}
#             -DCMAKE_INSTALL_LIBDIR=lib
#             -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
#             -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
#             -DBUILD_STATIC_LIB=OFF
#             -DBUILD_SHARED_LIB=ON PARENT_SCOPE)
# endfunction(get_cmake_args)



find_program(MAKE_EXECUTABLE NAMES make gmake mingw32-make REQUIRED)



# 建议使用压缩包的方式依赖，下载速度更快
function(thirdparty_in_fetchcontent)
    message("thirdparty_in_fetchcontent")
endfunction(thirdparty_in_fetchcontent)



#generate pb.h
function(CUSTOM_PROTOBUF_GENERATE_CPP SRCS HDRS)
    message("CUSTOM_PROTOBUF_GENERATE_CPP")
    if(NOT ARGN)
        message(SEND_ERROR "Error: CUSTOM_PROTOBUF_GENERATE_CPP() called without any proto files")
        return()
    endif()
    message("CUSTOM_PROTOBUF_GENERATE_CPP1")
  # Create an include path for each file specified
    foreach(FIL ${ARGN})
        message("CUSTOM_PROTOBUF_GENERATE_CPP ${FIL}")
        get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
        get_filename_component(ABS_PATH ${ABS_FIL} PATH)
        list(FIND _protobuf_include_path ${ABS_PATH} _contains_already)
        if(${_contains_already} EQUAL -1)
            list(APPEND _protobuf_include_path -I ${ABS_PATH})
        endif()
    endforeach()

    set(${SRCS})
    set(${HDRS})
    foreach(FIL ${ARGN})
        message("CUSTOM_PROTOBUF_GENERATE_CPP ${FIL}")
        get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
        get_filename_component(FIL_WE ${FIL} NAME_WE)

        list(APPEND ${SRCS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc")
        list(APPEND ${HDRS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h")

        #execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR})
        set(test_proto_path ${PROJECT_SOURCE_DIR}/proto)

        message("CUSTOM_PROTOBUF_GENERATE_CPP-all ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc  ${PBUF_PROTOC} ${_protobuf_include_path}")
        message("skt other path [${ABS_FIL} ${protocol_protobuf}]")

        add_custom_command(
            OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc"
             "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h"
            COMMAND ${PBUF_PROTOC} -I ${PROJECT_SOURCE_DIR}/proto --cpp_out ${protocol_protobuf} ${ABS_FIL}
            DEPENDS ${ABS_FIL}
            COMMENT "Running C++ protocol buffer compiler on ${FIL}"
            VERBATIM)
    endforeach()

    set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
    set(${SRCS} ${${SRCS}} PARENT_SCOPE)
    set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

#协议相关的操作
file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/protocol/thrift/cpp)
file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/protocol/protobuf/cpp)
set(protocol_thrift ${PROJECT_BINARY_DIR}/protocol/thrift/cpp)
set(protocol_protobuf ${PROJECT_BINARY_DIR}/protocol/protobuf/cpp)
include_directories(${PROJECT_BINARY_DIR}/protocol/thrift/cpp ${PROJECT_BINARY_DIR}/protocol/protobuf/cpp)






