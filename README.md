# SyntheticLGE.jl

[![Build Status](https://github.com/WrightGroupSRI/SyntheticLGE.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/WrightGroupSRI/SyntheticLGE.jl/actions/workflows/CI.yml?query=branch%3Amain)

This package was developed on Julia 1.9. To install this package, run the following commands. 

```bash
https://github.com/WrightGroupSRI/SyntheticLGE.jl
cd SyntheticLGE.jl
julia
```
In the Julia terminal, press the `]` key to enter the package installation environment and run the following command. 

```julia
calderds@raven ~                                                                            [11:32:38]
> $ julia
(@v1.9) pkg> add Plots
(@v1.9) pkg> add MIRTjim                                                                                    
(@v1.9) pkg> add .
```
To confirm the package works with sample data, run the following command from the main folder. 

```bash
julia docs/example/RunLGE.jl
```

ISMRM abstract figures can be found in `docs/ismrm/figures/` (and may require external `Glob`, `DICOM` dependencies).
