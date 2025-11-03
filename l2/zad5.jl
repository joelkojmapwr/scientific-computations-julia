# Joel Kojma

function getNextPn(pn, r)
    nextpn = pn + r * pn * (pn / pn - pn)
    return nextpn
end

function run_experiment(r, p0, iterations)
    p_array = []
    pn = p0
    for i in 1:iterations
        pn = getNextPn(pn, r)
        push!(p_array, pn)
        println("Iteration $i: p = $pn")
    end
    return p_array
end

function run_manipulated_experiment(r, p0, iterations)
    p_array = []
    pn = p0
    for i in 1:iterations
        pn = getNextPn(pn, r)
        if (i == 10)
            pn = floor(pn, digits=3)
        end
        push!(p_array, pn)
        println("Iteration $i: p = $pn")
    end

    return p_array
end

r = Float32(3.0)
p0 = Float32(0.01)

iterations = 40

println("----- Standard Experiment Float32 -----")
p_array_32 = run_experiment(r, p0, iterations)
println("----- Manipulated Experiment Float32 -----")
p_array_32_manipulated = run_manipulated_experiment(r, p0, iterations)
println("----- Standard Experiment Float64 -----")
r64 = Float64(3.0)
p064 = Float64(0.01)
p_array_64 = run_experiment(r64, p064, iterations)

for i in 1:iterations
    diff_32 = abs(p_array_32[i] - p_array_32_manipulated[i]) / p_array_32[i] * 100
    diff_64 = abs(p_array_64[i] - p_array_32[i]) / p_array_64[i] * 100
    println("Iteration $i: Relative difference Float32: $diff_32 %, Relative difference Float64: $diff_64 %")
end
