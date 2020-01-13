# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#[=======================================================================[.rst:
FindZip
-------

Finds the Zip library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``Zip::libzip``
  The Zip library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``Zip_FOUND``
  True if the system has the Zip library.
``Zip_VERSION``
  The version of the Zip library which was found.
``Zip_INCLUDE_DIRS``
  Include directories needed to use Zip.
``Zip_LIBRARIES``
  Libraries needed to link to Zip.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``Zip_INCLUDE_DIR``
  The directory containing ``Zip.h``.
``Zip_LIBRARY``
  The path to the Zip library.

#]=======================================================================]
find_package(PkgConfig)
pkg_search_module(_Zip QUIET libzip)

find_path(Zip_INCLUDE_DIR
	NAMES zip.h
	PATHS ${_Zip_INCLUDE_DIRS}
)

find_library(Zip_LIBRARY
	NAMES zip
	PATHS ${_Zip_LIBRARY_DIRS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Zip
	FOUND_VAR Zip_FOUND
	REQUIRED_VARS
		Zip_LIBRARY
		Zip_INCLUDE_DIR
	VERSION_VAR _Zip_VERSION
)

if (Zip_FOUND AND NOT TARGET Zip::libzip)
	add_library(Zip::libzip UNKNOWN IMPORTED)
	set_target_properties(Zip::libzip PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES ${Zip_INCLUDE_DIR}
		IMPORTED_LOCATION ${Zip_LIBRARY}
	)
endif()

mark_as_advanced(Zip_INCLUDE_DIR Zip_LIBRARY)
set(Zip_INCLUDE_DIRS ${Zip_INCLUDE_DIR})
set(Zip_LIBRARIES ${Zip_LIBRARY})
set(Zip_VERSION ${_Zip_VERSION})