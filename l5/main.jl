include("matrix.jl")
include("gauss.jl")

using .SparseMatrices
using .Gauss


filename = "tests/Dane16_1_1/A.txt"
A = SparseMatrices.read_sparse_matrix(filename)

b = SparseMatrices.read_b("tests/Dane16_1_1/b.txt")

display(A.data)
display(b)

display_matrix(A)

Gauss.gauss_elimination(A, b)

display_matrix(A)