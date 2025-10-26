

function float_distribution(start_x, end_x)

    next = nextfloat(start_x)
    step = next - start_x
    println("Start_x: ", bitstring(start_x))
    println("Next: ", bitstring(next))
    current = start_x
    for i in 1:52
        current = current + step
        step *= 2.0
    
        println("Current $i: ", bitstring(current))
    end

    println("End_x:      ", bitstring(end_x))

end

println("Dystrybucja [1.0, 2.0]")
float_distribution(Float64(1.0), Float64(2.0))

println("\nDystrybucja [0.5, 1.0]")
float_distribution(Float64(0.5), Float64(1.0))

println("\nDystrybucja [2.0, 4.0]")

float_distribution(Float64(2.0), Float64(4.0))