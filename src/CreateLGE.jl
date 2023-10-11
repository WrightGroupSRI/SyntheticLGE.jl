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

function CreateLGE(M0, T1, TI::Int64; B=nothing, PSIR::Bool=false)

	if !isnothing(B)
		p = [M0, T1, B]
	else
		p = [M0, T1]
	end

	return IR(TI, p; PSIR=PSIR)

end
