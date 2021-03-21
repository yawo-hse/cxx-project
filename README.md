# cxx-project

[![build-and-test](https://github.com/automainint/cxx-project/workflows/build-and-test/badge.svg)](https://github.com/automainint/cxx-project/actions?query=workflow%3Abuild-and-test)
[![codecov][codecov-badge]][codecov-link]

C++ project template.

##  How to build
To build the project CMake and Python 3 are required.

### With CMake
Execute `build.py`.

    python3 build.py

Done!

### By hand
Use `tools/build-deps.py` to build the dependencies.

    cd tools
    python3 build-deps.py
    cd ..

Add `source` to the project and build manually. Required headers will be in `include` folder, libraries will be in `lib` folder.

[codecov-badge]:   https://codecov.io/gh/yawo-hse/cxx-project/branch/feature-codecov/graph/badge.svg
[codecov-link]:    https://codecov.io/gh/yawo-hse/cxx-project
