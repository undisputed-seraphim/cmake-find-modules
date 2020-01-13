# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#[=======================================================================[.rst:
FindLZ4
-------

Finds the LZ4 library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``LZ4::LZ4``
  The LZ4 library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``LZ4_FOUND``
  True if the system has the LZ4 library.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``LZ4_INCLUDE_DIR``
  The directory containing ``lz4.h``.
``LZ4_LIBRARY``
  The path to the LZ4 library.
#]=======================================================================]

find_path(LZ4_INCLUDE_DIR
	NAMES lz4.h
)
	
find_library(LZ4_LIBRARY
	NAMES lz4 lz4_static liblz4_static
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LZ4
	FOUND_VAR LZ4_FOUND
	REQUIRED_VARS LZ4_INCLUDE_DIR LZ4_LIBRARY
)

if (LZ4_FOUND AND NOT TARGET LZ4::LZ4)
	add_library(LZ4::LZ4 UNKNOWN IMPORTED)
	set_target_properties(LZ4::LZ4 PROPERTIES 
		INTERFACE_INCLUDE_DIRECTORIES "${LZ4_INCLUDE_DIR}"
		IMPORTED_LOCATION "${LZ4_LIBRARY}"
	)	
endif()

mark_as_advanced(LZ4_INCLUDE_DIR LZ4_LIBRARY)