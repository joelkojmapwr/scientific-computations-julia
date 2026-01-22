# Author: Joel Kojma



module Gauss 

# Returns the row index of the maximum absolute value in column 'col' starting from 'start_row'
function find_max_in_column(A, col::Int, start_row::Int)
    n = A.n
    max_row = start_row
    max_value = abs(A.data[start_row][col - A.row_offsets[start_row]])
    
    for i in (start_row+1):n
        if A.row_offsets[i] >= col
            break
        else
            current_value = abs(A.data[i][col - A.row_offsets[i]])
            if current_value > max_value
                max_value = current_value
                max_row = i
            end
        end
    end
    # println("Max in column $col from row $start_row is at row $max_row with value $max_value")
    return max_row
end


# Performs Gaussian elimination on matrix A and vector b
function gauss_elimination(A, b::Vector{Float64}, use_partial_pivoting::Bool=false, display_fn=nothing)
    n = A.n
    
    for k in 1:(n-1)
        
        if use_partial_pivoting == true
            max_row = find_max_in_column(A, k, k)
            if max_row != k
                # println("Pivoting: swapping row $k with row $max_row")
                # Swap rows in A
                A.data[k], A.data[max_row] = A.data[max_row], A.data[k]
                A.row_offsets[k], A.row_offsets[max_row] = A.row_offsets[max_row], A.row_offsets[k]
                A.row_lengths[k], A.row_lengths[max_row] = A.row_lengths[max_row], A.row_lengths[k]
                # Swap corresponding entries in b
                b[k], b[max_row] = b[max_row], b[k]
            end
        end

        if display_fn !== nothing
            display_fn(A)
        end

        for i in (k+1):n 
            # Skip to next column 
            if A.row_offsets[i] > (k-1) # If row starting later than the current column k that we eliminate
                # println("Skipping row $i at column $k")
                break
            end
            I_factor = A.data[i][k - A.row_offsets[i]] / A.data[k][k - A.row_offsets[k]]
            # println("Eliminating row $i using row $k with factor $I_factor")
            for j in k:(A.row_offsets[k] + A.row_lengths[k]) # We need only to process to row lenghts of k, because the rest is zero and doesn't change the value when calculating A.data[i][idx_row_i] -= I_factor * A.data[k][idx_row_k] (0)
                idx_row_i = j - A.row_offsets[i]
                idx_row_k = j - A.row_offsets[k]

                if idx_row_i > A.row_lengths[i]
                    error("Row index at row i: $i out of bounds. J=$j, row_lengths=$(A.row_lengths[i]), row_offsets=$(A.row_offsets[i])")
                end
                if  idx_row_k > A.row_lengths[k]
                    error("Row index at row k: $k out of bounds. J=$j, row_lengths=$(A.row_lengths[k]), row_offsets=$(A.row_offsets[k])")
                end
                
                A.data[i][idx_row_i] -= I_factor * A.data[k][idx_row_k]
                
            end

            b[i] -= I_factor * b[k]

        end

    end 
    
end


# Input: Upper triangular matrix A in SparseMatrix format and vector b
# Output: Solution vector x such that Ax = b
function get_solution_from_triangle_matrix(A, b::Vector{Float64})
    n = A.n
    x = Vector{Float64}(undef, n)
    
    x[n] = b[n] / A.data[n][n - A.row_offsets[n]]

    for k in (n-1):-1:1
        sum_ax = 0.0
        for j in (k+1):(A.row_offsets[k] + A.row_lengths[k])
            idx_row_k = j - A.row_offsets[k]
            sum_ax += A.data[k][idx_row_k] * x[j]
        end
        x[k] = (b[k] - sum_ax) / A.data[k][k - A.row_offsets[k]]
    end

    return x
end

end # module