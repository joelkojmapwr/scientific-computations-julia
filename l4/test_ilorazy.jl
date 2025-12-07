include("ilorazy_roznicowe.jl")
include("war_newton.jl")
include("naturalna.jl")
include("rysuj_nnfx.jl")

using .ilorazy_roznicowe
using .war_newton
using .postac_naturalna
using .rysuj_nnfx

# Test dla paraboli f(x) = x^2
function test_parabola()
    println("Test dla paraboli f(x) = x^2")
    
    # Węzły równoodległe
    x = [-2.0, 0.0, 2.0]
    y = [4.0, 0.0, 4.0]  # x^2
    
    # Oblicz ilorazy różnicowe
    ilorazy = ilorazyRoznicowe(x, y)
    println("Ilorazy różnicowe: ", ilorazy)
    
    # Test wielomianu Newtona w punktach węzłowych
    println("Sprawdzanie wartości w węzłach:")
    for i in 1:length(x)
        wartosc = warNewton(x, ilorazy, x[i])
        println("f($(x[i])) = $(y[i]), Newton: $wartosc, błąd: $(abs(y[i] - wartosc))")
    end

    wspolczynniki_naturalna = naturalna(x, ilorazy)
    println("Współczynniki w postaci naturalnej: ", wspolczynniki_naturalna)
    
    # Test w punktach pośrednich
    println("Sprawdzanie wartości w punktach pośrednich:")
    test_points = [-1.5, -0.5, 0.5, 1.5]
    for t in test_points
        expected = t^2
        computed = warNewton(x, ilorazy, t)
        error = abs(expected - computed)
        println("f($t) = $expected, Newton: $computed, błąd: $error")
    end
end

test_parabola()

rysujNnfx(x -> x^2, -2.0, 2.0, 2, wezly=:rownoodlegle)