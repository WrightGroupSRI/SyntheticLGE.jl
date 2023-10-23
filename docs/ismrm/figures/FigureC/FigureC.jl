#!/usr/bin/julia

###############################################################
# FIGURE C
# Compare synthetic LGE images using different fitting techniques 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 14, 2023
###############################################################

using SyntheticLGE: DataLoader, FitT1, CreateLGE, ExportLGE
using MIRTjim: jim
using Plots: savefig

multicontrast_path = "../../../../data/ssfp/multicontrast_imgs"
T1_path = "../../../../data/ssfp/T1map_imgs"

TI, T1w, T1_inp = DataLoader(multicontrast_path; T1_path=T1_path)

@time M0_2p, T1_2p, _ = FitT1(TI, T1w; num_params=2)

@time M0_3p, T1_3p, B_3p = FitT1(TI, T1w; num_params=3)

TI_choice = 450

LGE_1p_inp = CreateLGE(TI_choice; T1=T1_inp)

LGE_2p = CreateLGE(TI_choice; M0=M0_2p, T1=T1_2p)

LGE_3p = CreateLGE(TI_choice; M0=M0_3p, T1=T1_3p, B=B_3p)

function Prepare(Img, idx)

	Img_perm = permutedims(Img, (2, 1, 3))

	shx, shy, shz = size(Img_perm)

	cx = Int(shx / 2)

	cy = Int(shy / 2)

	Img_idx = Img_perm[1 + cx - Int(idx[2] / 2):cx + Int(idx[2] / 2),
			   1 + cy - Int(idx[1] / 2):cy + Int(idx[1] / 2), idx[3]]

	return (Img_idx .- minimum(Img_idx)) / (maximum(Img_idx) - minimum(Img_idx))

end


flash_multicontrast_path = "../../../../data/flash/multicontrast_imgs"
flash_T1_path = "../../../../data/flash/T1map_imgs"

flash_TI, flash_T1w, flash_T1_inp = DataLoader(flash_multicontrast_path; T1_path=flash_T1_path)

@time flash_M0_2p, flash_T1_2p, _ = FitT1(flash_TI, flash_T1w; num_params=2)

@time flash_M0_3p, flash_T1_3p, flash_B_3p = FitT1(flash_TI, flash_T1w; num_params=3)

flash_LGE_1p_inp = CreateLGE(TI_choice; T1=flash_T1_inp)


flash_LGE_2p = CreateLGE(TI_choice; M0=flash_M0_2p, T1=flash_T1_2p)

flash_LGE_3p = CreateLGE(TI_choice; M0=flash_M0_3p, T1=flash_T1_3p, B=flash_B_3p)

ix = minimum([size(flash_LGE_1p_inp, 1), size(LGE_1p_inp, 1)])
iy = minimum([size(flash_LGE_1p_inp, 2), size(LGE_1p_inp, 2)])

idx = [ix, iy, 6]
flash_idx = [ix, iy, 11]

jim([Prepare(LGE_1p_inp, idx),
     Prepare(LGE_2p, idx),
     Prepare(LGE_3p, idx),
     Prepare(flash_LGE_1p_inp, flash_idx),
     Prepare(flash_LGE_2p, flash_idx),
     Prepare(flash_LGE_3p, flash_idx)],
    dpi=900)

savefig("FigureC.png")
