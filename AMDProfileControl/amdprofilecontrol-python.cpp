#include <pybind11/pybind11.h>
#include <AMDProfileController.h>

namespace py = pybind11;

PYBIND11_MODULE(amdprofilecontrol,m) {
    m.doc() = "Provide an interface to the AMDProfileControl APIs.";
    m.def("pause", &amdProfilePause, "Instruct the profiler to stop profiling. Profiling can be resumed using amdProfileResume. Returns True on success and False on failure.", py::arg("reserved") = 1);
    m.def("resume", &amdProfileResume, "Instruct the profiler to resume profiling. Profiling can be paused using amdProfilePause. Returns True on success and False on failure", py::arg("reserved") = 1);
    m.def("get_last_profile_error", &amdGetLastProfileError, "Returns the last error code");
}