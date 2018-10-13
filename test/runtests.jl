using MakeFshared
using Test

@testset "MakeFshared" begin

println("# printout function check")
@test printout() == nothing

println("# calc function in eins module check")
@test calc(Int32[4], Int32[5]) == 20
@test calc(Int32[8], Int32[8]) == 64
@test calc(Float32[9.0], Float32[2.0]) == 0
@test_throws MethodError calc("c", "a")

println("# foo function in zwei module check")
a = Int32[3]
b = Int32[5]
@test foo(a, b) == nothing
@test b[1] == 8

println("# moo function in zwei module check")
a = Int32[5, 7]
b = Int32[8, 9]
@test moo(a, b) == nothing
@test b[1] == 13
@test b[2] == 16

end
