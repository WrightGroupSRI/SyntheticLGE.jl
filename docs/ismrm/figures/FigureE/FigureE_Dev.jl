#!/usr/bin/julia

###############################################################
# FIGURE E
# Full-stack synthetic LGE images
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

TI_choice = 450 

LGE_2p = permutedims(CreateLGE(TI_choice; M0=M0_2p, T1=T1_2p), (2, 1, 3))

jim(LGE_2p,
    title="Short-Axis Stack of SynLGE Images",
    clim=(0, 0.2),
    colorbar=:none,
    dpi=900)
plot!(size=(450, 400))
savefig("FigureE_Dev.png")
