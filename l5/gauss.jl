module Gauss 

function gauss_elimination(A, b::Vector{Float64})
    n = A.n
    
    for k in 1:(n-1)
        for i in (k+1):n 
            # Skip to next column 
            if A.row_offsets[i] > (k-1)
                break
            end
            I_factor = A.data[i][k - A.row_offsets[i]] / A.data[k][k - A.row_offsets[k]]
            for j in (k+1):(A.row_offsets[k] + A.row_lengths[k]) # We need only to process to row lenghts of k, because the rest is zero and doesn't change the value when calculating A.data[i][idx_row_i] -= I_factor * A.data[k][idx_row_k] (0)
                idx_row_i = j - A.row_offsets[i]
                idx_row_k = j - A.row_offsets[k]

                if idx_row_i > A.row_lengths[i] || idx_row_k > A.row_lengths[k]
                    error("Row index at row $i or $k out of bounds. J=$j")
                end
                
                A.data[i][idx_row_i] -= I_factor * A.data[k][idx_row_k]
                
            end

            b[i] -= I_factor * b[k]

        end

    end 
    println("Matrix after gauss_elimination")
    display(A.data)

end

end # module