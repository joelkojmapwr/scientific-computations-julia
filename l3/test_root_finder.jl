include("root_finder.jl")

using .RootFinder
# using Pkg
# Pkg.add("Roots")

using Roots
using Printf

f = x -> x^3 - x - 2
pf = x -> 3*x^2 - x
delta = 1e-5
epsilon = 1e-5
maxit = 100
original_root = find_zero(f, (1.0, 2.0), Bisection())

algorithms = [mbisekcji, mstycznych, msiecznych]
r = zeros(3)
v = zeros(3)
it = zeros(Int, 3)
error = zeros(Int, 3)

r[1], v[1], it[1], error[1] = RootFinder.mbisekcji(f, 1.0, 2.0, delta, epsilon)
# println("Metoda bisekcji:")
# if error[1] == 0
#     println("Pierwiastek: ", r[1])
#     println("Wartosc funkcji w punkcie: ", v[1])
#     println("Liczba iteracji: ", it[1])
# end

r[2], v[2], it[2], error[2] = RootFinder.mstycznych(f, pf, 1.0, delta, epsilon, maxit)

# println("\nMetoda stycznych:")
# if error[2] == 0
#     println("Pierwiastek: ", r[2])
#     println("Wartosc funkcji w punkcie: ", v[2])
#     println("Liczba iteracji: ", it[2])
# elseif error[2] == 2
#     println("Blad: Pochodna bliska zeru.")
# elseif error[2] == 1
#     println("Błąd: Przekroczono maksymalna liczbe iteracji.")
# end

r[3], v[3], it[3], error[3] = RootFinder.msiecznych(f, 1.0, 2.0, delta, epsilon, maxit)

# println("\nMetoda siecznych:")
# if error == 0
#     println("Pierwiastek: ", r)
#     println("Wartosc funkcji w punkcie: ", v)
#     println("Liczba iteracji: ", it)
# end

println("r\tf(r)\titer\tbłąd względny%")

for i in 1:3
    if (error[i] == 1)
        println(r[i], "\t", v[i], "\t", "Blad: Przekroczono maksymalna liczbe iteracji.")
    elseif (error[i] == 2)
        println(r[i], "\t", v[i], "\t", "Blad: Dzielenie przez zero.")
        continue
    else
        @printf("%.5e\t%.5e\t%d\t%e\n", r[i], v[i], it[i], abs(r[i] - original_root) * 100 / abs(original_root))
    end
end
