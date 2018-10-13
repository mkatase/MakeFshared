using BinaryProvider
using CMakeWrapper: cmake_executable
using Libdl: dlext

function compile(libname, tarball_url, hash; prefix=BinaryProvider.global_prefix, verbose=false)
    # download to tarball_path
    tarball_path = joinpath(prefix, "downloads", "libmakef.tar.gz")
    download_verify(tarball_url, hash, tarball_path; force=true, verbose=verbose)

    # unpack into source_path
    tarball_dir = joinpath(prefix, "downloads", dirname(first(list_tarball_files(tarball_path))))
    source_path = joinpath(prefix, "downloads", "src")

    verbose && @info("Unpacking $tarball_path into $source_path")
    rm(tarball_dir, force=true, recursive=true)
    rm(source_path, force=true, recursive=true)
    unpack(tarball_path, dirname(tarball_dir); verbose=verbose)
    mv(tarball_dir, source_path)

    build_dir = joinpath(source_path, "build")
    src_dir   = joinpath(build_dir, "lib")

    mkdir(build_dir)
    verbose && @info("Compiling in $build_dir...")
    cd(build_dir) do
        run(`$cmake_executable ..`)
        run(`$cmake_executable --build ./lib`)
        mkpath(libdir(prefix))

        src_file = joinpath(src_dir, libname*"."*dlext)
        dst_file = joinpath(libdir(prefix), libname*"."*dlext)
        cp(src_file, dst_file, force=true, follow_symlinks=true)
    end
end
