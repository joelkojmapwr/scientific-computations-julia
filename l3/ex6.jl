include("root_finder.jl")

using .RootFinder
# using Pkg
# Pkg.add("Roots")

using Roots
using Printf

f = x -> exp(1-x) - 1
pf = x -> -exp(1-x)
delta = 0.5e-5
epsilon = 0.5e-5
maxit = 100
original_root = find_zero(f, (1.0, 2.0), Bisection())

algorithms = [mbisekcji, mstycznych, msiecznych]
r = zeros(3)
v = zeros(3)
it = zeros(Int, 3)
error = zeros(Int, 3)

r[1], v[1], it[1], error[1] = RootFinder.mbisekcji(f, 0.0, 3.0, delta, epsilon)

r[2], v[2], it[2], error[2] = RootFinder.mstycznych(f, pf, 5.2, delta, epsilon, maxit)

r[3], v[3], it[3], error[3] = RootFinder.msiecznych(f, 1.5, 2.0, delta, epsilon, maxit)

println("r\tf(r)\titer")

for i in 1:3
    if (error[i] == 1)
        println(r[i], "\t", v[i], "\t", "Blad: Przekroczono maksymalna liczbe iteracji.")
    elseif (error[i] == 2)
        println(r[i], "\t", v[i], "\t", "Blad: Dzielenie przez zero.")
        continue
    else
        @printf("%.5e\t%.5e\t%d\n", r[i], v[i], it[i])
    end
end
