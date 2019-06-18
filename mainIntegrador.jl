using Distributed

#addprocs(4)

@everywhere include("Integrador.jl")

ANIOS = collect(2010:2016)

#@sec 10000 #crea los archivos con notas (floats) y cantidad de materias de forma secuencial

#@procesadores 100000
#crea los archivos con notas (floats) y cantidad de materias con workers


#@time for anio in ANIOS  #Crea los archivos con notas (ints) de forma secuencial
    #crear_archivo(anio, 10000000)
#end#

#@time pmap(anio->crear_archivo(anio, 100000), ANIOS) #crea los archivos con notas (ints) con workers
#interrupt() #IMPORTANTE USAR SI HACEN EL ADDPROCS DE LA LINEA 3


#pt = plotear_anios(ANIOS) #plotea los archivos con notas (ints)
#display(pt) #muestra el plot


separar_archivo(2015) #separa los archivos de notas y cantidad de notas para la recta de cuadrador minimos

cuadrados_minimos = rcm("ALGOII", 2015) #recta de cuadrados minimos

plot(cuadrados_minimos) #muestra la rcm
