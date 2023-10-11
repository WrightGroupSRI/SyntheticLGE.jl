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

	T1w_image_size = size(dcmread(T1w_image_path[1])[tag"Pixel Data"])
	T1_map_size = size(dcmread(T1_map_path[1])[tag"Pixel Data"])
	@assert T1w_image_size == T1_map_size # maps and images should be same size
	shx, shy = T1w_image_size

	num_images = size(T1w_image_path, 1)
	T1w_images = zeros(shx, shy, num_images)
	TIs = zeros(Int64, num_images)

	for i = 1:num_images

		x = dcmread(T1w_image_path[i]) 

		T1w_images[:, :, i] = x[tag"Pixel Data"] 

		TIs[i] = x[tag"Inversion Time"] 

	end

	num_slices = size(T1_map_path, 1)

	@assert mod(num_images, num_slices) == 0 # number of images should be a multiple of number of slices

	num_contrasts = floor(Int64, num_images / num_slices)

	T1w_sort = zeros(shx, shy, num_slices, num_contrasts)

	TI_sort = zeros(Int64, num_slices, num_contrasts)

	for i = 1:num_images

		a = mod(i, num_slices) 

		if a == 0
			a = num_slices
		end

		b = ceil(Int64, i / num_slices) 

		T1w_sort[:, :, a, b] = T1w_images[:, :, i]

		TI_sort[a, b] = Int64(TIs[i])

	end

	T1_map = zeros(shx, shy, num_slices)

	for i = 1:num_slices
		T1_map[:, :, i] = dcmread(T1_map_path[i])[tag"Pixel Data"] 
	end

	return TI_sort, T1w_sort, T1_map

end
