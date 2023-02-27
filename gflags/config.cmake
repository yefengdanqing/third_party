include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)

set(BOOST_ENABLE_CMAKE ON)
set(FETCHCONTENT_QUIET FALSE)

include(FetchContent)

FetchContent_Declare(gflags
	GIT_REPOSITORY	https://github.com/gflags/gflags.git
	GIT_TAG			master
)

FetchContent_MakeAvailable(gflags)


include_directories(${gflags_BINARY_DIR}/include)
message("skt gflags dir ${gflags_SOURCE_DIR} ${gflags_BINARY_DIR}")
link_directories(${gflags_BINARY_DIR})
message("module path: ${CMAKE_MODULE_PATH}")
#set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH};${gflags_BINARY_DIR})
message("module path: ${CMAKE_MODULE_PATH}")






# INCLUDE(ExternalProject)

# set(GFLAGS_INSTALL_DIR "${PROJECT_BINARY_DIR}/third_party/gflags")
# set(GFLAGS_INCLUDE_DIR "${GFLAGS_INSTALL_DIR}/include" CACHE PATH "gflags include directory." FORCE)
# set(GFLAGS_LIBRARIES "${GFLAGS_INSTALL_DIR}/lib/libgflags.a" CACHE FILEPATH "GFLAGS_LIBRARIES" FORCE)

# include_directories(SYSTEM ${GFLAGS_INCLUDE_DIR})

# execute_process(
#     COMMAND bash -c "tar -xvzf ${PROJ_THIRD_PARTY_DIR}/gflags/gflags-2.2.2.tar.gz -C ${PROJ_THIRD_PARTY_UNZIP_DIR} && patch -d ${PROJ_THIRD_PARTY_UNZIP_DIR}/gflags-2.2.2 -p0 < ${PROJ_THIRD_PARTY_DIR}/gflags/mod.diff"
#     RESULT_VARIABLE GFLAGS_SOURCE_UNZIP_SUCCESS
# )

# if(NOT "${GFLAGS_SOURCE_UNZIP_SUCCESS}" STREQUAL "0")
#     message(FATAL_ERROR "unzip && patch tar failed -> ${GFLAGS_SOURCE_UNZIP_SUCCESS}")
# endif()

# ExternalProject_Add(
#   gflags_gflags
#   SOURCE_DIR       "${PROJ_THIRD_PARTY_UNZIP_DIR}/gflags-2.2.2"
#   BUILD_BYPRODUCTS ${GFLAGS_LIBRARIES}
#   CMAKE_ARGS       -DCMAKE_INSTALL_PREFIX=${GFLAGS_INSTALL_DIR}
#                    -DBUILD_STATIC_LIBS=ON
#                    -DBUILD_TESTING=OFF
#                    -DGFLAGS_NAMESPACE=google
# 		               -DCMAKE_POSITION_INDEPENDENT_CODE=ON
#                    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#                    -DCMAKE_GENERATOR=${CMAKE_GENERATOR}
#                    ${THIRD_PARTY_EXTRA_CMAKE_ARGS}
#   BUILD_IN_SOURCE 1
# )

# add_library(gflags STATIC IMPORTED GLOBAL)
# set_property(TARGET gflags PROPERTY IMPORTED_LOCATION ${GFLAGS_LIBRARIES})
# add_dependencies(gflags gflags_gflags)
