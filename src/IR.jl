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
function IR(TI::Float64, p::Vector{Array{Float64, 3}}; PSIR::Bool=false)

PSIR = True:
return |IR(TI, p)|

PSIR = False:
return IR(TI, p)

Used for generation of T1w images from parametric maps
"""
function IR(TI::Int64, p::Vector{Array{Float64, 3}}; PSIR::Bool=false)

	if size(p)[1] == 1

		println("1 parameter fit")

		T1 = p[1]

		if PSIR

			println("PSIR reconstruction")
			
			return 1 .- 2 .* exp.(-TI ./ T1)

		else 

			println("Magnitude reconstruction")
			
			return abs.(1 .- 2 .* exp.(-TI ./ T1))

		end

	elseif size(p)[1] == 2

		Mss, T1 = p

		if PSIR

			return Mss .* (1 .- 2 .* exp.(-TI ./ T1))

		else

			return abs.(Mss .* (1 .- 2 .* exp.(-TI ./ T1)))


		end
	    
	elseif size(p)[1] == 3

		M0, T1, B = p

		if PSIR

			return M0 .- B .* exp.(-TI ./ T1)

		else

			return abs.(M0 .- B .* exp.(-TI ./ T1))

		end

	end

	return 0
    
end

"""
function IR(TI::Vector{Int64}, p::Vector{Float64})

p = [T1]
IR(TI, T1) = 1 - 2exp(-TI/T1)

p = [M0, T1]
IR(TI, M0, T1) = M0 - 2M0exp(-TI/T1)

p = [M0, T1, B]
IR(TI, M0, T1, B) = M0 - Bexp(-TI/T1)

Used for T1 fitting
"""
function IR(TI::Vector{Int64}, p::Vector{Float64})

	if size(p)[1] == 1

		T1 = p[1]
			
		return abs.(1 .- 2 .* exp.(-TI ./ T1))

	elseif size(p)[1] == 2

		Mss, T1 = p

		return abs.(Mss .* (1 .- 2 .* exp.(-TI ./ T1)))

	elseif size(p)[1] == 3

		M0, T1, B = p

		return abs.(M0 .- B .* exp.(-TI ./ T1))

	end

	return 0
    
end
