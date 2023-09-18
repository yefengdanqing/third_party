include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../openssl/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../protobuf/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../leveldb/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../glog/config.cmake)



#include(${CMAKE_CURRENT_LIST_DIR}/../gflags/config.cmake)


include(ExternalProject)

# add_library(ssl SHARED IMPORTED GLOBAL)
# set_property(TARGET ssl PROPERTY IMPORTED_LOCATION ${OPENSSL_SSL_LIBRARY})

# add_library(crypto SHARED IMPORTED GLOBAL)
# set_property(TARGET crypto PROPERTY IMPORTED_LOCATION ${OPENSSL_CRYPTO_LIBRARY})

set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(BRPC_ROOT ${THIRD_PARTY_PREFIX}/brpc)
set(BRPC_GIT_TAG  1.4.0)
set(BRPC_GIT_URL https://github.com/apache/brpc.git)


set(BRPC_LIB_DIR       ${BRPC_ROOT}/lib)
set(BRPC_INCLUDE_DIR   ${BRPC_ROOT}/include)
set(BRPC_LIBRARIES   "${BRPC_LIB_DIR}/libbrpc.a" CACHE FILEPATH "BRPC_LIBRARIES" FORCE)
message("skt lib64: ${BRPC_LIB_DIR} ${BRPC_INCLUDE_DIR}")
include_directories(${BRPC_INCLUDE_DIR})
link_directories(${BRPC_LIB_DIR})


list(APPEND BRPC_DEPENDS_PREFIX_PATH ${GFLAGS_ROOT})
# list(APPEND BRPC_DEPENDS_PREFIX_PATH ${THRIFT_INSTALL_DIR})
list(APPEND BRPC_DEPENDS_PREFIX_PATH ${LEVELDB_ROOT})
#list(APPEND BRPC_DEPENDS_PREFIX_PATH ${ZLIB_ROOT})
list(APPEND BRPC_DEPENDS_PREFIX_PATH ${PROTOBUF_ROOT})
list(APPEND BRPC_DEPENDS_PREFIX_PATH ${OPENSSL_ROOT})
list(APPEND BRPC_DEPENDS_PREFIX_PATH "${GLOG_ROOT};")

#generate
string(REPLACE ";" "|" TBRPC_CMAKE_PREFIX_PATH "${BRPC_DEPENDS_PREFIX_PATH}")

if(NOT EXISTS ${BRPC_LIB_DIR}/libbrpc.a) # 如果不存在，则需要编译
    message("skt: ${BRPC_LIB_DIR}/libbrpc.a")
    ExternalProject_Add(BRPC
        GIT_REPOSITORY        ${BRPC_GIT_URL}
        GIT_TAG               ${BRPC_GIT_TAG}
        DEPENDS               LEVELDB GLOG GFLAGS PROTOBUF OPENSSL
        PREFIX                ${BRPC_ROOT}
        UPDATE_COMMAND ""
        PATCH_COMMAND     
            COMMAND   bash -c "set -ex && git apply --check ${PROJECT_SOURCE_DIR}/third_party/brpc/922.patch.new && git apply ${PROJECT_SOURCE_DIR}/third_party/brpc/922.patch.new"

        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${BRPC_ROOT}
               -DCMAKE_INSTALL_LIBDIR=${BRPC_ROOT}/lib
               -DCMAKE_PREFIX_PATH=${TBRPC_CMAKE_PREFIX_PATH}
               -DWITH_GLOG=ON
               -DBUILD_BRPC_TOOLS=ON
               -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        LIST_SEPARATOR  |
        BUILD_BYPRODUCTS ${BRPC_LIBRARIES})


    ADD_LIBRARY(brpc STATIC IMPORTED GLOBAL)
    SET_PROPERTY(TARGET brpc PROPERTY IMPORTED_LOCATION ${BRPC_LIBRARIES})
    add_dependencies(brpc BRPC)
    target_link_libraries(brpc INTERFACE dl glog gflags protobuf leveldb ssl crypto z)
    # https://github.com/PaddlePaddle/Paddle/blob/develop/cmake/external/brpc.cmake
    #https://github.com/tushushu/bigflow/tree/ab494e49a02b446bb2f504a2652f866c924c1baf/cmake
endif()
