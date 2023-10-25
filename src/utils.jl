#!/usr/bin/julia

###############################################################
# UTILS.jl
# helpful utility functions 
#
# Calder Sheagren
# University of Toronto
# calder.sheagren@sri.utoronto.ca
# Date: October 25, 2023
###############################################################

function norm(a)

	return (a .- minimum(a)) ./ (maximum(a) - minimum(a))

end
