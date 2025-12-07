module postac_naturalna

export naturalna

function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    n = length(fx)
    
    # Tworzymy wektor 'a' i kopiujemy do niego ilorazy różnicowe.
    # Na początku a[i] to nasze c_{i-1}.
    a = copy(fx)
    
    # KROK 2: Pętle przeliczające współczynniki
    # Zewnętrzna pętla 'k' idzie po węzłach od n-1 do 0 (w indeksowaniu Julii od n-1 do 1).
    # Odpowiada to kolejnym nawiasom (x - x_k) w postaci Newtona.
    for k in (n-1):-1:1
        
        # Wewnętrzna pętla 'j': Aktualizacja współczynników wektora 'a'.
        # Musimy zaktualizować współczynniki od k-tego do przedostatniego.
        # Działamy "w miejscu" na wektorze a.
        for j in k:(n-1)
            # Wzór: nowy a_j = stary a_j - x_k * a_{j+1}
            # To operacja odwrotna do wyciągania x przed nawias.
            a[j] = a[j] - x[k] * a[j+1]
        end
    end
    
    return a


end

end # module