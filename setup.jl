import Pkg

PKGS = ["Plots", "ProgressMeter", "PyCall",
"Statistics", "StatsPlots"]

for paquete in PKGS
    Pkg.add(paquete)
end
