# Author: Joel Kojma

include("matrix.jl")
include("gauss.jl")

using .blocksys
using .Gauss

test_sizes = [100, 10000, 50000, 100000, 500000, 750000, 1000000]

test_dir = "my_tests/"

println("Usage: <program> <1/0> (1 if you want to read b from file, 0 to calculate via multiplication with 1 vector) <1/0> (1 if you want to run gauss with partial pivoting, 0 otherwise)")

read_b_from_file = true
use_partial_pivoting = false

if length(ARGS) < 2
    println("Not enough arguments provided, using default values: read_b_from_file = true, use_partial_pivoting = false")
else
    read_b_from_file = ARGS[1] == "1"
    use_partial_pivoting = ARGS[2] == "1"
end

for n in test_sizes
    println("Testing for n = $n")
    start_time = time()
    filename = "$(test_dir)Dane$(n)_1_1/A.txt"
    A = blocksys.read_sparse_matrix(filename)

    if read_b_from_file == false
        println("Calculating b via multiplication with 1 vector")
        ones_vector = ones(Float64, n)
        b = blocksys.multiply(A, ones_vector)
    else
        println("Reading b from file")
        b = blocksys.read_b("tests/Dane$(n)_1_1/b.txt")
    end

    # display(A.data)
    # display(b)

    # display_matrix(A)

    println("Number of elements held in matrix data: ", sum(A.row_lengths[i] for i in 1:n))

    Gauss.gauss_elimination(A, b)

    # display_matrix(A)

    x = Gauss.get_solution_from_triangle_matrix(A, b)

    println("Solution x saving to file")
    blocksys.save_solution(x, "$(test_dir)Dane$(n)_1_1/x.txt")
    end_time = time()
    println("Time taken for n = $n : $(end_time - start_time) seconds")
end