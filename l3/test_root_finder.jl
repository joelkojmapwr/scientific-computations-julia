include("root_finder.jl")

using .RootFinder


f = x -> x^3 - x - 2
pf = x -> 3*x^2 - x
delta = 1e-5
epsilon = 1e-5
maxit = 100

r, v, it, error = RootFinder.mbisekcji(f, 1.0, 2.0, delta, epsilon)
println("Metoda bisekcji:")
if error == 0
    println("Pierwiastek: ", r)
    println("Wartosc funkcji w punkcie: ", v)
    println("Liczba iteracji: ", it)
end

r, v, it, error = mstycznych(f, pf, 1.0, delta, epsilon, maxit)

println("\nMetoda stycznych:")
if error == 0
    println("Pierwiastek: ", r)
    println("Wartosc funkcji w punkcie: ", v)
    println("Liczba iteracji: ", it)
end

r, v, it, error = msiecznych(f, 1.0, 2.0, delta, epsilon, maxit)

println("\nMetoda siecznych:")
if error == 0
    println("Pierwiastek: ", r)
    println("Wartosc funkcji w punkcie: ", v)
    println("Liczba iteracji: ", it)
end