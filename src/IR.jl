function IR(TI, M0, T1)

	return abs.(M0 .* (1 .- 2 .* exp.(-TI ./ T1)))

end
