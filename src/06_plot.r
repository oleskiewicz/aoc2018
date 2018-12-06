#!/usr/bin/env dk 0e6337158adf Rscript
library(tidyverse)

points <- read.csv("./dat/06.txt")
names(points) <- c("x", "y")
points <- points %>% mutate(x = x - 53, y = y - 46) # xmin, ymin

grid <- read.csv("./dat/06_grid.txt")
boundaries <- grid %>% filter(p == 0)

ggplot(grid, aes(x = x, y = y)) +
    geom_tile(aes(fill = factor(p))) + 
    geom_point(data = points, size = 1) +
    geom_point(data = boundaries, size = 0.2) +
    theme_void() +
    theme(legend.position="none")

ggsave("./plot.png")

