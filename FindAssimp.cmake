# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#[=======================================================================[.rst:
FindGLFW
-------

Finds the Assimp library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``Assimp::Assimp``
  The Assimp library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``Assimp_FOUND``
  True if the system has the Assimp library.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``Assimp_INCLUDE_DIR``
  The directory containing ``assimp/anim.h``.
``Assimp_LIBRARY``
  The path to the Assimp library.
#]=======================================================================]
if (WIN32)
	set(Assimp_LIBNAME "assimp-vc${MSVC_TOOLSET_VERSION}-mt")
else()
	set(Assimp_LIBNAME "assimp")
endif()
message(VERBOSE "Searching for library with name ${Assimp_LIBNAME}")

find_package(PkgConfig)
pkg_search_module(_assimp QUIET assimp)
find_path(Assimp_INCLUDE_DIR
	NAMES assimp/anim.h
	PATHS ${_assimp_INCLUDE_DIRS}
)

find_library(Assimp_LIBRARY
	NAMES ${Assimp_LIBNAME}
	PATHS ${_assimp_LIBRARY_DIRS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Assimp
	FOUND_VAR Assimp_FOUND
	REQUIRED_VARS Assimp_INCLUDE_DIR Assimp_LIBRARY
	VERSION_VAR _assimp_VERSION
)

if (Assimp_FOUND AND NOT TARGET Assimp::Assimp)
	add_library(Assimp::Assimp UNKNOWN IMPORTED)
	set_target_properties(Assimp::Assimp PROPERTIES 
		INTERFACE_INCLUDE_DIRECTORIES "${Assimp_INCLUDE_DIR}"
		INTERFACE_COMPILE_OPTIONS "${_assimp_CFLAGS_OTHER}"
		IMPORTED_LOCATION "${Assimp_LIBRARY}"
	)	
endif()

mark_as_advanced(Assimp_INCLUDE_DIR Assimp_LIBRARY)