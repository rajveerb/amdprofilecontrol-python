# Available at setup time due to pyproject.toml
import os, sys

DIR = os.path.abspath(os.path.dirname(__file__))

sys.path.append(os.path.join(DIR, "extern", "pybind11"))
from pybind11.setup_helpers import Pybind11Extension, build_ext as _build_ext  # noqa: E402

del sys.path[-1]
from setuptools import setup

# use c++ as the compiler instead of g++
from distutils import sysconfig
from distutils.core import Extension
sysconfig.get_config_vars()
sysconfig._config_vars['CC'] = 'c++'



__version__ = "0.0.1"

# The main interface is through Pybind11Extension.
# * You can add cxx_std=11/14/17, and then build_ext can be removed.
# * You can set include_pybind11=false to add the include directory yourself,
#   say from a submodule.
#
# Note:
#   Sort input source files if you glob sources to ensure bit-for-bit
#   reproducible builds (https://github.com/pybind/python_example/pull/53)


# convert "c++ -O3 -Wall -shared -std=c++11 -fPIC $(python3-config --includes) -I extern/pybind11/include -I /opt/AMDuProf_4.0-341/include AMDProfileControl/amdprofilecontrol-python.cpp  -o amdprofilecontrol$(python3-config --extension-suffix) -L /opt/AMDuProf_4.0-341/lib/x64  -lAMDProfileController -lrt -pthread" command to setup.py


ext_modules = [
    Extension(
        "amdprofilecontrol",
        sources=["AMDProfileControl/amdprofilecontrol-python.cpp"],
        extra_compile_args=["-O3", "-Wall", "-std=c++11", "-fPIC", "$(python3-config --includes)"],
        include_dirs=["extern/pybind11/include", "/opt/AMDuProf_4.0-341/include"],
        extra_link_args=["-L/opt/AMDuProf_4.0-341/lib/x64", "-lAMDProfileController", "-lrt", "-pthread"],
    )
]




setup(
    name="amdprofilecontrol",
    version=__version__,
    description="AMDProfileControl API bindings for Python",
    ext_modules=ext_modules,
    # Currently, build_ext only provides an optional "highest supported C++
    # level" feature, but in the future it may provide more features.
    # cmdclass={'build_ext': build_ext,},
    python_requires=">=3.9",
)