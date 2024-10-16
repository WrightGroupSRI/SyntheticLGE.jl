#!/usr/bin/julia

###############################################################
# T1 FITTING FUNCTIONS
# Julia multithreaded fitting routines 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: February 01, 2023 
# Modified: October 2, 2023 
###############################################################

using LsqFit:curve_fit, coef
import Base.Threads.@threads

include("IR.jl")

function FitT1(TI, T1w; num_params::Int=2)
    # TODO write testing code
    (sx, sy, sz, st) = size(T1w)
    M0_fit = zeros(Float64, (sx, sy, sz))
    T1_fit = zeros(Float64, (sx, sy, sz))
    B_fit = zeros(Float64, (sx, sy, sz))

    # T1w = (T1w .- minimum(T1w)) ./ (maximum(T1w) - minimum(T1w))
    println(size(T1w), maximum(T1w), minimum(T1w))
    T1w = T1w ./ T1w[:, :, :, end]
    println(size(T1w), maximum(T1w), minimum(T1w))
    println("PD normalization")

    @threads for i in 1:size(M0_fit, 1)
        @threads for j in 1:size(M0_fit, 2)
            @threads for k in 1:size(M0_fit, 3)
		    try

			    if num_params == 1
				    p0 = [1000.]
				    lower = [0.]
				    upper = [3000.0]
			    elseif num_params == 2
				    p0 = [T1w[i, j, k, size(T1w, 4)], 1000.0]
				lower = [0.0, 0.0]
				upper = [1.0, 3000.0]
			    elseif num_params == 3
				p0 = [T1w[i, j, k, size(T1w, 4)], 1000.0, 2.0]
				lower = [0.0, 0.0, 0.0]
				upper = [1.0, 3000.0, 4.0]
			    else
				throw(DomainError(num_params, "must be 1, 2, or 3"))
			    end
				

			    if any(isnan, T1w[i, j, k, :])

				    continue
				    # M0 = T1 = 0

			    end 

			    o = curve_fit(IR, TI[k, :], T1w[i, j, k, :], p0, lower=lower, upper=upper)
			    out = coef(o)
			    if num_params == 1
				    m = 1.
				    T = out[1]
			    else
				    m = out[1] * T1w[i, j, k, end]
				    T = out[2]
			    end

			    if num_params == 3
				    B_fit[i, j, k] = out[3]
			    end

			    M0_fit[i, j, k] = m
			    T1_fit[i, j, k] = T
		    catch e

			    # println(i, "", j, "", k, "", e)
			    continue
			    # sets M0 = 0, T1 = 0

		    end

            end

        end   

    end

    return M0_fit, T1_fit, B_fit
    
end

