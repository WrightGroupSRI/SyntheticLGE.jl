#!/usr/bin/julia

###############################################################
# CREATE LGE
# Synthesize LGE from T1 maps
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 08, 2023
###############################################################

using MIRTjim: jim
using Plots: savefig

include("DataLoader.jl")
include("FitT1.jl")
include("IR.jl")

# T1w_path = "/home/calder/Infrastructure/Data/DHC-2ABJ9_033Y/series0062-Body/"
# T1map_path = "/home/calder/Infrastructure/Data/DHC-2ABJ9_033Y/series0063-Body/"

T1w_path = "/home/calder/Data/20231005/series0040-Body/"
T1map_path = "/home/calder/Data/20231005/series0041-Body/"

TI, T1w, T1map = DataLoader(T1w_path, T1map_path)
M0, T1 = FitT1(TI, T1w, 2)

LGE = IR_2p_PSIR(500, [M0, T1])

jim(permutedims(LGE, (2, 1, 3)))
savefig("SynLGE_PSIR.png")

jim(permutedims(M0, (2, 1, 3)))
savefig("MO.png")


