module MakeFshared

export printout, calc, foo, moo

import Libdl
const depsjl_path = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")
if !isfile(depsjl_path)
    error("shared library not installed properly; run Pkg.build(\"MakeFshared\"), restart Julia, and try again.")
end

include(depsjl_path)


function __init__()
    check_deps()
end

function printout()
    ccall((:display_, libextraf), Nothing, ())
end

function calc(x, y)
    ccall((:__eins_MOD_calc, libextraf), Int32,
        (Ptr{Int32}, Ptr{Int32},), x, y)
end

function foo(x, y)
    ccall((:__zwei_MOD_foo, libextraf), Nothing,
        (Ptr{Int32}, Ptr{Int32},), x, y)
end

function moo(x, y)
    ccall((:__zwei_MOD_moo, libextraf), Nothing,
        (Ptr{Int32}, Ptr{Int32},), x, y)
end

end # module
