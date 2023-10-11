using SyntheticLGE
using Test

@testset "SyntheticLGE.jl" begin
	@test SyntheticLGE.IR(0, [[0, 1], [100, 10]]) == [0, 1]
	@test SyntheticLGE.IR(0, [[0, 1], [100, 10], [0.1, 0.2]]) == [0, 1]

end
