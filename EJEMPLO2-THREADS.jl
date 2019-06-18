#cambiar la cantidad de threads con export JULIA_NUM_THREADS=n
#hacer lo de los thread ids

a = zeros(100)
b = zeros(100)

function sin_paralelismo(arr)
    for i = 1:100
        arr[i] = i^i
    end
end

@time sin_paralelismo(a)


@time Threads.@threads for i = 1:100
           b[i] = i^i
       end
