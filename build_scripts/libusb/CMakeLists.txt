cmake_minimum_required(VERSION 3.10)
project(usb VERSION 1.0.23 LANGUAGES C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(LIBUSB_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/libusb-${PROJECT_VERSION}")

file(GLOB usb_src ${LIBUSB_ROOT}/libusb/*.[c,h])
if (MSVC)
	file(GLOB usb_src_os ${LIBUSB_ROOT}/libusb/os/*windows*)
	set(usb_src ${usb_src};${LIBUSB_ROOT}/libusb/libusb-1.0.rc)
	set_source_files_properties(${LIBUSB_ROOT}/libusb/libusb-1.0.rc PROPERTIES LANGUAGE RC)
	set(msvc_def ${LIBUSB_ROOT}/libusb/libusb-1.0.def)
	set(CMAKE_LINK_DEF_FILE_FLAG ${msvc_def})
	set(config_incl ${LIBUSB_ROOT}/msvc)
endif()

add_library(usb-static STATIC ${usb_src} ${usb_src_os} ${usb_config})
target_include_directories(usb-static PRIVATE ${config_incl} ${LIBUSB_ROOT}/libusb/)
set_target_properties(usb-static PROPERTIES OUTPUT_NAME libusb-1.0)

add_library(usb-shared SHARED ${usb_src} ${usb_src_os} ${usb_config} ${msvc_def})
target_include_directories(usb-shared PRIVATE ${config_incl} ${LIBUSB_ROOT}/libusb/)
set_target_properties(usb-shared PROPERTIES OUTPUT_NAME libusb-1.0)

include(GNUInstallDirs)
set(prefix "${CMAKE_INSTALL_PREFIX}")
set(exec_prefix "\$\{prefix\}/${CMAKE_INSTALL_BINDIR}")
set(libdir "\$\{prefix\}/${CMAKE_INSTALL_LIBDIR}")
set(includedir "\$\{prefix\}/${CMAKE_INSTALL_INCLUDEDIR}")
set(VERSION "${PROJECT_VERSION}")
configure_file(${LIBUSB_ROOT}/libusb-1.0.pc.in ${CMAKE_BINARY_DIR}/libusb-1.0.pc @ONLY)

install(TARGETS usb-static usb-shared
	EXPORT EXPORT_usb
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	#LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(FILES ${LIBUSB_ROOT}/libusb/libusb.h
	DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/libusb-1.0
)

install(FILES ${CMAKE_BINARY_DIR}/libusb-1.0.pc
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

install(EXPORT EXPORT_usb
	NAMESPACE usb
	FILE usb.cmake
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)