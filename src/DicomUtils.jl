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

export dcmread, dcmwrite

using DICOM
using Plots
using MIRTjim: jim

"""
Read dicom from path
"""
function dcmread(path::String) 

    dcm_data = dcm_parse(path)

    return dcm_data[tag"Pixel Data"]

end

"""
Write 2D array to dicom at dest path using reference dicom at ref_path
"""
function dcmwrite(array, dest_path::String, ref_path::String)

    data = dcm_parse(ref_path)

    vr = data.vr

    # TODO fix data type input issue
    # TODO make a (deep) copy of data
    data[tag"Pixel Data"] = array

    dcm_write(dest_path, data, aux_vr=vr)

end

