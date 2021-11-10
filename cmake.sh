#!/bin/sh

./autobuild.sh
FC=ifort cmake -S. -Bbuild
cmake --build build -- VERBOSE=1
