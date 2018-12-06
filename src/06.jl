#!/usr/bin/env dk 202a3fcc9519 julia
using DelimitedFiles

function read_points(f::String)
	readdlm(f, ',', Int, '\n')
end

function build_grid(points)
	xmin, ymin = minimum(points, dims=1)
	xmax, ymax = maximum(points, dims=1)
	grid = zeros(Int, xmax-xmin+1, ymax-ymin+1)
	for i in 1:size(points, 1)
			grid[points[i,1]-xmin+1, points[i,2]-ymin+1] = i
	end
	return grid, xmin, xmax, ymin, ymax
end

function select_points(points, xmin, xmax, ymin, ymax)
	findall(
		(points[:,1] .!= xmin) .&
		(points[:,2] .!= ymin) .&
		(points[:,1] .!= xmax) .&
		(points[:,2] .!= ymax))
end

function manhattan_distance(p1::Array{Int}, p2::Array{Int})
		abs(p1[1] - p2[1]) + abs(p1[2] - p2[2])
end

function populate_grid!(grid, distances)
	for x in 1:size(grid, 1)
		for y in 1:size(grid, 2)
			closest_points = findall(d -> d == minimum(distances[x, y, :]), distances[x, y, :])
			if length(closest_points) == 1
				grid[x, y] = closest_points[1]
			end
		end
	end
	return grid
end

function find_biggest_area(grid, selected_points)
	[count(grid .== p) for p in selected_points] |> maximum
end

points = read_points("./dat/06_test.txt")
grid, xmin, xmax, ymin, ymax = build_grid(points)
selected_points = select_points(points, xmin, xmax, ymin, ymax)
distances = [
	manhattan_distance([x, y], points[p,:])
		for x in xmin:xmax,
	      y in ymin:ymax,
	      p in 1:size(points, 1)
]
populate_grid!(grid, distances)
a1 = find_biggest_area(grid, selected_points)

println(a1)

#= for x in 1:size(grid, 1) =#
#= 	println(grid[x,:]) =#
#= end =#

