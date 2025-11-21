# Author: Joel Kojma

module RootFinder

export mbisekcji
export mstycznych
export msiecznych

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    r = nothing
    iter = nothing
    error = 0

    fa = f(a)
    fb = f(b)

    if (fa * fb > 0)
        println("Funkcja musi miec rozne znaki na koncach przedzialu")
        error = 1
        return r, nothing, iter, error
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

function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    
    r = nothing # root
    v = nothing # f(r)
    it = nothing # Number of iterations
    error = 0
    x1 = x0

    v = f(x0)
    if abs(v) < epsilon
        return x0, v, 0, 0
    end
    for k in 1:maxit 
        pfx0 = pf(x0)
        if pfx0 == 0.0
            return x0, v, k, 2
        end
        x1 = x0 - v / pf(x0)
        v = f(x1)
        if (abs(x1 - x0) < delta || abs(v) < epsilon)
            return x1, v, k, 0
        end
        x0 = x1
    end

    return x1, v, maxit, 1

end

function msiecznych(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    r = nothing
    iter = nothing
    error = 0

    fa = f(a)
    fb = f(b)

    for k in 1:maxit 
        if (abs(fa) > abs(fb))
            a, b = b, a
            fa, fb = fb, fa
        end
        if (fb - fa) == 0.0
            return a, fa, k, 2 # division by zero error
        end
        s = (b - a) / (fb - fa)
        b = a
        fb = fa
        a = a - fa * s
        fa = f(a)
        if (abs(b - a) < delta || abs(fa) < epsilon)
            return a, fa, k, error
        end
    end
    return a, fa, maxit, 1
end

end # module

