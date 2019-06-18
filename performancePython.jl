#Pruebas de performance entre Julia y Python

using PyCall, StatsBase

pushfirst!(PyVector(pyimport("sys")["path"]), "")
n = pyimport("nombres")

LENGTH = 1000000

a = []
for _ in 1:LENGTH
    push!(a, rand(1:100))
end


@time mode(a)
@time n.moda(a)
