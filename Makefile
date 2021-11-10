default:
	./autobuild.sh
	cmake -S. -Bbuild
	cmake --build build #-- VERBOSE=1

clean:
	cmake --build build --target clean
