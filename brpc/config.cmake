include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../gflags/config.cmake)
message("brpc module path: ${CMAKE_MODULE_PATH}")

set(BOOST_ENABLE_CMAKE ON)
set(FETCHCONTENT_QUIET FALSE)

include(FetchContent)

FetchContent_Declare(
    brpc
    GIT_REPOSITORY https://github.com/apache/brpc.git
    GIT_TAG v0.9.0
)
FetchContent_MakeAvailable(brpc)
include_directories(${brpc_SOURCE_DIR}/include)













# INCLUDE(ExternalProject)

# set(BRPC_CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH})
# set(BRPC_INSTALL_DIR "${PROJECT_BINARY_DIR}/third_party/brpc")
# set(BRPC_INCLUDE_DIR "${BRPC_INSTALL_DIR}/include" CACHE PATH "brpc include directory." FORCE)
# set(BRPC_LIBRARIES   "${BRPC_INSTALL_DIR}/lib/libbrpc.a" CACHE FILEPATH "BRPC_LIBRARIES" FORCE)

# include_directories(SYSTEM ${BRPC_INCLUDE_DIR})

# set(BRPC_VERSION "brpc")
# #execute_process(
# #    COMMAND cp -r "/root/proj/third_party/brpc/feeds-brpc" ${PROJ_THIRD_PARTY_UNZIP_DIR}/brpc
# #    RESULT_VARIABLE BRPC_SOURCE_UNZIP_SUCCESS
# #)

# #if(NOT "${BRPC_SOURCE_UNZIP_SUCCESS}" STREQUAL "0")
# #    message(FATAL_ERROR "unzip && patch tar failed -> ${BRPC_SOURCE_UNZIP_SUCCESS}")
# #endif()

# list(APPEND BRPC_CMAKE_PREFIX_PATH ${GFLAGS_INSTALL_DIR})
# list(APPEND BRPC_CMAKE_PREFIX_PATH ${THRIFT_INSTALL_DIR})
# list(APPEND BRPC_CMAKE_PREFIX_PATH ${OPENSSL_INSTALL_DIR})
# list(APPEND BRPC_CMAKE_PREFIX_PATH ${LEVELDB_INSTALL_DIR})
# list(APPEND BRPC_CMAKE_PREFIX_PATH ${ZLIB_INSTALL_DIR})
# list(APPEND BRPC_CMAKE_PREFIX_PATH ${PROTOBUF_INSTALL_DIR})
# list(APPEND BRPC_CMAKE_PREFIX_PATH ${GLOG_INSTALL_DIR})


# #generate
# string(REPLACE ";" "|" TBRPC_CMAKE_PREFIX_PATH "${BRPC_CMAKE_PREFIX_PATH}")
# string(REPLACE ";" "/lib\n" TBRPC_LINK_LIB_PATH "${BRPC_CMAKE_PREFIX_PATH}")
# string(REPLACE ";" "/include\n" TBRPC_INC_PATH "${BRPC_CMAKE_PREFIX_PATH}")
# execute_process(
#     COMMAND bash -c "
#         cat << EOF > ${PROJ_THIRD_PARTY_UNZIP_DIR}/brpc_include.cmake
#             include_directories(${TBRPC_INC_PATH}/include)
#             link_directories(${TBRPC_LINK_LIB_PATH}/lib)
# EOF"

# #target_link_libraries(brpc-static /usr/local/ssl/lib/libssl.a /usr/local/ssl/lib/libcrypto.a)
# )

# #
# ExternalProject_Add(
#   brpc_brpc
#   DEPENDS protobuf_protobuf ${OPENSSL_DEPENDS} glog_glog gflags_gflags ${THRIFT_DEPENDS} leveldb_leveldb zlib_zlib 
#   GIT_REPOSITORY   https://github.com/apache/incubator-brpc.git
#   GIT_TAG          1.1.0
#   SOURCE_DIR       "${PROJ_THIRD_PARTY_UNZIP_DIR}/${BRPC_VERSION}"
#   PATCH_COMMAND     
# 	COMMAND   bash -c "git apply --check ${PROJ_THIRD_PARTY_DIR}/brpc/922.patch.new && git apply ${PROJ_THIRD_PARTY_DIR}/brpc/922.patch.new"
# 	COMMAND   bash -c "sed -i 's/2.8.10/2.8.11/g' <SOURCE_DIR>/CMakeLists.txt"
# 	COMMAND   bash -c "git config --global user.email 'fake'"
# 	COMMAND   bash -c "git config --global user.name 'fake'"
# 	COMMAND   bash -c "git am ${PROJ_THIRD_PARTY_DIR}/brpc/1608.patch.new"
#   UPDATE_COMMAND   ""
#   BUILD_BYPRODUCTS ${BRPC_LIBRARIES}
#   LIST_SEPARATOR   | ## TODO FUCK: for lowwer cmake compat
#   CMAKE_ARGS       -DCMAKE_INSTALL_PREFIX=${BRPC_INSTALL_DIR}
#                    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#                    -DCMAKE_GENERATOR=${CMAKE_GENERATOR}
#                    -DCMAKE_PREFIX_PATH=${TBRPC_CMAKE_PREFIX_PATH}
#                    -DOPENSSL_ROOT_DIR=${OPENSSL_INSTALL_DIR}
#                    -DOPENSSL_LIBRARIES=${OPENSSL_INSTALL_DIR}/lib
#                    -DCMAKE_PROJECT_brpc_INCLUDE=${PROJ_THIRD_PARTY_UNZIP_DIR}/brpc_include.cmake
#                    -DWITH_THRIFT=${BUILD_BRPC_WITH_THRIFT}
#                    -DWITH_GLOG=ON
#                    -DCMAKE_INSTALL_LIBDIR=lib
#   BUILD_IN_SOURCE 1
# )

# add_library(brpc STATIC IMPORTED GLOBAL)
# set_property(TARGET brpc PROPERTY 
#              IMPORTED_LOCATION ${BRPC_LIBRARIES}
# )
