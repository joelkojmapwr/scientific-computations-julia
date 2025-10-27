# Joel Kojma
function get_float_max(x)
    type = typeof(x)
    multiplication_factor = type(2.0)
    prev_x = x
    while !isinf(x)
        prev_x = x
        x *= multiplication_factor
    end

    step = prev_x / type(2.0)
    while !isinf(prev_x + step)
        prev_x += step
        step /= type(2.0)
    end

    return prev_x
end

function main()
    float16_max = get_float_max(Float16(1.0))
    float32_max = get_float_max(Float32(1.0))
    float64_max = get_float_max(Float64(1.0))

    println("Calculated Float16 max: ", float16_max)
    println("Calculated Float32 max: ", float32_max)
    println("Calculated Float64 max: ", float64_max)

    println("floatmax(Float16) ", floatmax(Float16(1.0)))
    println("floatmax(Float32) ", floatmax(Float32(1.0)))
    println("floatmax(Float64) ", floatmax(Float64(1.0)))
end

main()