# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
#[=======================================================================[.rst:
FindGLFW
-------

Finds the GLFW library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``GLFW::GLFW``
  The GLFW library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``GLFW_FOUND``
  True if the system has the GLFW library.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``GLFW_INCLUDE_DIR``
  The directory containing ``glfw3.h``.
``GLFW_LIBRARY``
  The path to the GLFW library.
#]=======================================================================]
find_package(PkgConfig)
if (PkgConfig_FOUND)
	pkg_search_module(_glfw QUIET glfw3)
	find_path(GLFW_INCLUDE_DIR
		NAMES glfw3.h
		PATHS ${_glfw_INCLUDE_DIRS}
	)
	
	find_library(GLFW_LIBRARY
		NAMES glfw
		PATHS ${_glfw_LIBRARY_DIRS}
	)
else()
	find_path(GLFW_INCLUDE_DIR
		NAMES glfw3.h
	)
		
	find_library(GLFW_LIBRARY
		NAMES glfw
	)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLFW
	FOUND_VAR GLFW_FOUND
	REQUIRED_VARS GLFW_INCLUDE_DIR GLFW_LIBRARY
	VERSION_VAR _glfw_VERSION
)

if (GLFW_FOUND AND NOT TARGET GLFW::GLFW)
	add_library(GLFW::GLFW UNKNOWN IMPORTED)
	set_target_properties(GLFW::GLFW PROPERTIES 
		INTERFACE_INCLUDE_DIRECTORIES "${GLFW_INCLUDE_DIR}"
		IMPORTED_LOCATION "${GLFW_LIBRARY}"
	)	
endif()

mark_as_advanced(GLFW_INCLUDE_DIR GLFW_LIBRARY)