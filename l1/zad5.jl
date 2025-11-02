# Joel Kojma

function scalar_forward(x, y, type, n)

    s = type(0.0)

    for i in 1:n
        s = s + x[i] * y[i]
    end
    return s
end

function scalar_backwards(x, y, type, n)
    s = type(0.0)

    for i in 1:n
        s = s + x[n - i + 1] * y[n - i + 1]
    end
    return s
end

function scalar_descending(x, y, type, n)

    products = Vector{type}(undef, n)

    for i in 1:n
        products[i] = x[i] * y[i]
    end

    sort!(products, rev=true)

    negative_products = filter(p -> p < type(0.0), products)
    positive_products = filter(p -> p >= type(0.0), products)

    positive_sum = type(0.0)
    k = length(positive_products)
    for i in 1:k
        positive_sum = positive_sum + positive_products[k-i+1]
        # println("Positive Product $i: ", positive_products[k - i + 1])
    end
    l = length(negative_products)
    negative_sum = type(0.0)
    for i in 1:l
        negative_sum = negative_sum + negative_products[i]
        # println("Negative Product $i: ", negative_products[i])
    end
    # println("Negative sum: ", negative_sum)
    # println("Positive sum: ", positive_sum)

    return positive_sum + negative_sum
end

function scalar_ascending(x, y, type, n)

    products = Vector{type}(undef, n)

    for i in 1:n
        products[i] = x[i] * y[i]
    end

    sort!(products)

    negative_products = filter(p -> p < type(0.0), products)
    positive_products = filter(p -> p >= type(0.0), products)

    positive_sum = type(0.0)
    k = length(positive_products)
    for i in 1:k
        positive_sum = positive_sum + positive_products[i]
        # println("Positive Product $i: ", positive_products[i])
    end
    l = length(negative_products)
    negative_sum = type(0.0)
    for i in 1:l
        negative_sum = negative_sum + negative_products[l - i + 1]
        # println("Negative Product $i: ", negative_products[l - i + 1])
    end

    sum = positive_sum + negative_sum

    return sum
end

function aggregate(x_orig, y_orig, type, n)

    x = Vector{type}(undef, n)
    y = Vector{type}(undef, n)

    for i in 1:n
        x[i] = type(x_orig[i]) # convert to desired type
        y[i] = type(y_orig[i])
        # println("x[$i]: ", x[i], " y[$i]: ", y[i])
    end

    println("Scalar forward: ", scalar_forward(x, y, type, n))
    println("Scalar backwards: ", scalar_backwards(x, y, type, n))
    println("Scalar descending: ", scalar_descending(x, y, type, n))
    println("Scalar ascending: ", scalar_ascending(x, y, type, n))

end

x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

# x = [2.0, 3.0]
# y = [1.0, 5.0]
println("Float32 results:")
aggregate(x, y, Float32, length(x))
println("")
println("Float64 results:")
aggregate(x, y, Float64, length(x))
