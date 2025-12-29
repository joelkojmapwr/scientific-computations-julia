module SparseMatrices 

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
    column_offsets::Vector{Int}
    column_lengths::Vector{Int}
    row_offsets::Vector{Int}
    row_lengths::Vector{Int}
    data::Vector{Vector{Float32}}
end

function SparseMatrix(n::Int, l::Int, data::Vector{Vector{Float32}})
    col_offs, col_lens = calculate_column_offsets_and_lengths(n, l)
    row_offs, row_lens = calculate_row_offsets_and_lengths(n, l)

    return SparseMatrix(
        n,
        l,
        col_offs,
        col_lens,
        row_offs,
        row_lens,
        data
    )
end

function multiply(A::SparseMatrix, x::Vector{Float64})
    n = A.n
    l = A.l
    result = zeros(Float64, n)

    for j in 1:n
        col_offset = A.column_offsets[j]
        col_length = A.column_lengths[j]
        column_data = A.data[j]

        for i in eachindex(column_data)
            result[j] += column_data[i] * x[j + col_offset]
        end
    end

    return result
end

function read_sparse_matrix(filename::String)
    open(filename, "r") do file
        # Read first line: n and l
        first_line = readline(file)
        parts = split(first_line)
        n = parse(Int, parts[1])
        l = parse(Int, parts[2])

        row_offsets, row_lengths = calculate_row_offsets_and_lengths(n, l)
        
        # Initialize data structure: data[j] contains all non-zero elements in row i
        data = [Vector{Float32}(0.0, row_lengths[i]) for i in 1:n]

        # Read remaining lines: i j value
        for line in eachline(file)
            if isempty(strip(line))
                continue
            end
            parts = split(line)
            i = parse(Int, parts[1])
            j = parse(Int, parts[2])
            value = parse(Float32, parts[3])

            # Store value in row i
            if (j < row_offsets[i] || j >= row_offsets[i] + row_lengths[i])
                error("Index j=$j out of bounds for row $i")
            end
            data[i][j - row_offsets[i]] = value
        end
        
        return SparseMatrix(n, l, data)
    end
end


export SparseMatrix, Point, read_sparse_matrix

end # module