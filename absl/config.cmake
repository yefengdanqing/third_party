INCLUDE(ExternalProject)

set(ABSL_INSTALL_DIR "${PROJECT_BINARY_DIR}/third_party/absl")
set(ABSL_INCLUDE_DIR "${ABSL_INSTALL_DIR}/include" CACHE PATH "absl include directory." FORCE)
set(ABSL_LIBRARIES   "${ABSL_INSTALL_DIR}/lib/libabsl_bad_any_cast_impl.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_strings.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_strings_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_str_format_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_time.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_time_zone.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_civil_time.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_bad_optional_access.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_bad_variant_access.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_base.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_city.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_cord.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_cord_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_cordz_functions.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_cordz_handle.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_cordz_info.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_cordz_sample_token.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_debugging_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_demangle_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_examine_stack.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_exponential_biased.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_failure_signal_handler.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_commandlineflag.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_commandlineflag_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_config.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_marshalling.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_parse.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_private_handle_accessor.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_program_name.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_reflection.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_usage.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_flags_usage_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_graphcycles_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_hash.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_hashtablez_sampler.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_int128.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_leak_check.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_leak_check_disable.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_log_severity.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_low_level_hash.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_malloc_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_periodic_sampler.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_distributions.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_distribution_test_util.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_platform.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_pool_urbg.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_randen.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_randen_hwaes.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_randen_hwaes_impl.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_randen_slow.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_internal_seed_material.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_seed_gen_exception.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_random_seed_sequences.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_raw_hash_set.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_raw_logging_internal.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_scoped_set_env.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_spinlock_wait.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_stacktrace.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_status.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_statusor.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_strerror.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_symbolize.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_synchronization.a"
                "${ABSL_INSTALL_DIR}/lib/libabsl_throw_delegate.a"
 CACHE FILEPATH "ABSL_LIBRARIES" FORCE)

include_directories(SYSTEM ${ABSL_INCLUDE_DIR})

set(ABSL_VERSION "abseil-cpp-20211102.0")
execute_process(
	  COMMAND bash -c "tar -xvzf ${PROJ_THIRD_PARTY_DIR}/absl/${ABSL_VERSION}.tar.gz -C ${PROJ_THIRD_PARTY_UNZIP_DIR}"
    RESULT_VARIABLE ABSL_SOURCE_UNZIP_SUCCESS
)

if(NOT "${ABSL_SOURCE_UNZIP_SUCCESS}" STREQUAL "0")
    message(FATAL_ERROR "unzip && patch tar failed -> ${ABSL_SOURCE_UNZIP_SUCCESS}")
endif()

message(FATAL_ERROR, "${PROJ_THIRD_PARTY_UNZIP_DIR}/${ABSL_VERSION}")
include_directories(${ABSL_INSTALL_DIR})
ExternalProject_Add(
  absl_absl
  SOURCE_DIR       "${PROJ_THIRD_PARTY_UNZIP_DIR}/${ABSL_VERSION}"
  BUILD_BYPRODUCTS ${ABSL_LIBRARIES}
  CMAKE_ARGS       -DCMAKE_POSITION_INDEPENDENT_CODE=ON
                   -DABSL_BUILD_BENCHMARKS=OFF
                   -DABSL_BUILD_TESTS=OFF
                   -DCMAKE_INSTALL_LIBDIR=lib
                   -DCMAKE_INSTALL_PREFIX=${ABSL_INSTALL_DIR}
                   -DABSL_PROPAGATE_CXX_STD=ON
                   -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
                   ${THIRD_PARTY_EXTRA_CMAKE_ARGS}
  BUILD_IN_SOURCE 1
)

message("ABSL_LIBRARIES = ${ABSL_LIBRARIES}")
add_library(absl STATIC IMPORTED GLOBAL)
set_property(TARGET absl PROPERTY IMPORTED_LOCATION ${ABSL_LIBRARIES})
add_dependencies(absl absl_absl)
