# CMake Build Scripts
This directory contains CMake build scripts for projects that don't come with their own build scripts.

To use any of the build scripts here, untar the source files into the appropriate directory and run CMake from that directory as you wish.

As with the whole repository, the license of all files here are BSD 3-Clause.

## Features
All CMakeLists are written with CMake >= 3.7 in mind. Some may require even newer versions as situation arises. They are also written with simplicity and portability in mind.

All CMakeLists will install their own CMake exports for maximum convenience. This means no further `Find***` module is necessary.

if you would like me to attempt to support a (small, simple) project with CMake here, please file an issue. However, I do not promise any guarantees.
