# Author: Joel Kojma

include("rysuj_nnfx.jl")


using .rysuj_nnfx

function ex5()

    n_array = [5, 10, 15]

    functions = [
        (x -> exp(x), "exp(x)", 0.0, 1.0),
        (x -> x^2 * sin(x), "x^2 * sin(x)", -1.0, 1.0),
    ]

    for (f, name, a, b) in functions
        for n in n_array
            println("Interpolacja funkcji $name na przedziale [$a, $b] z n = $n węzłami równoodległymi")
            rysujNnfx(f, a, b, n, wezly=:rownoodlegle)
        end
    end
end

function ex6()

    n_array = [5, 10, 15]

    functions = [
        (x -> abs(x), "abs(x)", -1.0, 1.0),
        (x -> 1 / (1 + x^2), "1 / (1 + x^2)", -5.0, 5.0),
    ]

    for (f, name, a, b) in functions
        for n in n_array
            println("Interpolacja funkcji $name na przedziale [$a, $b] z n = $n węzłami równoodległymi")
            rysujNnfx(f, a, b, n, wezly=:rownoodlegle)
        end
    end

    for (f, name, a, b) in functions
        for n in n_array
            println("Interpolacja funkcji $name na przedziale [$a, $b] z n = $n węzłami Czebyszewa")
            rysujNnfx(f, a, b, n, wezly=:czebyszew)
        end
    end
end


# ex5()
ex6()