include("root_finder.jl")

using .RootFinder
# using Pkg
# Pkg.add("Roots")

using Roots
using Printf

f = x -> exp(x) - 3x
pf = x -> exp(x) - 3
delta = 10e-4
epsilon = 10e-4
maxit = 100

algorithms = [mbisekcji, mstycznych, msiecznych]
r = zeros(3)
v = zeros(3)
it = zeros(Int, 3)
error = zeros(Int, 3)

r[1], v[1], it[1], error[1] = RootFinder.mbisekcji(f, 0.0, 1.0, delta, epsilon)
r[2], v[2], it[2], error[2] = RootFinder.mbisekcji(f, 1.0, 2.0, delta, epsilon)

println("r\tf(r)\titer")

for i in 1:2
    if (error[i] == 1)
        println(r[i], "\t", v[i], "\t", "Blad: Przekroczono maksymalna liczbe iteracji.")
    elseif (error[i] == 2)
        println(r[i], "\t", v[i], "\t", "Blad: Dzielenie przez zero.")
        continue
    else
        @printf("%.10e\t%.10e\t%d\n", r[i], v[i], it[i])
    end
end
