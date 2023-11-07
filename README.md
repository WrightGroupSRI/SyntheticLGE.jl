# SyntheticLGE.jl

[![Build Status](https://github.com/WrightGroupSRI/SyntheticLGE.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/WrightGroupSRI/SyntheticLGE.jl/actions/workflows/CI.yml?query=branch%3Amain)

To install this package, run the following commands. 

```bash
git clone https://github.com/WrightGroupSRI/SyntheticLGE.jl
cd SyntheticLGE.jl
julia
```
In the Julia terminal, press the `]` key to enter the package installation environment and run the following command. 

```julia
calderds@raven ~                                                                            [11:32:38]
> $ julia                                                                                             
(@v1.9) pkg> add .
(@v1.9) pkg> add Plots
(@v1.9) pkg> add MIRTjim
```
To confirm the package works with sample data, run the following command. 

```bash
julia docs/example/RunLGE.jl
```

ISMRM abstract figures can be found in `docs/ismrm/figures/` (and may require external `Glob`, `DICOM` dependencies).
