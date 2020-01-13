# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#[=======================================================================[.rst:
FindRealsense
-------

Finds the librealsense library, for Intel Realsense camera devices.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``Realsense::Realsense``
  The Realsense library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``Realsense_FOUND``
  True if the system has the Realsense library.
``Realsense_VERSION``
  The version of the Realsense library which was found.
``Realsense_INCLUDE_DIRS``
  Include directories needed to use Realsense.
``Realsense_LIBRARIES``
  Libraries needed to link to Realsense.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``Realsense_INCLUDE_DIR``
  The directory containing ``rs.h``.
``Realsense_LIBRARY``
  The path to the Realsense library.

#]=======================================================================]

find_path(Realsense_INCLUDE_DIR
	NAMES librealsense2/rs.h
)

find_library(Realsense_LIBRARY
	NAMES realsense2
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Realsense
	FOUND_VAR Realsense_FOUND
	REQUIRED_VARS
		Realsense_LIBRARY
		Realsense_INCLUDE_DIR
	VERSION_VAR Realsense_VERSION
)

if (Realsense_FOUND)
	message(STATUS "Realsense SDK ${Realsense_VERSION}")
	add_library(Realsense::Realsense UNKNOWN IMPORTED)
	set_target_properties(Realsense::Realsense PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${Realsense_INCLUDE_DIR}"
		IMPORTED_LOCATION "${Realsense_LIBRARY}"
	)
endif()

mark_as_advanced(Realsense_INCLUDE_DIR Realsense_LIBRARY)