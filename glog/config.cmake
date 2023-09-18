include(${CMAKE_CURRENT_LIST_DIR}/../gflags/config.cmake)
#include(${PROJECT_SOURCE_DIR}/third_party/googletest/config.cmake)
# find_package(Glog)
# if (GLOG_FOUND)
#     set(GLOG_EXTERNAL FALSE)
# endif()


include(ExternalProject)

set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(GLOG_ROOT ${CMAKE_BINARY_DIR}/third_party/glog)
set(GLOG_GIT_TAG  master)  # 指定版本
set(GLOG_GIT_URL https://github.com/google/glog.git)  # 指定git仓库地址



set(GLOG_CONFIGURE    cd ${GLOG_ROOT}/src/GLOG && rm -fr build && mkdir build && cmake -S . -DCMAKE_INSTALL_PREFIX=${GLOG_ROOT} -DBUILD_TESTING=OFF -DBUILD_GMOCK=OFF -DCMAKE_INSTALL_LIBDIR=lib -B build
)  # 指定配置指令（注意此处修改了安装目录，否则默认情况下回安装到系统目录)

set(GLOG_MAKE         cd ${GLOG_ROOT}/src/GLOG && cmake --build build)  # 指定编译指令（需要覆盖默认指令，进入我们指定的GLOG_ROOT目录下）
set(GLOG_INSTALL      cd ${GLOG_ROOT}/src/GLOG && cmake --build build --target install)  # 指定安装指令（需要覆盖默认指令，进入我们指定的GLOG_ROOT目录下,可以copy 出来

ExternalProject_Add(GLOG
        PREFIX            ${GLOG_ROOT}
        DEPENDS           GFLAGS
        GIT_REPOSITORY    ${GLOG_GIT_URL}
        GIT_TAG           ${GLOG_GIT_TAG}
        CONFIGURE_COMMAND ${GLOG_CONFIGURE}
        BUILD_COMMAND     ${GLOG_MAKE}
        INSTALL_COMMAND   ${GLOG_INSTALL}
        # LOG_CONFIGURE     1
        # LOG_INSTALL       1
        CMAKE_ARGS        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                          -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                          -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
                          -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
                          -DCMAKE_PREFIX_PATH=${GLOG_SOURCES_DIR}
                          -DCMAKE_INSTALL_PREFIX=${GLOG_ROOT/skt}
                          -DCMAKE_POSITION_INDEPENDENT_CODE=ON
		          -DBUILD_SHARED_LIBS=OFF
                          -DBUILD_STATIC_LIBS=ON
                          -DWITH_GFLAGS=ON
                          -DBUILD_GMOCK=OFF

)

# 指定编译好的静态库文件的路径
set(GLOG_LIB_DIR       ${GLOG_ROOT}/lib)
# 指定头文件所在的目录
set(GLOG_INCLUDE_DIR   ${GLOG_ROOT}/include)

message("skt lib64: ${GLOG_LIB_DIR}")
include_directories(${GLOG_INCLUDE_DIR})
link_directories(${GLOG_LIB_DIR})



ADD_LIBRARY(glog STATIC IMPORTED GLOBAL)
SET_PROPERTY(TARGET glog PROPERTY IMPORTED_LOCATION ${GLOG_LIB_DIR}/libglog.so)
# add_library(glog gflags)
add_dependencies(glog GLOG)
