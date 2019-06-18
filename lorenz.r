#Ejemplo de Lorenz en R https://fromsystosys.netlify.com/2018/07/29/lorenz-attractor-animation-gganimate/

library(ggplot2)
library(gganimate)
# Solve differential equations
library(deSolve)
# 3D plots with ggplot2
# library(gg3D)


lorenz <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    dx <- sigma * (y - x)
    dy <- x * (rho - z) - y
    dz <- x * y - beta * z
    list(c(dx, dy, dz))
  })
}

# Solve with any initial condition
lorenz_solve <- function(y, t, params) {
  as.data.frame(ode(y = y, times = t, func = lorenz, parms = params, method = "ode45"))
}

# Specify parameters
parameters <- c(sigma = 10, beta = 8/3, rho = 28)
# Time over which the equations are numerically solved, 25 units
times <- seq(0, 25, 0.01)
# Initial conditions, in the order x, y, z
state <- c(x = 2, y = 3, z = 4)
state2 <- c(x = 2, y = 3, z = 4.1)
# Solve
sol <- lorenz_solve(state, times, parameters)
sol2 <- lorenz_solve(state2, times, parameters)
sol$init <- "(2,3,4)"
sol2$init <- "(2,3,4.1)"
# Combine the two solutions into the same data frame for plotting
# I dropped the last time point to get a nice number to get an integer number of frames
sols <- rbind(sol[1:2500,],sol2[1:2500,])

# xy
p1 <- ggplot(sols, aes(x, z, color = init)) +
  geom_path(data = sols[,-1], aes(x, z, color = init), size = 0.5) +
  geom_point() +
  scale_color_manual(values = c("#42e5f4", "#f441e2")) +
  # theme with white background
  theme_bw()  +
  # Make sure that units of the axes have the same length
  coord_equal() +
  # Use the time column in the data frame
  transition_time(time = time)
animate(p1, nframes = 2500, fps = 25, renderer = gifski_renderer())
# Save the animation
anim_save("lorenz_xz.gif")
