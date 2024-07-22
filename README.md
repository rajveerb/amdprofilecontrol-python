# AMDProfileControl-python

Includes Python bindings to AMDProfileControl API's which are part of the AMD uProf profiling tools. These APIs are designed to enable developers to control the profiling of specific parts of their applications, rather than profiling the entire application from start to finish. This is particularly useful for focusing on performance-critical sections, such as CPU-intensive loops or functions ("hot functions").

## Usage

    import amdprofilecontrol as a
    # ... uninteresting code
    a.resume(1)
    # ... interesting code ("hot functions")
    a.pause(1)
    # ... uninteresting code

After the python file in question has been modified, we would actually run

    > amduprof_record --output-dir {amduprof_result_dir} {python_path} program.py

## Installation 

First, begin by setting the AMDuProf environment variable like so

    export AMDuProf=/path/to/your/amduprof

This build assumes you have AMDuProf installed. The default path for AMDuProf is set in /opt/.

Additionally, the build only works currently with AMDuProf_4.0-341.

After the environment variable has been set run

    python setup.py install

## References

* [AMDuProf User Guide](https://www.amd.com/content/dam/amd/en/documents/developer/uprof-v4.0-gaGA-user-guide.pdf)