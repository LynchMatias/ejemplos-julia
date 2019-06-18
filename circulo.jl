# Codigo de diapositiva 9, gif de un circulo

using Plots

mutable struct Circuloo
    h; k; r
end


function step!(c::Circuloo, θ)
    c.h = c.r*sin(θ)
    c.k = c.r*cos(θ)
end


plt2 = plot(1, xlim=(-9, 9), ylim=(-9, 9), aspect_ratio=1,
        legend=false, lw=3)

myCirculo = Circuloo((h = 0., k = 0., r = 8)...)

@gif for θ ∈ LinRange(0, 2π, 500)
    step!(myCirculo, θ)
    push!(plt2, myCirculo.h, myCirculo.k)
end every 5
