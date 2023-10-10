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

function FitT1(TI, T1w; num_params:Int16=2)
    # TODO write testing code
    (sx, sy, sz, st) = size(T1w)
    M0_fit = zeros(Float64, (sx, sy, sz))
    T1_fit = zeros(Float64, (sx, sy, sz))
    B_fit = zeros(Float64, (sx, sy, sz))

    T1w = (T1w .- minimum(T1w)) ./ (maximum(T1w) - minimum(T1w))

    @threads for i in 1:size(M0_fit, 1)
        @threads for j in 1:size(M0_fit, 2)
            @threads for k in 1:size(M0_fit, 3)
		    try

			    if num_params == 2
				p0 = [0.5, 1000]
			    elseif num_params == 3
				p0 = [T1w[i, j, k, size(T1w, 4)], 2, 1000]
				lower = [0.0, 0.0, 0.0]
				upper = [1.0, 4.0, 3000.0]
			    else
				throw(DomainError(num_params, "must be 2 or 3"))
			    end
				

			    o = curve_fit(IR, TI[k, :], T1w[i, j, k, :], p0, lower=lower, upper=upper)
			    out = coef(o)
			    m = out[1]
			    if num_params == 2
				    T = out[2]
			    elseif num_params == 3
				    T = out[3]
				    B_fit[i, j, k] = out[2]
			    end

			    # TODO: look at quality of fit and set bad fits equal to 0
			    # TODO: one-parameter fit using M0
			    M0_fit[i, j, k] = m
			    T1_fit[i, j, k] = T
		    catch e

			    continue
			    # sets M0 = 0, T1 = 0

                end

            end
        end   
    end

    return M0_fit, T1_fit, B_fit
    
end

