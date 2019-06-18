using Distributed
addprocs(2) #llega hasta el proc_id 3


r = remotecall(rand, 2, 2, 2) #le indicas el process id. r es un FUTURE


s = @spawnat 2 1 .+ fetch(r) #en el worker 2 guarda 1+la matriz en r


fetch(s)


remotecall_fetch(getindex,2,r,1,1) #devuelve el primer elemento del future r

####

r = @spawn rand(2,2)

s = @spawn 1 .+ fetch(r) #se usa fetch pq no sabes donde corre este proceso

###

function sumar_cuatro(a)
    return a+4
end

fetch(@spawn sumar_cuatro(2)) #error

@everywhere function sumar_cuatro(a)
           return a+4
       end

fetch(@spawn sumar_cuatro(2)) #ahora funciona


### PATRON REDUCTION


function monedas(n)
    c::Int = 0
    for i = 1:n
        c += rand(Bool)
    end
    c
end
#con spawn
a = @spawn monedas(10000000)
b = @spawn monedas(10000000)

fetch(a)+fetch(b)

#con distributed

monedas = @distributed (+) for i = 1:20000000
    Int(rand(Bool))
end

interrupt()
