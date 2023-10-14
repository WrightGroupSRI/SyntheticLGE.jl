#!/usr/bin/julia

###############################################################
# CREATE LGE
# Synthesize LGE from T1 maps
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 08, 2023
###############################################################

include("IR.jl")

function CreateLGE(TI::Int64; M0=nothing, T1=nothing, B=nothing, PSIR::Bool=false)

	@assert !isnothing(T1) # need input

	if isnothing(M0)

		p = [T1]

		return IR(TI, p; PSIR=PSIR)

	end

	if !isnothing(B) # either 2-parameter or 3-parameter fit

		p = [M0, T1, B]

	else

		p = [M0, T1]

	end

	return IR(TI, p; PSIR=PSIR)

end
