

function get_macheps_float16()
    x::Float16 = 1.0
    y::Float16 = 1.0
    prev_y::Float16 = y
    while (x + y > x) 
        prev_y = y
        y /= 2.0
    end
    return prev_y
end

function get_macheps_float32()
    x::Float32 = 1.0
    y::Float32 = 1.0
    prev_y::Float32 = y
    while (x + y > x) 
        prev_y = y
        y /= 2.0
    end
    return prev_y
end

function get_macheps_float64()
    x::Float64 = 1.0
    y::Float64 = 1.0
    prev_y::Float64 = y
    while (x + y > x) 
        prev_y = y
        y /= 2.0
    end
    return prev_y
end

function get_eta_float16()
    x::Float16 = 1.0

    prev_x = x 
    while (x > 0.0)
        prev_x = x
        x /= 2.0
    end
    return prev_x
end

function get_eta_float32()
    x::Float32 = 1.0

    prev_x = x
    while (x > 0.0)
        prev_x = x
        x /= 2.0
    end
    return prev_x
end

function get_eta_float64()
    x::Float64 = 1.0

    prev_x = x
    while (x > 0.0)
        prev_x = x
        x /= 2.0
    end
    return prev_x
end

function print_macheps()
    macheps_float16 = get_macheps_float16()
    println("Calculated Macheps float16 = $macheps_float16")
    println("Expected Macheps float16 = $(eps(Float16))")
    macheps_float32 = get_macheps_float32()
    println("Calculated Macheps float32 = $macheps_float32")
    println("Expected Macheps float32 = $(eps(Float32))")
    macheps_float64 = get_macheps_float64()
    println("Calculated Macheps float64 = $macheps_float64")
    println("Expected Macheps float64 = $(eps(Float64))")
end

function print_eta()
    eta_float16 = get_eta_float16()
    println("Calculated Eta float16 = $eta_float16")
    println("Expected Eta float16 = $(nextfloat(Float16(0.0)))")
    eta_float32 = get_eta_float32()
    println("Calculated Eta float32 = $eta_float32")
    println("Expected Eta float32 = $(nextfloat(Float32(0.0)))")
    eta_float64 = get_eta_float64()
    println("Calculated Eta float64 = $eta_float64")
    println("Expected Eta float64 = $(nextfloat(Float64(0.0)))")
end

function main()
    print_macheps()
    print_eta()
end


main()