#!/bin/sh

echo ''
echo '#====================================================================='
echo '#   Auto build of CMakeLists.txt to make a library from a directory'
echo '#====================================================================='
echo ''

echo 'add_library('$(basename "$PWD")')'
echo ''
echo 'target_sources('$(basename "$PWD")
echo '	PRIVATE'
echo "$(ls *.f90)"
echo '	)'

echo ''
echo '#========='
echo '#   End'
echo '#========='

