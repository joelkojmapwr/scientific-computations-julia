function scalar_forward(x, y, type, n)

    s = type(0.0)

    for i in 1:n
        s = s + x[i] * y[i]
    end
end

function scalar_backwards(x, y, type, n)
    s = type(0.0)

    for i in 1:n
        s = s + x[n - i - 1] * y[n - i - 1]
    end

end

function scalar_descending(x, y, type, n)

end