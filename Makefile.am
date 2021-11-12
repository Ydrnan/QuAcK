bin_PROGRAMS = quack

quack_SOURCES = $(SOURCES)

EXTRA_DIST =
SOURCES =

include src/CC/Makefile.am.include
include src/QuAcK/Makefile.am.include
include src/utils/Makefile.am.include
include src/RPA/Makefile.am.include
include src/MC/Makefile.am.include
include src/MBPT/Makefile.am.include
include src/LR/Makefile.am.include
include src/Makefile.am.include
include src/CI/Makefile.am.include
include src/HF/Makefile.am.include
include src/ADC/Makefile.am.include
include src/BasCor/Makefile.am.include
include src/AOtoMO/Makefile.am.include
include src/GF/Makefile.am.include
include src/MP/Makefile.am.include

edft_SOURCES = 

#include src/numgrid/Makefile.am.include
#include src/eDFT/Makefile.am.include

quack_FCFLAGS = -I$(srcdir)/include/

# library for numgrid
include Makefile.am.numgrid
#quack_LDADD = $(numgriddir)/libnumgrid.a  -lstdc++

#quack_LDADD = -lnumgrid #-lstdc++
#quack_LDADD = /home/yannd/.local/lib/python3.7/site-packages/numgrid.cpython-37m-x86_64-linux-gnu.so
