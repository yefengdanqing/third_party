include(${CMAKE_CURRENT_LIST_DIR}/../base.cmake)

set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)
set(BOOST_INCLUDE_LIBRARIES thread filesystem system)
set(BOOST_ENABLE_CMAKE ON)
set(FETCHCONTENT_QUIET FALSE)

include(FetchContent)

FetchContent_Declare(
  boost
  GIT_REPOSITORY https://github.com/boostorg/boost.git
  GIT_TAG boost-1.81.0
)
FetchContent_MakeAvailable(boost)
include_directories(${boost_SOURCE_DIR}/include)