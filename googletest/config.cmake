set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(GTEST_ROOT ${THIRD_PARTY_PREFIX}/googletest)
set(GTEST_LIB       ${GTEST_ROOT}/lib)
set(GTEST_INCLUDE_DIR   ${GTEST_ROOT}/include)
include_directories(${GTEST_INCLUDE_DIR})
link_directories(${GTEST_LIB})


include(ExternalProject)
ExternalProject_Add(GOOGLETEST
        PREFIX                  ${GTEST_ROOT}
        GIT_REPOSITORY          https://github.com/google/googletest.git
        GIT_TAG                 main
        CONFIGURE_COMMAND       cd ${GTEST_ROOT}/src/GOOGLETEST && cmake 
                                -D CMAKE_INSTALL_PREFIX=${GTEST_ROOT} -DBUILD_SHARED_LIBS=ON 
                                -DCMAKE_INSTALL_LIBDIR=lib .
        BUILD_COMMAND           cd ${GTEST_ROOT}/src/GOOGLETEST && make -j8
        INSTALL_COMMAND         cd ${GTEST_ROOT}/src/GOOGLETEST && make install
)
