module Gauss 
include("matrix.jl")

using .SparseMatrices

function gauss_elimination(A::SparseMatrix, b::Vector{Float64})
    n = A.n
    
end

end # module