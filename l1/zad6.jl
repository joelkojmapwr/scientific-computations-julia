function f(x)
    type = typeof(x)

    return sqrt(x*x + type(1.0)) - type(1.0)

end

function g(x)
    type = typeof(x)
    return (x*x) / (sqrt(x*x + 1) + 1)

end

function main()

    x = Float64(1.0)
    for i in 1:15
        x /= 8
        println("For i = $i f(x) = ", f(x), " g(x) = ", g(x), " |(g(x) - f(x))| / g(x) = ", abs(g(x) - f(x)) / g(x))
        # println("For i = $i g(x) = ", g(x))
    end
    
end

main()

# Dobre wyniki to g(x) ponieważ w f(x) odejmujemy 2 bliskie sobie liczby, przez co tracimy precyzję