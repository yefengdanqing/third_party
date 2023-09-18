cmake_minimum_required(VERSION 3.17)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)


set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(FMT_ROOT ${THIRD_PARTY_PREFIX}/fmt)

set(FMT_LIB       ${FMT_ROOT}/lib)
set(FMT_INCLUDE_DIR   ${FMT_ROOT}/include)
include_directories(${FMT_INCLUDE_DIR})
link_directories(${FMT_LIB})


include(ExternalProject)
ExternalProject_Add(FMT
        PREFIX                  ${FMT_ROOT}
        GIT_REPOSITORY          https://github.com/fmtlib/fmt.git
        GIT_TAG                 master
        CONFIGURE_COMMAND       cd ${FMT_ROOT}/src/FMT && cmake 
                                -D CMAKE_INSTALL_PREFIX=${FMT_ROOT} -DBUILD_SHARED_LIBS=ON 
                                -DCMAKE_INSTALL_LIBDIR=lib .
        BUILD_COMMAND           cd ${FMT_ROOT}/src/FMT && make -j8
        INSTALL_COMMAND         cd ${FMT_ROOT}/src/FMT && make install
)



