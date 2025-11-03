# Joel Kojma
using Plots


function getNextPn(pn, r)
    nextpn = pn * pn + r
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

c_array = Float64[-2, -2, -2, -1, -1, -1, -1]
x0_array = Float64[1, 2,  1.99999999999999, 1, -1, 0.75, 0.25]

iterations = 40

results_array = []

for i in eachindex(c_array)
    push!(results_array, run_experiment(c_array[i], x0_array[i], iterations))
end

plot_titles = [
    "c = -2, x0 = 1",
    "c = -2, x0 = 2",
    "c = -2, x0 = 1.99999999999999",
    "c = -1, x0 = 1",
    "c = -1, x0 = -1",
    "c = -1, x0 = 0.75",
    "c = -1, x0 = 0.25"
]

# Plot for c = -2
p1 = plot(size=(1800, 1200), title="c = -2")
for i in 1:3
    plot!(p1, results_array[i], label=plot_titles[i])
end

# Plot for c = -1
p2 = plot(size=(1800, 1200), title="c = -1")
for i in 4:7
    plot!(p2, results_array[i], label=plot_titles[i])
end

display(p1)
println("Press Enter to close the plots...")
readline()

display(p2)

println("Press Enter to close the plots...")
readline()
