using SyntheticLGE
using Test

@testset "SyntheticLGE.jl" begin
	@test SyntheticLGE.IR(0, 0, 100) == 0
	@test SyntheticLGE.IR(0, 1, 100) == 1
end
