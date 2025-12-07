module rysuj_nnfx

export rysujNnfx

include("ilorazy_roznicowe.jl")
include("war_newton.jl")
using .ilorazy_roznicowe
using .war_newton

using Plots

function roots_of_chebyshev(a::Float64, b::Float64, n::Int)
    roots = Vector{Float64}(undef, n)
    for j in 0:(n-1) 
        roots[j+1] = cos((2j + 1)* pi / (2n))
    end
    # Przeskalowanie z [-1, 1] do [a, b]
    for j in 1:n 
        roots[j] = 0.5 * (a + b) + 0.5 * (b - a) * roots[j]
    end
    return roots
end


function rysujNnfx(f, a::Float64, b::Float64, n::Int; wezly::Symbol = :rownoodlegle)

    if wezly == :rownoodlegle
        x = collect(range(a, b; length = n + 1))
    elseif wezly == :czebyszew
        x = roots_of_chebyshev(a, b, n + 1)
    end
    
    y = [f(xi) for xi in x]

    ilorazy = ilorazyRoznicowe(x, y)
    # print("Ilorazy: ", ilorazy)

    x_plot = range(a, b, length=1000)
    y_plot = [f(xi) for xi in x_plot]
    p1 = plot(x_plot, y_plot, label="f(x)", linewidth=2, size=(1400, 800))

    y_interpolated = [warNewton(x, ilorazy, xi) for xi in x_plot]
    plot!(p1, x_plot, y_interpolated, label="Interpolacja Newtona", linestyle=:dash, linewidth=2)

    display(p1)
    println("Press Enter to close the plots...")
    readline()


end

end # module
