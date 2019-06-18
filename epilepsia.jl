#Intento de dos graficos en un solo gif - PELIGRO DE EPILEPSIA

using Plots

mutable struct Funcionn
    x; y; z;
end

mutable struct Circuloo
    h; k; r
end


function cNext!(f::Funcionn)
    f.x = f.x + 0.1
    f.y = f.y + 0.1
    f.z = (f.x)^2 + (f.y)^2
end


function step!(c::Circuloo, θ)
    c.h = c.r*sin(θ)
    c.k = c.r*cos(θ)
end



myFuncion = Funcionn((x = -3., y = -3., z = 0.)...)


plt2 = plot(1, xlim=(-15, 15), ylim=(-15, 15), aspect_ratio=1,
        legend=false, lw=3)

plt = plot3d(1, xlim=(-5, 5), ylim=(-5, 5), zlim=(-1 , 1),
                title="Grafico", marker=2)

plotMaster = plot(plt, plt2)

@gif for i=1.:10.
    myCirculo = Circuloo((h = 0., k = 0., r = i)...)
    for θ ∈ LinRange(0, 2π, 500)
        step!(myCirculo, θ)
        push!(plt2, myCirculo.h, myCirculo.k)
    end
end every 1
