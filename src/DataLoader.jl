#!/usr/bin/julia

###############################################################
# DataLoader.jl
# read in multicontrast and T1 mapping data from paths 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 02, 2023
###############################################################

include("DicomUtils.jl")
using Glob
using MIRTjim: jim

function DataLoader(multicontrast_path, T1_path)

	T1w_image_path = sort(glob("*.dcm", multicontrast_path))
	T1_map_path = sort(glob("*.dcm", T1_path))

	T1w_image_size = size(dcmread(T1w_image_path[1]))
	T1_map_size = size(dcmread(T1_map_path[1]))
	@assert T1w_image_size == T1_map_size # maps and images should be same size
	shx, shy = T1w_image_size

	num_images = size(T1w_image_path, 1)
	T1w_images = zeros(shx, shy, num_images)

	for i = 1:num_images
		T1w_images[:, :, i] = dcmread(T1w_image_path[i]) 
	end

	num_slices = size(T1_map_path, 1)

	@assert mod(num_images, num_slices) == 0 # number of images should be a multiple of number of slices

	num_contrasts = floor(Int64, num_images / num_slices)

	T1w_sort = zeros(shx, shy, num_slices, num_contrasts)
	# TODO sort images

	T1_map = zeros(shx, shy, num_slices)

	for i = 1:num_slices
		T1_map[:, :, i] = dcmread(T1_map_path[i]) 
	end

	return T1w_sort, T1_map

end

path = "/home/calder/Infrastructure/Data/DHC-2ABJ9_033Y/series0001-Body/"

DataLoader(path, path)

