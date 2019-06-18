#Definicion de funciones y macros del ejemplo integrador.

using Plots, StatsBase, PyCall, Statistics, Distributed, StatsPlots, Distributions, Random

pushfirst!(PyVector(pyimport("sys")["path"]), "")
n = pyimport("nombres")

const MATERIA = 1
const ARCHIVO = 2

MATERIAS = ["AMII", "AMIII", "ALII", "TDL", "ALGOI", "ALGOII", "ALGOIII"]

function crear_archivo(nombre::Int64, cant_lineas::Int64)
    nombrecsv = string(nombre, "_2" ,".csv")
    println(nombrecsv)
    archivo = open(nombrecsv, "w")
    #write(archivo, join(CABECERA, ","))
        for i in 1:cant_lineas
        datos  = [rand(MATERIAS), rand(1:10)]
        write(archivo, join(datos, ",")*"\n")
        #write(archivo, "\n")
    end
    close(archivo)
end

function cant_notas(nombre::Int64, cant_lineas::Int64)
    nombrecsv = "$nombre.csv"
    println(nombrecsv)
    archivo = open(nombrecsv, "w")
    for i in 1:cant_lineas
        cant_materias = rand(1:5) #cantidad de materias cursadas
        nota = rand!(MersenneTwister(rand(1:1000)), zeros(1)) #arreglo de 1 solo float random
        datos = [rand(MATERIAS), nota[1]*10 - cant_materias <= 1 ? 1 : trunc(nota[1]*10 - cant_materias, digits=2), cant_materias]
        write(archivo, join(datos, ",")*"\n")
    end
    close(archivo)
end

function plotear_anios(archivos::Array{Int64})
    moda_notas = []
    for nombre in archivos
        nombre_archivo = string(nombre, "_2", ".csv")
        archivo = open(nombre_archivo, "r")
        notas_anio = []
        for linea in readlines(archivo)
            datos = split(linea, ",")
            push!(notas_anio, parse(Float64, datos[2]))
        end
        moda = mode(notas_anio)
        push!(moda_notas, moda)
        println(nombre, " listo")
        close(archivo)
    end
    pt = scatter(archivos, moda_notas, ylim=(1, 10), yticks=1:10,
    ylabel="Nota", xlabel="Anio", xticks=archivos ,title="Moda de notas",
    lw=2, legend=false)
    return pt
end

function puntos_scatter(nombre_archivo::String)
    x = Float64[]
    y = Float64[]
    archivo = open(string(nombre_archivo, ".csv"), "r")
    for linea in readlines(archivo)
        datos = split(linea, ",")
        push!(x, parse(Float64, datos[3]))
        push!(y, parse(Float64, datos[2]))
    end
    close(archivo)
    return x, y
end

function materia_en(materia , lista_tuplas)
    for index in 1:length(lista_tuplas)
        if materia == lista_tuplas[index][1]
            return index
        end
    end
    return 0
end

function separar_archivo(archivos)
    materias = []
    for nombre in archivos
        archivo = open(string(nombre, ".csv"), "r")
        for linea in readlines(archivo)
            datos = split(linea, ",")
            materia = datos[MATERIA] #El primer valor en Julia de un array es 1 (a diferencia de otros lenguajes que es 0)
            index = materia_en(datos[MATERIA], materias)
            if index != 0
                write(materias[index][ARCHIVO], linea*"\n")
            else
                push!(materias,(datos[MATERIA], open(string(datos[MATERIA],nombre,".csv"), "w")))
                write(materias[length(materias)][ARCHIVO], linea*"\n")
            end
        end
        close(archivo)
    end
    for materia in materias
        close(materia[ARCHIVO])
    end
end

function rcm(materia::String, anio::Int64) #recta por cuadrados minimos
    x, y = puntos_scatter(string(materia, anio))
    pt = plot(qqplot(x, y, qqline=:fit), xlabel="Cantidad de Materias",
    ylabel="Notas",title=string(materia, " ", anio))
    return(pt)
end


macro sec(n::Int64) #secuencial
    @time for anio in ANIOS
        cant_notas(anio, n)
    end
end

macro procesadores(n::Int64)
    @time pmap(x->cant_notas(x, n), ANIOS)
end
