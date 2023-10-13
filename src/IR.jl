#!/usr/bin/julia

###############################################################
# RUN LGE
# script to run synthetic LGE pipeline
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 11, 2023
###############################################################

using SyntheticLGE: DataLoader, FitT1, CreateLGE, ExportLGE
using MIRTjim: jim
using Plots: savefig

multicontrast_path = "data/multicontrast_imgs"
T1_path = "data/T1map_imgs"

TI, T1w, _ = DataLoader(multicontrast_path; T1_path=T1_path)

M0_2p, T1_2p = FitT1(TI, T1w; num_params=2)

M0_3p, T1_3p, B_3p = FitT1(TI, T1w; num_params=3)

LGE_2p = CreateLGE(300; M0=M0_2p, T1=T1_2p)

LGE_2p_PSIR = CreateLGE(300; M0=M0_2p, T1=T1_2p, PSIR=true)

LGE_3p = CreateLGE(300; M0=M0_3p, T1=T1_3p, B=B_3p)

LGE_3p_PSIR = CreateLGE(300; M0=M0_3p, T1=T1_3p, B=B_3p, PSIR=true)

ExportLGE(LGE_2p_PSIR, reference_path=T1_path, destination_path="data/destination_path")

jim(permutedims(LGE_2p, (2, 1, 3)))
savefig("LGE_2p.png")

jim(permutedims(LGE_2p_PSIR, (2, 1, 3)))
savefig("LGE_2p_PSIR.png")

jim(permutedims(LGE_3p, (2, 1, 3)))
savefig("LGE_3p.png")

jim(permutedims(LGE_3p_PSIR, (2, 1, 3)))
savefig("LGE_3p_PSIR.png")
    


