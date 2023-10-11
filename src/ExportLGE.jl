#!/usr/bin/julia

###############################################################
# ExportLGE.jl
# function to export LGE images to dicom images 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 10, 2023
###############################################################

using MIRTjim: jim
using Plots: savefig

include("IR.jl")
include("DataLoader.jl")
include("FitT1.jl")
include("CreateLGE.jl")

"""
function ExportLGE()
"""
function ExportLGE()

end

# WB-MOCO-MOLLI multislice 
# T1w_path = "/home/calder/Infrastructure/Data/DHC-2ABJ9_033Y/series0062-Body/"
# T1map_path = "/home/calder/Infrastructure/Data/DHC-2ABJ9_033Y/series0063-Body/"

# WB-MOCO-MOLLI full stack
# T1w_path = "/home/calder/Infrastructure/Data/CAP29_5Wk_033Y/series0057-Body/"
# T1map_path = "/home/calder/Infrastructure/Data/CAP29_5Wk_033Y/series0058-Body/"

# SSFP-MOLLI
# T1w_path = "/home/calder/Infrastructure/Data/DHC-823KJ_033Y/series0048-Body"
# T1map_path = "/home/calder/Infrastructure/Data/DHC-823KJ_033Y/series0049-Body"

# phantom
# T1w_path = "/home/calder/Data/20231005/series0040-Body/"
# T1map_path = "/home/calder/Data/20231005/series0041-Body/"

# TI, T1w, T1map = DataLoader(T1w_path, T1map_path)
# M0, T1, B = FitT1(TI, T1w; num_params=3)

# LGE = CreateLGE(M0, T1, 300; B=B, PSIR=false)

# println(size(LGE))

# jim(permutedims(T1, (2, 1, 3)))
# savefig("T1_3p.png")

# jim(permutedims(LGE, (2, 1, 3)))
# savefig("SynLGE_3p.png")

# jim(permutedims(M0, (2, 1, 3)))
# savefig("M0_3p.png")

# jim(permutedims(B, (2, 1, 3)))
# savefig("B_3p.png")
