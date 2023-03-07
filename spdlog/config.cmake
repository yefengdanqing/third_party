set(THIRD_PARTY_PREFIX ${CMAKE_BINARY_DIR}/third_party)

include(ExternalProject)
message("start compile spdlog")

set(SPDLOG_ROOT ${CMAKE_BINARY_DIR}/third_party/spdlog)
set(SPDLOG_LIB       ${SPDLOG_ROOT}/lib/spdlog)
set(SPDLOG_INCLUDE_DIR   ${SPDLOG_ROOT}/include)

include_directories(${SPDLOG_INCLUDE_DIR})
link_directories(${SPDLOG_LIB})

set(SPDLOG_GIT_TAG  v1.4.1)  # 指定版本
set(SPDLOG_GIT_URL      https://github.com/gabime/spdlog.git)
set(SPDLOG_CONFIGURE    cd ${SPDLOG_ROOT}/src/SDPLOG && cmake -DCMAKE_INSTALL_PREFIX=${SPDLOG_ROOT} .)
set(SPDLOG_MAKE         cd ${SPDLOG_ROOT}/src/SDPLOG && make)
set(SPDLOG_INSTALL      cd ${SPDLOG_ROOT}/src/SDPLOG && make install)
#为啥一定是大写呢
ExternalProject_Add(SDPLOG
        PREFIX            ${SPDLOG_ROOT}
        GIT_REPOSITORY    ${SPDLOG_GIT_URL}
        GIT_TAG           ${SPDLOG_GIT_TAG}
        CONFIGURE_COMMAND ${SPDLOG_CONFIGURE}
        BUILD_COMMAND     ${SPDLOG_MAKE}
        INSTALL_COMMAND   ${SPDLOG_INSTALL}
)


message("finish compile spdlog")