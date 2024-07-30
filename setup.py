import os
from setuptools import setup, find_packages, Extension
from setuptools.command.build_ext import build_ext
import pybind11

amduprof_dir = os.getenv('AMDuProf', '/opt/AMDuProf_4.0-341')

class CustomBuildExt(build_ext):
    def build_extensions(self):
        for ext in self.extensions:
            ext.include_dirs.append(pybind11.get_include())
            ext.include_dirs.append(os.path.join(amduprof_dir, 'include'))
            ext.extra_compile_args = ['-std=c++11', '-O3', '-Wall', '-fPIC']
            ext.extra_link_args = ['-lrt', '-pthread']
        super().build_extensions()

amdprofilecontrol_module = Extension(
    'amdprofilecontrol',
    sources=['AMDProfileControl/amdprofilecontrol-python.cpp'],
    include_dirs=[pybind11.get_include()],
    library_dirs=[os.path.join(amduprof_dir, 'lib/x64')],
    libraries=['AMDProfileController'],
    extra_compile_args=['-O3', '-Wall', '-shared', '-std=c++11', '-fPIC'],
    extra_link_args=['-lrt', '-pthread'],
    language='c++'
)

setup(
    name='amdprofilecontrol',
    version='0.1',
    description='Python wrapper package for AMDuProf',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    ext_modules=[amdprofilecontrol_module],
    packages=find_packages(),
    cmdclass={
        'build_ext': CustomBuildExt
    },
    zip_safe=False
)