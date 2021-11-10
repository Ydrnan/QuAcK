cmake_minimum_required(VERSION 3.14)

project(QuAcK_Titou LANGUAGES Fortran)

include_directories(include)

add_subdirectory(src)

find_package(BLAS REQUIRED COMPONENTS Fortran)
find_package(LAPACK REQUIRED COMPONENTS Fortran)

