# Minimum version required
cmake_minimum_required(VERSION 3.14)
set(ENV{FC} "/opt/intel/oneapi/compiler/2021.4.0/linux/bin/intel64/ifort")

project(QuAcK_Titou LANGUAGES Fortran C)

include(CMakePrintHelpers)

cmake_print_variables(CMAKE_Fortran_COMPILER_ID CMAKE_Fortran_COMPILER_VERSION)
#cmake_print_variables(CMAKE_C_COMPILER_ID CMAKE_C_COMPILER_VERSION)


set(CMAKE_VERBOSE_MAKEFILE ON)

include_directories(include)

add_subdirectory(src)

set(BLA_VENDOR Intel10_64ilp)
#set(CMAKE_Fortran_FLAGS -lmkl)
find_package(MKL)
#find_package(LAPACK REQUIRED COMPONENTS Fortran)

set(CMAKE_Fortran_FLAGS "-assume byterecl -heap-arrays -mkl=parallel -O3 -g")
link_libraries(${MKL_LIBRARIES})
#link_libraries(${LAPACK_LIBRARIES})
link_libraries(mkl_intel_lp64)

#find_package(BLAS REQUIRED COMPONENTS Fortran)
#find_package(LAPACK REQUIRED COMPONENTS Fortran)
