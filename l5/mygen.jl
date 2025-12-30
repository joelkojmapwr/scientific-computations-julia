# Author: Joel Kojma

# Used to generate the matrix for testing.


include("matrixgen.jl")

test_sizes = [100, 10000, 50000, 100000, 500000, 750000, 1000000]

for n in test_sizes
    println("Generating matrix for n = $n")
    matrixgen.blockmat(n, 10, 1.5, "my_tests/Dane$(n)_1_1/A.txt")
end