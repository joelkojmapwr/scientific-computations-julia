# Author: Joel Kojma

module ilorazy_roznicowe
export ilorazyRoznicowe

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    n = length(x)
    fx = Vector{Float64}(undef, n)
    fxi = copy(f)
    fx[1] = f[1]
    for i in 2:n
        for j in 1:(n - i + 1)
            fxi[j] = (fxi[j + 1] - fxi[j]) / (x[j + i - 1] - x[j])
        end
        fx[i] = fxi[1]
    end
    return fx
end

end # module