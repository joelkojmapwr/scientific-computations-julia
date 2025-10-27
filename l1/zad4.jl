# Joel Kojma

function find_x()

    x = Float64(1.0)
    while (x * (Float64(1.0) / x) == Float64(1.0))
        x = nextfloat(x)

    end
    return x

end

function main()

    x = find_x()

    println("Found number in (1, 2) such that x*(1/x) != 1: ", x)

end

main()