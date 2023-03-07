include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)
set(CMAKE_CXX_STANDARD 17)

include(ExternalProject)
set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(PROTOBUF_ROOT ${THIRD_PARTY_PREFIX}/protobuf)
set(PROTOBUF_LIB_DIR       ${PROTOBUF_ROOT}/lib)
set(PROTOBUF_INCLUDE_DIR   ${PROTOBUF_ROOT}/include)
set(PROTOBUF_BIN_DIR       ${PROTOBUF_ROOT}/bin)
set(PBUF_PROTOC            ${PROTOBUF_BIN_DIR}/protoc)

message("skt lib64: ${PROTOBUF_LIB_DIR}")
include_directories(${PROTOBUF_INCLUDE_DIR})
LINK_DIRECTORIES(${PROTOBUF_LIB_DIR})
set(PROTOBUF_GIT_TAG  v3.21.3)  # 指定版本
set(PROTOBUF_GIT_URL  https://github.com/protocolbuffers/protobuf.git) 



ExternalProject_Add(PROTOBUF
        PREFIX                  ${PROTOBUF_ROOT}
        GIT_REPOSITORY          ${PROTOBUF_GIT_URL}
        GIT_TAG                 ${PROTOBUF_GIT_TAG}
        CONFIGURE_COMMAND       cd ${PROTOBUF_ROOT}/src/PROTOBUF && cmake 
                                -D CMAKE_INSTALL_PREFIX=${PROTOBUF_ROOT} -DBUILD_SHARED_LIBS=ON 
                                -DCMAKE_INSTALL_LIBDIR=lib .
        BUILD_COMMAND           cd ${PROTOBUF_ROOT}/src/PROTOBUF && make -j8
        INSTALL_COMMAND         cd ${PROTOBUF_ROOT}/src/PROTOBUF && make install
)


ADD_LIBRARY(protobuf STATIC IMPORTED GLOBAL)
SET_PROPERTY(TARGET protobuf PROPERTY IMPORTED_LOCATION ${PROTOBUF_LIB_DIR}/libprotobuf.so)
#SET_PROPERTY(TARGET protobuf PROPERTY IMPORTED_LOCATION ${PROTOBUF_LIB_DIR}/libprotoc.a)
add_dependencies(protobuf PROTOBUF)
