# AMDProfileControl-python
Python wrapper/binding for AMDuProf's `AMDProfileControl` APIs


## Fetch submodules

```bash
git submodule update --init --recursive
```

## Install pybind

```bash
cd extern/pybind11
mkdir build && cd build
cmake ..
make check -j $(nproc)
```

c++ -O3 -Wall -shared -std=c++11 -fPIC $(python3-config --includes) -I extern/pybind11/include -I /opt/AMDuProf_4.0-341/include AMDProfileControl/amdprofilecontrol-python.cpp  -o amdprofilecontrol$(python3-config --extension-suffix) -L /opt/AMDuProf_4.0-341/lib/x64  -lAMDProfileController -lrt -pthread
