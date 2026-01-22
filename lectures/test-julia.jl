# Simple Julia program
y = Float32(2.0^-24)
z = Float32(2.0^-28)
yz = y + z
println(bitstring(y))
println(bitstring(z))
println(bitstring(yz))
x = Float32(1 + yz)
println(bitstring(x))
