module SparseMatrices 

struct Point 
    value::Float64
    offset::Int # From 1 to n
end

function calculate_column_offsets_and_lengths(n::Int, l::Int)
    v::Int = div(n, l) # v = n / l
    column_offsets = Vector{Int}(0, l)
    column_lengths = Vector{Int}(0, l)

    for i in 1:(l-1) 
        column_offsets[i] = 0
        column_lengths[i] = l + 1
    end
    column_offsets[l] = 0
    column_lengths[l] = 2*l


    for k in 2:(v-1)
        for i in 1:l
            column_offsets[(k-1)*l+i] = i - 1 + (k-2)*l
            column_lengths[(k-1)*l+i] = 2*l + 2 - i
        end
        column_lengths[2*l] = 2*l + 1



end

struct SparseMatrix
    n::Int
    l::Int
    data::Vector{Vector{Point}}
end

export SparseMatrix, Point

end # module