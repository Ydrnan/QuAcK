#!/bin/sh

cd src
for i in $(ls -d */)
do
		cd ${i}
		cp ../../update_cmakelists.sh .
		./update_cmakelists.sh > CMakeLists.txt
		cd ..
done
cd ..
