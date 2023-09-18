include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)
set(CMAKE_CXX_STANDARD 17)

INCLUDE(ExternalProject)

set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(PROTOBUF_ROOT ${THIRD_PARTY_PREFIX}/protobuf)

file(MAKE_DIRECTORY ${PROTOBUF_ROOT})

set(PROTOBUF_LIB_DIR       ${PROTOBUF_ROOT}/lib)
set(PROTOBUF_INCLUDE_DIR   ${PROTOBUF_ROOT}/include)
set(PROTOBUF_BIN_DIR       ${PROTOBUF_ROOT}/bin)
set(PBUF_PROTOC            ${PROTOBUF_BIN_DIR}/protoc)


#set(PROTOBUF_LIBRARIES "${PROTOBUF_LIB_DIR}" CACHE FILEPATH "PROTOBUF_LIBRARIES" FORCE)
#include_directories(SYSTEM ${PROTOBUF_INCLUDE_DIR})

include_directories(${PROTOBUF_INCLUDE_DIR})
link_directories(${PROTOBUF_LIB_DIR})
set(PROTOBUF_INCLUDE_DIRS ${PROTOBUF_INCLUDE_DIR})
set(PROTOBUF_LIBRARIES ${PROTOBUF_LIB_DIR})


set(PROTOBUF_VERSION "protobuf-3.5.1")

execute_process(
    COMMAND tar -xvzf ${PROJECT_SOURCE_DIR}/third_party/protobuf/${PROTOBUF_VERSION}.tar.gz -C ${PROTOBUF_ROOT}
    RESULT_VARIABLE PROTOBUF_SOURCE_UNZIP_SUCCESS
)

if(NOT "${PROTOBUF_SOURCE_UNZIP_SUCCESS}" STREQUAL "0")
    message(FATAL_ERROR "unzip && patch tar failed -> ${PROTOBUF_SOURCE_UNZIP_SUCCESS}")
endif()



ExternalProject_Add(
  PROTOBUF
  SOURCE_DIR          "${PROTOBUF_ROOT}/${PROTOBUF_VERSION}"
  #BUILD_BYPRODUCTS    ${PROTOBUF_LIBRARIES}
  CONFIGURE_COMMAND   cd <SOURCE_DIR> && ${CMAKE_COMMAND} -DCMAKE_SKIP_RPATH=ON
                        -Dprotobuf_BUILD_TESTS=OFF
                        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
                        -DCMAKE_INSTALL_PREFIX=${PROTOBUF_ROOT}
                        -DCMAKE_PREFIX_PATH=${PROTOBUF_ROOT}
                        -DCMAKE_INSTALL_LIBDIR=lib
                        -DBUILD_SHARED_LIBS=OFF
                        ./cmake
  UPDATE_COMMAND      ""
  BUILD_COMMAND       cd <SOURCE_DIR> && make -j8 && make install
  BUILD_IN_SOURCE 1
)

#怎么解决export ld_library_path的问题
message("PROTOBUF_LIBRARIES = [${PROTOBUF_LIBRARIES}][${PROTOBUF_LIB_DIR}]")
set(protobuf_lib_info ${PROTOBUF_LIB_DIR}/libprotobuf.a)

#需要编译成静态库,protoc也需要依赖
add_library(protobuf STATIC IMPORTED GLOBAL)
set_property(TARGET protobuf PROPERTY IMPORTED_LOCATION ${protobuf_lib_info})
add_dependencies(protobuf PROTOBUF)

list(FIND CMAKE_PREFIX_PATH ${PROTOBUF_ROOT} _DEP_INDEX)
if (_DEP_INDEX EQUAL -1)
    list(APPEND CMAKE_PREFIX_PATH ${PROTOBUF_ROOT})
endif ()
