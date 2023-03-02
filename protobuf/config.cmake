include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)
set(CMAKE_CXX_STANDARD 17)


# include(FetchContent)
# set(FETCHCONTENT_QUIET FALSE)
# FetchContent_Declare(
#     Protobuf
#     GIT_REPOSITORY https://github.com/protocolbuffers/protobuf
#     GIT_TAG        v21.12 
#     SOURCE_SUBDIR  cmake
# )
# FetchContent_MakeAvailable(Protobuf)
# FetchContent_GetProperties(Protobuf SOURCE_DIR Protobuf_SOURCE_DIR)
# # Include the script which defines 'protobuf_generate'
# include_directories(${protobuf_INCLUDE_DIRS})
# include_directories(${CMAKE_CURRENT_BINARY_DIR})
# message("protobuf dir ${protobuf_INCLUDE_DIRS} ${protobuf_INCLUDE_DIRS}")



include(ExternalProject)
set(PROTOBUF_ROOT ${CMAKE_BINARY_DIR}/third_party/protobuf)
set(PROTOBUF_GIT_TAG  v3.21.3)  # 指定版本
set(PROTOBUF_GIT_URL  https://github.com/protocolbuffers/protobuf.git)  # 指定git仓库地址

#
set(PROTOBUF_CONFIGURE    cd ${PROTOBUF_ROOT}/src/PROTOBUF && cmake -D CMAKE_INSTALL_PREFIX=${PROTOBUF_ROOT} .)  # 指定配置指令（注意此处修改了安装目录，否则默认情况下回安装到系统目录）
set(PROTOBUF_MAKE         cd ${PROTOBUF_ROOT}/src/PROTOBUF && make)  # 指定编译指令（需要覆盖默认指令，进入我们指定的PROTOBUF_ROOT目录下）
set(PROTOBUF_INSTALL      cd ${PROTOBUF_ROOT}/src/PROTOBUF && make install)  # 指定安装指令（需要覆盖默认指令，进入我们指定的PROTOBUF_ROOT目录下

ExternalProject_Add(PROTOBUF
        PREFIX            ${PROTOBUF_ROOT}
        GIT_REPOSITORY    ${PROTOBUF_GIT_URL}
        GIT_TAG           ${PROTOBUF_GIT_TAG}
        CONFIGURE_COMMAND ${PROTOBUF_CONFIGURE}
        BUILD_COMMAND     ${PROTOBUF_MAKE}
        INSTALL_COMMAND   ${PROTOBUF_INSTALL}
)

# 指定编译好的静态库文件的路径
set(PROTOBUF_LIB_DIR       ${PROTOBUF_ROOT}/lib64)
# 指定头文件所在的目录
set(PROTOBUF_INCLUDE_DIR   ${PROTOBUF_ROOT}/include)
set(PROTOBUF_BIN_DIR       ${PROTOBUF_ROOT}/bin)
set(PBUF_PROTOC            ${PROTOBUF_BIN_DIR}/protoc)

message("skt lib64: ${PROTOBUF_LIB_DIR}")
include_directories(${PROTOBUF_INCLUDE_DIR})
LINK_DIRECTORIES(${PROTOBUF_LIB_DIR})

ADD_LIBRARY(protobuf STATIC IMPORTED GLOBAL)
SET_PROPERTY(TARGET protobuf PROPERTY IMPORTED_LOCATION ${PROTOBUF_LIB_DIR}/libprotobuf.a)
#SET_PROPERTY(TARGET protobuf PROPERTY IMPORTED_LOCATION ${PROTOBUF_LIB_DIR}/libprotoc.a)
add_dependencies(protobuf PROTOBUF)
