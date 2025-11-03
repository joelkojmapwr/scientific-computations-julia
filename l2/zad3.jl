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
n = 3
A = hilb(n)
println("Hilbert matrix A (3x3):")
display(A)

x = inv(get_one_vector(n))
b = A * x