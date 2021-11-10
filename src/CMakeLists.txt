add_executable(pouet QuAcK.f90 read_methods.f90 read_options.f90)

add_subdirectory(ADC)
add_subdirectory(AOtoMO)
add_subdirectory(BasCor)
add_subdirectory(CC)
add_subdirectory(CI)
add_subdirectory(eDFT)
add_subdirectory(GF)
add_subdirectory(HF)
add_subdirectory(LR)
add_subdirectory(MBPT)
add_subdirectory(MC)
add_subdirectory(MP)
add_subdirectory(numgrid)
add_subdirectory(RPA)
add_subdirectory(utils)

target_link_libraries(pouet
	PRIVATE
		ADC
		AOtoMO
		BasCor
		CC
		CI
		eDFT
		GF
		HF
		LR
		MBPT
		MC
		MP
		numgrid
		RPA
		utils	
		BLAS_LIBRARIES
		LAPACK_LIBRARIES
		)
