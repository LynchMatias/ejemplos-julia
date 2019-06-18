#Ejemplo de graficos de disapositiva 8

using Plots
using StatsPlots
using Distributions

x = Plots.fakedata(50, 2)
y = rand(100,4)


p1 = plot(x)
p2 = scatter(x)
p3 = violin(["Series 1" "Series 2" "Series 3" "Series 4"],y,leg=false)
p4 = histogram(x)

plot(p1,p2,p3,p4,layout=(2,2),legend=false)
