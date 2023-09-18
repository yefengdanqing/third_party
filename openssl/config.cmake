#include(${CMAKE_CURRENT_LIST_DIR}/../gflags/config.cmake)
#include(${PROJECT_SOURCE_DIR}/third_party/googletest/config.cmake)
# find_package(Glog)
# if (OPENSSL_FOUND)
#     set(OPENSSL_EXTERNAL FALSE)
# endif()


include(ExternalProject)

set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(OPENSSL_ROOT ${CMAKE_BINARY_DIR}/third_party/openssl)
set(OPENSSL_GIT_TAG  master)  # 指定版本
set(OPENSSL_GIT_URL https://github.com/openssl/openssl.git)  # 指定git仓库地址

# 指定编译好的静态库文件的路径
set(OPENSSL_LIB_DIR       ${OPENSSL_ROOT}/lib64)
# 指定头文件所在的目录
set(OPENSSL_INCLUDE_DIR   ${OPENSSL_ROOT}/include)

include_directories(${OPENSSL_INCLUDE_DIR})
link_directories(${OPENSSL_LIB_DIR})

set(OPENSSL_CONFIGURE    cd ${OPENSSL_ROOT}/src/OPENSSL && ./Configure --prefix=${OPENSSL_ROOT} --openssldir=${OPENSSL_ROOT} -Wl,-rpath,$(LIBRPATH))
#./config no-shared no-idea -fPIC --prefix=${OPENSSL_INSTALL_DIR}

set(OPENSSL_MAKE         cd ${OPENSSL_ROOT}/src/OPENSSL && make depend && make -j8)  # 指定编译指令（需要覆盖默认指令，进入我们指定的OPENSSL_ROOT目录下）
set(OPENSSL_INSTALL      cd ${OPENSSL_ROOT}/src/OPENSSL && make install)  # 指定安装指令（需要覆盖默认指令，进入我们指定的OPENSSL_ROOT目录下,可以copy 出来
if(NOT EXISTS ${OPENSSL_ROOT}/lib64/libsxxxsl.a) # 如果不存在，则需要编译,要先创建目标
        message("skt: ${OPENSSL_ROOT}/lib64/libssl.a")
        ExternalProject_Add(OPENSSL
                PREFIX            ${OPENSSL_ROOT}          
                GIT_REPOSITORY    ${OPENSSL_GIT_URL}
                GIT_TAG           ${OPENSSL_GIT_TAG}
                CONFIGURE_COMMAND ${OPENSSL_CONFIGURE}
                BUILD_COMMAND     ${OPENSSL_MAKE}
                INSTALL_COMMAND   ${OPENSSL_INSTALL}
                # LOG_CONFIGURE     1
                # LOG_INSTALL       1
                CMAKE_ARGS      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                                -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                                -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
                                -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
                                -DCMAKE_PREFIX_PATH=${OPENSSL_SOURCES_DIR}
                                -DCMAKE_INSTALL_PREFIX=${OPENSSL_ROOT/skt}
                                -DCMAKE_POSITION_INDEPENDENT_CODE=ON
		                -DBUILD_SHARED_LIBS=OFF
                                -DBUILD_STATIC_LIBS=ON
                                -DWITH_GFLAGS=ON
                                -DBUILD_GMOCK=OFF
                                -DCMAKE_INSTALL_LIBDIR=lib
        )



        message("skt lib64: ${OPENSSL_LIB_DIR}")
        include_directories(${OPENSSL_INCLUDE_DIR})
        link_directories(${OPENSSL_LIB_DIR})



        ADD_LIBRARY(openssl STATIC IMPORTED GLOBAL)
        SET_PROPERTY(TARGET openssl PROPERTY IMPORTED_LOCATION ${OPENSSL_LIB_DIR}/libopenssl.so)
        # add_library(openssl gflags)
        add_dependencies(openssl OPENSSL)
endif()