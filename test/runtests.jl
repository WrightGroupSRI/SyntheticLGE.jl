using SyntheticLGE
using Test

@testset "SyntheticLGE.jl" begin
	@test SyntheticLGE.IR_2p(0, [[0, 1], [100, 10]]) == [0, 1]

end
