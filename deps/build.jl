using BinaryProvider
include("compile.jl")

const verbose = ("--verbose" in ARGS)
const prefix  = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, String["libextraf"], :libextraf),
]

src_url  = "https://mkatase.github.io/github-hosted/data/libmakef.tar.gz"
src_hash = "d33fef76bf8026112b7d441a4038225d679f305eb23fe2dfb5b249ce270eafbe"

src_path = joinpath(prefix, "downloads", "libmakef.tar.gz")

libname  = "libextraf"

if !isfile(src_path) || !verify(src_path, src_hash; verbose=verbose)
    println("Go to compile")
    compile(libname, src_url, src_hash, prefix=prefix, verbose=verbose)
end

write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)
println("end of build.jl script")
