# Joel Kojma

using Plots


function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>=1
#
#
# Usage: hilb(10)
#
# Pawel Zielinski
        if n < 1
         error("size n should be >= 1")
        end
        return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

using LinearAlgebra

function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond(10, 100.0)
#
# Pawel Zielinski
        if n < 2
         error("size n should be > 1")
        end
        if c< 1.0
         error("condition number  c of a matrix  should be >= 1.0")
        end
        (U,S,V)=svd(rand(n,n))
        return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end


function print_matrix(A; precision=6)
    m, n = size(A)
    for i in 1:m
        for j in 1:n
            print(lpad(string(round(A[i,j], digits=precision)), precision+3))
        end
        println()
    end
end

function get_one_vector(n::Int)
    v = zeros(Float64, n)
    for i in 1:n
        v[i] = 1.0
    end
    return v
end

function solve_gauss(A, b)
    return A \ b
end

function solve_inverse(A, b)
    A_inv = inv(A)
    return A_inv * b
end

function hilbert_experiment()

    rel_errors_gauss = []
    rel_errors_inverse = []
    conds = []
    for i in 1:20
        n = i
        A = hilb(n)
        x = get_one_vector(n)
        b = A * x

        x_gauss = solve_gauss(A, b)
        x_inverse = solve_inverse(A, b)

        rel_gauss_error = norm(x - x_gauss, Inf)
        rel_inverse_error = norm(x - x_inverse, Inf)
        push!(rel_errors_gauss, rel_gauss_error)
        push!(rel_errors_inverse, rel_inverse_error)

        cond_A = cond(A, Inf)
        push!(conds, cond_A)

        println("n = $n, cond(A) = $cond_A, Error Gauss: $rel_gauss_error, Error Inverse: $rel_inverse_error")
    end

    
    plot(1:20, rel_errors_gauss, label="Gauss Elimination", xlabel="Matrix Size (n)", ylabel="Relative Error", title="Relative Errors for Hilbert Matrix")
    plot!(1:20, rel_errors_inverse, label="Matrix Inverse")
    # plot(1:20, conds, label="Condition Number", xlabel="Matrix Size (n)", ylabel="Condition Number", title="Condition Numbers for Hilbert Matrix", yaxis=:log)
    display(plot!())


end

function random_experiment()
    n_array = [5, 10, 20]
    c_array = [1, 10, 10e3, 10e7, 10e12, 10e16]
    for n in n_array
        rel_errors_gauss = []
        rel_errors_inverse = []
        
        for c in c_array
            A = matcond(n, c)
            x = get_one_vector(n)
            b = A * x

            x_gauss = solve_gauss(A, b)
            x_inverse = solve_inverse(A, b)

            rel_gauss_error = norm(x - x_gauss, Inf)
            rel_inverse_error = norm(x - x_inverse, Inf)

            push!(rel_errors_gauss, rel_gauss_error)
            push!(rel_errors_inverse, rel_inverse_error)

            cond_A = cond(A, Inf)

            println("n = $n, c = $c, cond(A) = $cond_A, Error Gauss: $rel_gauss_error, Error Inverse: $rel_inverse_error")
        end
        plot(c_array, rel_errors_gauss, xscale=:log10, yscale=:log10, label="Gauss Elimination", xlabel="Condition Number", ylabel="Relative Error", title="Relative Errors for Random Matrix of size $n")
        plot!(c_array, rel_errors_inverse, label="Matrix Inverse")
        display(plot!())
        println("Press Enter to continue to next matrix size...")
        readline()
    end

end

n = 3
A = hilb(n)
println("Hilbert matrix A (3x3):")
display(A)

x = get_one_vector(n)
display(x)
b = A * x

x_gauss = solve_gauss(A, b)
display(x_gauss)

x_inverse = solve_inverse(A, b)
display(x_inverse)

hilbert_experiment()

println("Press Enter to close the plots...")
readline()


println("----- Random Matrix Experiment -----")
random_experiment()