#!/usr/bin/julia

###############################################################
# DicomUtils.jl 
# functions to read and write dicom files
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: January 15, 2023 
# Modified: October 2, 2023
###############################################################

using DICOM

"""
Read dicom from path
"""
function dcmread(path::String) 

    dcm_data = dcm_parse(path)

    return dcm_data

end

"""
Write 2D array to dicom at dest path using reference dicom at ref_path
"""
function dcmwrite(array; destination_path::String=nothing, reference_path::String=nothing)

	@assert !isnothing(destination_path) # need inputs
	@assert !isnothing(reference_path) # need inputs

    data = dcm_parse(reference_path)

    vr = data.vr

    data[tag"Pixel Data"] = Int16.(1000 .* array)

    dcm_write(destination_path, data, aux_vr=vr)

end

