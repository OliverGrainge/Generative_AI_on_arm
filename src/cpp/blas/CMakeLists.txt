# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

# Project name and version
project(BlasScalingBenchmark VERSION 1.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Specify the executable
add_executable(blas_scaling_benchmark benchmark_f32.cpp)

# Find and link BLAS library
find_package(BLAS REQUIRED)
if (BLAS_FOUND)
    target_link_libraries(blas_scaling_benchmark PUBLIC ${BLAS_LIBRARIES})
else()
    message(FATAL_ERROR "BLAS library not found!")
endif()

# Include BLAS directories if required
if (BLAS_INCLUDE_DIRS)
    target_include_directories(blas_scaling_benchmark PUBLIC ${BLAS_INCLUDE_DIRS})
endif()

# Add any additional compiler flags if needed
target_compile_options(blas_scaling_benchmark PRIVATE -march=armv8.4-a+sve -mtune=neoverse-v1)


# Specify the output directory for binaries
set_target_properties(blas_scaling_benchmark PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
