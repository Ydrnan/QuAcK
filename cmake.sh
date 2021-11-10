#!/bin/sh

./autobuild.sh
cmake -S. -Bbuild
cmake --build build #-- VERBOSE=1
