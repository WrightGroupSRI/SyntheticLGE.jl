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
using Glob

"""
function ExportLGE()
"""
function ExportLGE(LGE_array; reference_path=nothing, destination_path=nothing)

	@assert !isnothing(destination_path) # need an input

	@assert !isnothing(reference_path) # need an input

	@assert isdir(reference_path) # reference path needs to exist

	if !isdir(destination_path)
		mkpath(destination_path)
	end

	reference_files = sort(glob("*.dcm", reference_path))

	for i=1:size(LGE_array, 3)

		# get reference filename
		img_reference_path = reference_files[i] 
		
		# create filename to save data
		fnames = split(img_reference_path, "/")
		img_destination_path = joinpath(destination_path, fnames[length(fnames)]) 
		
		# save data
		dcmwrite(LGE_array[:, :, i], destination_path=img_destination_path, reference_path=img_reference_path)

	end

end
