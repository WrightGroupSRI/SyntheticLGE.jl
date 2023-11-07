#!/usr/bin/julia

###############################################################
# FIGURE 5
# compare synthetic LGE images with real LGE images
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 14, 2023
###############################################################

using SyntheticLGE: DataLoader, FitT1, CreateLGE, ExportLGE, dcmread
using MIRTjim: jim
using Plots: plot!, savefig
using Glob
using DICOM

function center_crop(x, sx, sy)

	Nx = size(x, 1)
	Ny = size(x, 2)

	return x[Int(Nx // 2 - sx // 2):Int(Nx // 2 + sx // 2) - 1, Int(Ny // 2 - sy // 2):Int(Ny // 2 + sy//2) - 1, :] 

end

function norm(x)

	return (x .- minimum(x)) ./ (maximum(x) - minimum(x))

end

multicontrast_path = "../../../../data/flash/multicontrast_imgs"

T1_path = "../../../../data/flash/T1map_imgs"

LGE_path = "../../../../data/lge/"

TI, T1w, T1_inp = DataLoader(multicontrast_path; T1_path=T1_path)

LGE_images = sort(glob("*.dcm", LGE_path))

test_image = dcmread(LGE_images[1])[tag"Pixel Data"] 

num_images = size(LGE_images, 1)

LGE = zeros((size(test_image, 1), size(test_image, 2), num_images))

for i=1:num_images

	LGE[:, :, i] = dcmread(LGE_images[i])[tag"Pixel Data"]

end

@time M0_2p, T1_2p, _ = FitT1(TI, T1w; num_params=2)

TI_choice = 450 

LGE_2p = CreateLGE(TI_choice; M0=M0_2p, T1=T1_2p, PSIR=true)

shx = size(LGE_2p, 1)

shy = size(LGE_2p, 2)

jim_arr = zeros((shx, shy, 8))

jim_arr[:, :, begin:4] = norm(LGE_2p[:, :, begin:5:end]) * 1.6

jim_arr[:, :, 5:end] = norm(center_crop(LGE, shx, shy)[:, :, begin:5:end])

out = jim(permutedims(jim_arr, (2, 1, 3)), nrows=2, dpi=900, clim=(0, 1))

savefig("Figure5.png")

