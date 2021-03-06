## This file autogenerated by BinaryProvider.write_deps_file().
## Do not edit.
##
## Include this file within your main top-level source, and call
## `check_deps()` from within your module's `__init__()` method

if isdefined((@static VERSION < v"0.7.0-DEV.484" ? current_module() : @__MODULE__), :Compat)
    import Compat.Libdl
elseif VERSION >= v"0.7.0-DEV.3382"
    import Libdl
end
const libextraf = joinpath(dirname(@__FILE__), "usr/lib/libextraf.so")
function check_deps()
    global libextraf
    if !isfile(libextraf)
        error("$(libextraf) does not exist, Please re-run Pkg.build(\"MakeFshared\"), and restart Julia.")
    end

    if Libdl.dlopen_e(libextraf) in (C_NULL, nothing)
        error("$(libextraf) cannot be opened, Please re-run Pkg.build(\"MakeFshared\"), and restart Julia.")
    end

end
