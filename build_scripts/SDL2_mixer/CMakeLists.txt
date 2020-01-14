cmake_minimum_required(VERSION 3.7)
project(SDL2_mixer VERSION 2.0.4)

set(SDL2M_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/SDL2_mixer-${PROJECT_VERSION}")

find_package(SDL2 REQUIRED)
message(STATUS "Building with SDL ${SDL2_VERSION}")

file(GLOB midi_src ${SDL2M_ROOT}/native_midi/*.[c,h])
add_library(native_midi STATIC ${midi_src})
target_link_libraries(native_midi PUBLIC SDL2::SDL2)

file(GLOB Timidity_src ${SDL2M_ROOT}/timidity/*.[c,h])
add_library(Timidity STATIC ${Timidity_src})
target_link_libraries(Timidity PUBLIC SDL2::SDL2)

file(GLOB SDL2M_src ${SDL2M_ROOT}/*.[c,h])
list(REMOVE_ITEM SDL2M_src "${SDL2M_ROOT}/playmus.c" "${SDL2M_ROOT}/playwave.c")
if (MSVC)
	set(SDL2M_src ${SDL2M_src};${SDL2M_ROOT}/version.rc)
	set_source_files_properties(${SDL2M_ROOT}/version.rc PROPERTIES LANGUAGE RC)
endif()
add_library(SDL2_mixer SHARED ${SDL2M_src})
target_link_libraries(SDL2_mixer PRIVATE SDL2::SDL2 native_midi Timidity)
target_compile_definitions(SDL2_mixer PRIVATE
	_CRT_SECURE_NO_WARNINGS
	MUSIC_MID_TIMIDITY
	MUSIC_MID_NATIVE
)

add_executable(playmus ${SDL2M_ROOT}/playmus.c)
target_link_libraries(playmus PRIVATE SDL2_mixer)
target_compile_definitions(playmus PRIVATE SDL_MAIN_HANDLED)

add_executable(playwave ${SDL2M_ROOT}/playwave.c)
target_link_libraries(playwave PRIVATE SDL2_mixer)
target_compile_definitions(playwave PRIVATE SDL_MAIN_HANDLED)

include(GNUInstallDirs)
set(prefix "${CMAKE_INSTALL_PREFIX}")
set(exec_prefix "\$\{prefix\}/${CMAKE_INSTALL_BINDIR}")
set(libdir "\$\{prefix\}/${CMAKE_INSTALL_LIBDIR}")
set(includedir "\$\{prefix\}/${CMAKE_INSTALL_INCLUDEDIR}")
set(VERSION "${PROJECT_VERSION}")
set(SDL_VERSION "${SDL2_VERSION}")
configure_file(${SDL2M_ROOT}/SDL2_mixer.pc.in ${CMAKE_BINARY_DIR}/SDL2_mixer.pc @ONLY)

install(TARGETS SDL2_mixer playmus playwave
	EXPORT EXPORT_SDL2_mixer
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(FILES ${SDL2M_ROOT}/SDL_mixer.h
	DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/SDL2
)

install(FILES ${CMAKE_BINARY_DIR}/SDL2_mixer.pc
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

install(EXPORT EXPORT_SDL2_mixer 
	FILE SDL2_mixer.cmake
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)
