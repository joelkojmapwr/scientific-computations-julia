# Author: Joel Kojma

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    r = nothing
    v = nothing
    it = nothing
    error = 0

    fa = f(a)
    fb = f(b)

    if (fa * fb > 0)
        println("Funkcja musi miec rozne znaki na koncach przedzialu")
        error = 1
        return r, v, it, error
    end

    e = b - a

    iter = 1

    while true
        e = e / 2
        c = a + e 
        fc = f(c)
        if (abs(e) < delta || abs(fc) < epsilon)
            return c, fc, iter, error
        end
        if (fa * fc < 0)
            b = c
            fb = fc
        else
            a = c
            fa = fc
        end

        iter = iter + 1
    end



end


r, v, it, error = mbisekcji(x -> x^3 - x - 2, 1.0, 2.0, 1e-5, 1e-5)

if error == 0
    println("Pierwiastek: ", r)
    println("Wartosc funkcji w punkcie: ", v)
    println("Liczba iteracji: ", it)
end