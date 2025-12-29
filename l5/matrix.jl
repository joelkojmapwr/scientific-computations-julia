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
        column_lengths[k*l] = 2*l + 1
    end

    for i in 1:l
        column_offsets[(v-1)*l + i] = i - 1 + (v-2)*l
        column_lengths[(v-1)*l + i] = 2*l + 1 - i
    end

    return column_offsets, column_lengths
end

function calculate_row_offsets_and_lengths(n::Int, l::Int)
    v::Int = div(n, l) # v = n / l
    row_offsets = Vector{Int}(0, n)
    row_lengths = Vector{Int}(0, n)

    for i in 1:l
        row_offsets[i] = 0
        row_lengths[i] = l + i
    end

    for k in 2:(v-1)
        row_offsets[(k-1)*l + 1] = (k-2)*l # handling first row of Bk
        row_lengths[(k-1)*l + 1] = 2*l + 1
        for i in 2:l
            row_offsets[(k-1)*l + i] = (k-1)*l - 1
            row_lengths[(k-1)*l + i] = l + i + 1 # Ak + Ck + Bk
        end
    end

    row_offsets[(v-1)*l + 1] = (v-2)*l
    row_lengths[(v-1)*l + 1] = 2 * l + 1
    for i in 2:l
        row_offsets[(v-1)*l + i] = (v-2)*l - 1
        row_lengths[(v-1)*l + i] = l + 1 # Ak + Bk
    end

    return row_offsets, row_lengths
end


struct SparseMatrix
    n::Int
    l::Int
    data::Vector{Vector{Point}}
end

export SparseMatrix, Point

end # module