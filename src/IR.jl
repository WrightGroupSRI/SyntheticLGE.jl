function IR(TI, p)
    
    Mss, T1 = p
    
    return abs.(Mss .* (1 .- 2 .* exp.(-TI ./ T1)))
end
