module Gauss 

function gauss_elimination(A, b::Vector{Float64})
    n = A.n
    
    for k in 1:(n-1)
        for i in (k+1):n 
            # Skip to next column 
            if A.row_offsets[i] > (k-1)
                println("Skipping row $i at column $k")
                break
            end
            I_factor = A.data[i][k - A.row_offsets[i]] / A.data[k][k - A.row_offsets[k]]
            for j in k:(A.row_offsets[k] + A.row_lengths[k]) # We need only to process to row lenghts of k, because the rest is zero and doesn't change the value when calculating A.data[i][idx_row_i] -= I_factor * A.data[k][idx_row_k] (0)
                idx_row_i = j - A.row_offsets[i]
                idx_row_k = j - A.row_offsets[k]

                if idx_row_i > A.row_lengths[i]
                    error("Row index at row i: $i out of bounds. J=$j")
                end
                if  idx_row_k > A.row_lengths[k]
                    error("Row index at row k: $k out of bounds. J=$j")
                end
                
                A.data[i][idx_row_i] -= I_factor * A.data[k][idx_row_k]
                
            end

            b[i] -= I_factor * b[k]

        end

    end 
    
end

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