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

