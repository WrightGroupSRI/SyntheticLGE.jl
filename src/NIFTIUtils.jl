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

include("utils.jl")
using NIfTI: NIVolume, niread, niwrite

"""
Read nifti file from path
"""
function niftiread(path::String) 

    data = niread(path).raw

    return data

end

"""
Write 3D array to nifti file
"""
function niftiwrite(array; destination_path::String=nothing)

    @assert !isnothing(destination_path) # need inputs

    vol = NIVolume(array, nothing)

    niwrite("$destination_path/output.nii", vol)

end

