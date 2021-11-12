AC_PREREQ([2.69])

AC_INIT([QuAcK], [0.0.1], [])
AM_INIT_AUTOMAKE([foreign subdir-objects silent-rules])
GIT_HASH=`git log | head -1 | cut -d ' ' -f 2`

AX_BLAS([],[ AC_MSG_ERROR("BLAS not found.") ])
AX_LAPACK([],[ AC_MSG_ERROR("LAPACK not found.") ])
LIBS="$LIBS $BLAS_LIBS $LAPACK_LIBS"

# Language
AC_LANG(Fortran)

# Checks for programs.
AC_PROG_FC
AC_PROG_CC
AC_PROG_CXX

# Debug options with --enable-debug
AC_ARG_ENABLE(debug, [AS_HELP_STRING([--enable-debug],[compile for debugging])], ok=$enableval, ok=no)
if test "$ok" = "yes"; then
        if test "$GCC" = "yes"; then
	        CFLAGS="$CFLAGS \
-Wall -W -Wbad-function-cast -Wcast-qual \
-Wpointer-arith -Wcast-align -Wpedantic -Wextra -fmax-errors=3"
        fi
        if test "$GFC" = "yes"; then
	        FCFLAGS="$FCFLAGS \
-fcheck=all -Waliasing -Wampersand -Wconversion \
-Wsurprising -ffpe-trap=zero,overflow,underflow \
-Wintrinsics-std -Wno-tabs -Wintrinsic-shadow -Wline-truncation \
-Wreal-q-constant -Wuninitialized  -fbacktrace -finit-real=nan"
        fi
        if test "$FC" = "ifort"; then
	        FCFLAGS="$FCFLAGS \
-traceback -check all -debug all -fpe-all=0  -implicitnone"
        fi
	AC_DEFINE(DEBUG,1,[Define to turn on debugging checks])
        ARGS="${ARGS} debug"
fi

#AC_REQUIRE([AC_CXX_LIBRARY_LDFLAGS])

#AC_CHECK_PROGS(CMAKE, [cmake], ["not_found"])
#AS_IF([test "x$CMAKE" = "xnot_found"], [
#					   AC_MSG_ERROR("CMake not found. Version >3.0 required")
#					   ])
AC_PROG_MAKE_SET

# Checks for libraries.
AC_CONFIG_MACRO_DIR([m4])

# Checks for numgrid
AC_ARG_WITH([numgrid],[AS_HELP_STRING([--with-numgrid=<lib>],[Activate numgrid for QuAcK])])

AS_IF([test "x$with_numgrid" != "xno"], [
	AS_IF([test "x$with_numgrid" == "x"],[],[
  AS_IF([test "x$with_numgrid" == "xyes"], [
	NUMGRID_LIBS="-lnumgrid"
  ],[
    NUMGRID_LIBS=$with_numgrid
])
    AC_SEARCH_LIBS([numgrid_free_atom_grid],[$NUMGRID_LIBS],[],[AC_MSG_ERROR("Numgrid not found")])
])])

LIBS="$LIBS $NUMGRID_LIBS"

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile])

AC_OUTPUT

echo \
"
                                       __     
                                     <(o )___ 
                                      ( ._> /
     quack                             quack                     qua     ack
  quac   uack                         qua  qua                   qua   ack
 quac     uack                       qua    qua                  qua ack
quack     quack    qua   qua        quackququack         quack   quack
 quac     uack     qua   qua       qua        qua      qua       qua ack
  quac   uack      qua  quack     qua          qua     qua       qua   ack
     quack quac      quack  ck   quack         quack     quack   qua     ack
             quac         
==================================================
${PACKAGE_NAME} Version ${PACKAGE_VERSION}

FC ............:  ${FC}
FCFLAGS .......:  ${FCFLAGS}
CC ............:  ${CC}
CFLAGS ........:  ${CFLAGS}
CXX ...........:  ${CXX}
CXXFLAGS ......:  ${CXXFLAGS}
LDFLAGS .......:  ${LDFLAGS}
LIBS ..........:  ${LIBS}
==================================================
"


