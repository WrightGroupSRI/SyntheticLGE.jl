#!/usr/bin/julia

###############################################################
# T1 FITTING FUNCTIONS
# Julia multithreaded fitting routines 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: February 01, 2023 
# Modified: Octover 2, 2023 
###############################################################

using LsqFit:curve_fit, coef
import Base.Threads.@threads

include("IR.jl")

function IR(t, p)
    
    Mss, T1 = p
    
    return abs.(Mss .* (1 .- 2 .* exp.(-t ./ T1)))
end

function FitT1(TI, arr)
    # TODO write testing code
    (sx, sy, sz, st) = size(arr)
    M0_fit = zeros(Float64, (sx, sy, sz))
    T1_fit = zeros(Float64, (sx, sy, sz))

    p0 = [0.5, 1]

    @threads for i in 1:size(M0_fit, 1)
        @threads for j in 1:size(M0_fit, 2)
            @threads for k in 1:size(M0_fit, 3)
                try

                    o = curve_fit(IR, TI, arr[i, j, k, :], p0)
		    m, T = coef(o)
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
    
    return M0_fit, T1_fit
    
end
