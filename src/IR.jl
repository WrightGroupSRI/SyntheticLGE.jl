function IR_2p(TI, p)
    
    Mss, T1 = p
    
    return abs.(Mss .* (1 .- 2 .* exp.(-TI ./ T1)))
end

function IR_2p_PSIR(TI, p)
    
    Mss, T1 = p
    
    return Mss .* (1 .- 2 .* exp.(-TI ./ T1))
end

function IR_3p(TI, p)
    
	return abs.(p[1] .- p[2] .* exp.(-TI ./ p[3]))
end

function IR_3p_PSIR(TI, p)
    
    A, B, T1 = p
    
    return A .- B .* exp.(-TI ./ T1)
end
