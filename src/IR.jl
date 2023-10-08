function IR_2p(TI, p)
    
    Mss, T1 = p
    
    return abs.(Mss .* (1 .- 2 .* exp.(-TI ./ T1)))
end

function IR_2p_PSIR(TI, p)
    
    Mss, T1 = p
    
    return Mss .* (1 .- 2 .* exp.(-TI ./ T1))
end

function IR_3p(TI, p)
    
    A, B, T1 = p
    
    return abs.(A .- B .* exp.(-TI ./ T1))
end
