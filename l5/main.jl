include("matrix.jl")
include("gauss.jl")

using .SparseMatrices
using .Gauss

test_sizes = [16, 10000, 50000, 100000, 500000, 750000, 1000000]


for n in test_sizes
    println("Testing for n = $n")
    filename = "tests/Dane$(n)_1_1/A.txt"
    A = SparseMatrices.read_sparse_matrix(filename)

    b = SparseMatrices.read_b("tests/Dane$(n)_1_1/b.txt")

    # display(A.data)
    # display(b)

    # display_matrix(A)

    Gauss.gauss_elimination(A, b)

    # display_matrix(A)

    x = Gauss.get_solution_from_triangle_matrix(A, b)

    println("Solution x saving to file")
    SparseMatrices.save_solution(x, "tests/Dane$(n)_1_1/x.txt")
end