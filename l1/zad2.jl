function kahan_check(type)
    result = type(3.0) * (type(4.0) / type(3.0) - type(1.0)) - type(1.0)
    return result
end

function main()

    macheps_float16 = kahan_check(Float16)

    println("Kahan expression value for float16 is: ", macheps_float16)

    macheps_float32 = kahan_check(Float32)

    println("Kahan expression value for Float32 is: ", macheps_float32)

    macheps_float64 = kahan_check(Float64)

    println("Kahan expression value for float64 is:", macheps_float64)

end

main()