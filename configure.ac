AC_PREREQ([2.69])

AC_INIT([QuAcK], [0.0.1], [])
AM_INIT_AUTOMAKE([foreign subdir-objects silent-rules])

AX_BLAS([],[ AC_MSG_ERROR("BLAS not found.") ])
AX_LAPACK([],[ AC_MSG_ERROR("LAPACK not found.") ])
LIBS="$LIBS $BLAS_LIBS $LAPACK_LIBS"

# Language
AC_LANG(Fortran)

# Checks for programs.
AC_PROG_FC
AC_PROG_CC
AC_PROG_CXX
#AC_REQUIRE([AC_CXX_LIBRARY_LDFLAGS])

#AC_CHECK_PROGS(CMAKE, [cmake], ["not_found"])
#AS_IF([test "x$CMAKE" = "xnot_found"], [
#					   AC_MSG_ERROR("CMake not found. Version >3.0 required")
#					   ])
AC_PROG_MAKE_SET

# Checks for libraries.
AC_CONFIG_MACRO_DIR([m4])
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
