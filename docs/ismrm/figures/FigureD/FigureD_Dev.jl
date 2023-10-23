#!/usr/bin/julia

###############################################################
# FIGURE C
# Compare synthetic LGE images at different TIs 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 14, 2023
###############################################################

using SyntheticLGE: DataLoader, FitT1, CreateLGE, ExportLGE
using MIRTjim: jim
using Plots: plot!, savefig

multicontrast_path = "../../../../data/flash/multicontrast_imgs"
T1_path = "../../../../data/flash/T1map_imgs"

TI, T1w, T1_inp = DataLoader(multicontrast_path; T1_path=T1_path)

@time M0_2p, T1_2p, _ = FitT1(TI, T1w; num_params=2)

TI_choices = [250, 300, 350, 400, 450, 500, 550] 

images = zeros(Float64, size(T1_2p, 2), size(T1_2p, 1), 2 * size(TI_choices, 1))

idx = 11

for T in 1:size(TI_choices, 1)

	LGE_2p = CreateLGE(TI_choices[T]; M0=M0_2p, T1=T1_2p)

	LGE_2p_idx = LGE_2p[:, :, idx]'

	LGE_2p_PSIR = CreateLGE(TI_choices[T]; M0=M0_2p, T1=T1_2p, PSIR=true)

	LGE_2p_PSIR_idx = LGE_2p_PSIR[:, :, idx]'

	images[:, :, T] = (LGE_2p_idx .- minimum(LGE_2p_idx)) ./ (maximum(LGE_2p_idx) .- minimum(LGE_2p_idx))

	images[:, :, T + size(TI_choices, 1)] = (LGE_2p_PSIR_idx .- minimum(LGE_2p_PSIR_idx)) ./ (maximum(LGE_2p_PSIR_idx) .- minimum(LGE_2p_PSIR_idx))

end



jim(images,
    nrow=2,
    ncol=size(TI_choices, 1),
    clim=(0, 0.5),
    colorbar=:none,
    title="SynLGE Images at Multiple Inversion Times",
    dpi=900)
plot!(size=(800, 300))
savefig("FigureD_Dev.png")
