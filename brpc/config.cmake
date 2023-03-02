include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../protobuf/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../leveldb/config.cmake)
#include(${CMAKE_CURRENT_LIST_DIR}/../gflags/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../glog/config.cmake)
# message("brpc module path: ${CMAKE_MODULE_PATH}")

# set(BOOST_ENABLE_CMAKE ON)
# set(FETCHCONTENT_QUIET FALSE)

# include(FetchContent)

# FetchContent_Declare(
#     brpc
#     GIT_REPOSITORY https://github.com/apache/brpc.git
#     GIT_TAG v0.9.0
# )
# FetchContent_MakeAvailable(brpc)
# include_directories(${brpc_SOURCE_DIR}/include)



include(ExternalProject)

set(BRPC_ROOT ${CMAKE_BINARY_DIR}/third_party/brpc)
set(BRPC_GIT_TAG  master)  # 指定版本
set(BRPC_GIT_URL https://github.com/acmol/brpc.git)  # 指定git仓库地址

#
set(BRPC_CONFIGURE    cd ${BRPC_ROOT}/src/BRPC && sh config_brpc.sh --with-glog --headers=${CMAKE_BINARY_DIR}/ --libs=${CMAKE_BINARY_DIR}/)  # 指定配置指令（注意此处修改了安装目录，否则默认情况下回安装到系统目录）
set(BRPC_MAKE         cd ${BRPC_ROOT}/src/BRPC/ && make -j 8)  # 指定编译指令（需要覆盖默认指令，进入我们指定的BRPC_ROOT目录下）
set(BRPC_INSTALL      cd ${BRPC_ROOT}/src/BRPC)  # 指定安装指令（需要覆盖默认指令，进入我们指定的BRPC_ROOT目录下,可以copy 出来

ExternalProject_Add(BRPC
        PREFIX            ${BRPC_ROOT}
        GIT_REPOSITORY    ${BRPC_GIT_URL}
        GIT_TAG           ${BRPC_GIT_TAG}
        DEPENDS           leveldb glog gflags protobuf
        CONFIGURE_COMMAND ${BRPC_CONFIGURE}
        BUILD_COMMAND     ${BRPC_MAKE}
        INSTALL_COMMAND   ${BRPC_INSTALL}
)
# add_dependencies(BRPC protobuf leveldb gflags glog gtest)
# 指定编译好的静态库文件的路径
set(BRPC_LIB_DIR       ${BRPC_ROOT}/src/BRPC)
# 指定头文件所在的目录
set(BRPC_INCLUDE_DIR   ${BRPC_ROOT}/src/BRPC/include)

message("skt lib64: ${BRPC_LIB_DIR}")
include_directories(${BRPC_INCLUDE_DIR})
link_directories(${BRPC_LIB_DIR})


# add_dependencies(leveldb leveldb::leveldb)
