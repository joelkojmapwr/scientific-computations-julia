module war_newton

export warNewton

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    n = length(x)

    nt = fx[n+1]

    for i in n:-1:1
        nt = fx[i] + (t - x[i]) * nt
    end

    return nt

end




end # module