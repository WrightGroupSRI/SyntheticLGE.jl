#!/usr/bin/julia

###############################################################
# RUN LGE (FLASH)
# script to run synthetic LGE pipeline for FLASH images
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 11, 2023
###############################################################

using SyntheticLGE: DataLoader, FitT1, CreateLGE, ExportLGE
using MIRTjim: jim
using Plots: savefig

multicontrast_path = "data/flash/multicontrast_imgs"
T1_path = "data/flash/T1map_imgs"

# @time TI, T1w, _ = DataLoader(multicontrast_path)
TI, T1w, T1_inp = DataLoader(multicontrast_path; T1_path=T1_path)

TI_choice = 450 #ms

@time M0_2p, T1_2p = FitT1(TI, T1w; num_params=2)

@time LGE_2p = CreateLGE(TI_choice; M0=M0_2p, T1=T1_2p)

@time LGE_2p_PSIR = CreateLGE(TI_choice; M0=M0_2p, T1=T1_2p, PSIR=true)

@time ExportLGE(LGE_2p_PSIR, reference_path=T1_path, destination_path="data/flash/destination_path")

idx = 11

function save_plot(arr, idx, fname; color=:grays, clim=(minimum(arr), maximum(arr)))

	jim(permutedims(arr, (2, 1, 3))[:, :, idx], dpi=300, color=color, clim=clim)
	savefig("docs/images/flash/$fname.png")

end

save_plot(M0_2p, idx, "M0_2p")

save_plot(T1_2p, idx, "T1_2p"; color=:lajolla, clim=(0, 1000))

save_plot(T1_inp, idx, "T1_inp"; color=:lajolla, clim=(0, 1000))

save_plot(LGE_2p, idx, "LGE_2p")

save_plot(LGE_2p_PSIR, idx, "LGE_2p_PSIR")

