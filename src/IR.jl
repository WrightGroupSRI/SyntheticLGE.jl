#!/usr/bin/julia

###############################################################
# IR.jl
# function to model inversion-recovery data with various inputs 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 10, 2023
###############################################################

"""
function IR(TI::Float64, p::Vector{Float64}; PSIR::Bool=false)

p = [T1]
IR(TI, T1) = 1 - 2exp(-TI/T1)

p = [M0, T1]
IR(TI, M0, T1) = M0 - 2M0exp(-TI/T1)

p = [M0, T1, B]
IR(TI, M0, T1, B) = M0 - Bexp(-TI/T1)

PSIR = false
Absolute value taken

PSIR = true
No absolute value taken
"""
function IR(TI::Float64, p::Vector{Float64}; PSIR::Bool=false)

	if size(p) == 1

		T1 = p[1]

		if PSIR
			
			return 1 .- 2 .* exp.(-TI ./ T1)

		else 
			return abs.(1 .- 2 .* exp.(-TI ./ T1))

		end

	elseif size(p) == 2

		Mss, T1 = p

		if PSIR

			return Mss .* (1 .- 2 .* exp.(-TI ./ T1))

		else

			return abs.(Mss .* (1 .- 2 .* exp.(-TI ./ T1)))


		end
	    
	elseif size(p) == 3

		Mss, T1, B = p

		if PSIR

			return A .- B .* exp.(-TI ./ T1)

		else

			return abs.(A .- B .* exp.(-TI ./ T1))

		end

	end
    
end
