#!/usr/bin/julia

###############################################################
# ExportLGE.jl
# function to export LGE images to dicom images 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 10, 2023
###############################################################

include("DicomUtils.jl")
include("NIFTIUtils.jl")
using Glob

"""
function ExportLGE()
"""
function ExportLGE(LGE_array; reference_path=nothing, destination_path=nothing)

	@assert !isnothing(destination_path) # need an output

	if !isdir(destination_path)
		mkpath(destination_path)
	end

        niftiwrite(LGE_array, destination_path=destination_path)

end
