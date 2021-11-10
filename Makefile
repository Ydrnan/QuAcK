default:
	./autobuild.sh
	export FC=ifort CC=icx CXX=icpx;\
	cmake -S. -Bbuild;\
	cmake --build build -- VERBOSE=1

clean:
	cmake --build build --target clean
