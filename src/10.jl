#!/usr/bin/env dk 202a3fcc9519 julia
using DelimitedFiles

function read_data(f::String)::Array{Int,2}
  readdlm(f, ',', Int, '\n')
end

function evolve!(data::Array{Int,2})
  while (maximum(data[:,2]) - minimum(data[:,2])) > 9
    data[:,1] += data[:,3]
    data[:,2] += data[:,4]
  end
end

function transform!(data::Array{Int,2})
  data[:,1] = maximum(data[:,1]) .- data[:,1]
  data[:,2] = maximum(data[:,2]) .- data[:,2]
end

function build_grid(points::Array{Int,2})::Array{Int64,2}
  xmin, xmax = minimum(points[:,1]), maximum(points[:,1])
  ymin, ymax = minimum(points[:,2]), maximum(points[:,2])
  grid = zeros(Int, ymax-ymin+1, xmax-xmin+1)
  for row in 1:size(points,1)
    grid[points[row,2]+1, points[row,1]+1] = 1
  end
  return grid
end

data = read_data("./dat/10.csv")
evolve!(data)
transform!(data)
grid = build_grid(data)

open("./dat/10_solution.csv", "w") do f
  writedlm(f, grid)
end

