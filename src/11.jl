#!/usr/bin/env dk 202a3fcc9519 julia

function power_level(x::Int, y::Int, serial_number::Int)::Int
  rack_id = x + 10
  power_level = rack_id * y
  power_level += serial_number
  power_level *= rack_id
  return Int(floor((power_level / 100 % 10) - 5))
end

function build_grid(xs::Int, ys::Int, serial_number::Int)::Array{Int,2}
  return [power_level(x, y, serial_number) for x in 1:xs, y in 1:ys]
end

function find_max_fuel_cell(grid::Array{Int,2})
  max_cell, max_index = sum.(grid[x:x+2, y:y+2] for x in 1:size(grid,1)-2, y in 1:size(grid,2)-2) |> findmax
  return max_index[1], max_index[2]
end

function find_max_fuel_cell_size(grid::Array{Int,2})
  cell_sizes::Array{Int,1} = []
  cell_maxima::Array{Int,1} = []
  cell_xs::Array{Int,1} = []
  cell_ys::Array{Int,1} = []
  for cell_size in 3:30
    max_cell, max_index = sum.(grid[x:x+cell_size-1, y:y+cell_size-1] for x in 1:size(grid,1)-(cell_size-1), y in 1:size(grid,2)-(cell_size-1)) |> findmax
    push!(cell_sizes, cell_size)
    push!(cell_maxima, max_cell)
    push!(cell_xs, max_index[1])
    push!(cell_ys, max_index[2])
  end
  i = findmax(cell_maxima)[2]
  return cell_xs[i], cell_ys[i], cell_sizes[i]
end

# Part 1
grid = build_grid(300, 300, 3463)
println(find_max_fuel_cell(grid))

# Part 2
println(find_max_fuel_cell_size(grid))

