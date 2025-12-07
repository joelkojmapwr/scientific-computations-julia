# Author: Joel Kojma

module postac_naturalna

export naturalna

# Zaimplementowane z pomocą Gemini
function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    n = length(fx)
    a = fx
    
    for k in (n-1):-1:1
        for j in k:(n-1)
            a[j] = a[j] - x[k] * a[j+1]
        end
    end
    
    return a
end

end # module