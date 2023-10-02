using SyntheticLGE
using Test

@testset "SyntheticLGE.jl" begin
	@test SyntheticLGE.IR(0, [0, 1], [100, 10]) == [0, 1]
	a = SyntheticLGE.dcmread("/hdd/Data/20150505_LZ/Recon_Demo/E2315S21_DCM/IM-21130-0019.dcm")
	print(a)

end
