

function float_distribution(start_x, end_x)

    println(bitstring(start_x))
    println(bitstring(end_x))

    end_x = nextfloat(start_x)
    println(bitstring(end_x))

end

float_distribution(Float64(1.0), Float64(2.0))
