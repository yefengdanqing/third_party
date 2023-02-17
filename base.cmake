set(DEPS_INSTALL_DIR "/tmp/third_party" CACHE STRING "library install prefix")
set(DEPS_PREFIX "/tmp/third_party" CACHE STRING "library install prefix")
option(BUILD_DEPS "build and install deps" ON)
option(BUILD_GCC "build gcc" OFF)

include(FetchContent)
set(FETCHCONTENT_BASE_DIR "${DEPS_INSTALL_DIR}")
include(ExternalProject)

find_program(MAKE_EXECUTABLE NAMES make gmake mingw32-make REQUIRED)

function(get_cmake_args)
    #string(REPLACE ";" "|" CMAKE_PREFIX_PATH_STR "${CMAKE_PREFIX_PATH}")
    #string(REPLACE ";" "\\;" CMAKE_PREFIX_PATH_STR "${CMAKE_PREFIX_PATH}")
    set(CMAKE_ARGS
            #-DCMAKE_PREFIX_PATH=$<CMAKE_PREFIX_PATH>
            -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
            -DCMAKE_BUILD_TYPE=Release
            -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_DIR}/${DEP_NAME}
            -DCMAKE_INSTALL_LIBDIR=lib
            -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DBUILD_STATIC_LIB=OFF
            -DBUILD_SHARED_LIB=ON PARENT_SCOPE)
endfunction(get_cmake_args)



find_program(MAKE_EXECUTABLE NAMES make gmake mingw32-make REQUIRED)



# 建议使用压缩包的方式依赖，下载速度更快
function(thirdparty_in_fetchcontent)
    message("thirdparty_in_fetchcontent")
endfunction(thirdparty_in_fetchcontent)



