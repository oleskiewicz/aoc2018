#!/usr/bin/env dk 202a3fcc9519 julia
using DelimitedFiles

function read_points(f::String)::Array{Int,2}
	readdlm(f, ',', Int, '\n')
end

function build_grid(points::Array{Int,2})::Tuple{Array{Int64,2},Int64,Int64,Int64,Int64}
	xmin, ymin = minimum(points, dims=1)
	xmax, ymax = maximum(points, dims=1)
	grid = zeros(Int, xmax-xmin+1, ymax-ymin+1)
	for i in 1:size(points, 1)
			grid[points[i,1]-xmin+1, points[i,2]-ymin+1] = i
	end
	return grid, xmin, xmax, ymin, ymax
end

function select_points(points::Array{Int,2}, xmin::Int, xmax::Int, ymin::Int, ymax::Int)::Array{Int}
	findall(
		(points[:,1] .!= xmin) .&
		(points[:,2] .!= ymin) .&
		(points[:,1] .!= xmax) .&
		(points[:,2] .!= ymax))
end

function manhattan_distance(p1::Array{Int}, p2::Array{Int})::Int
		abs(p1[1] - p2[1]) + abs(p1[2] - p2[2])
end

function populate_grid!(grid::Array{Int,2}, distances::Array{Int,3})
	for x in 1:size(grid, 1)
		for y in 1:size(grid, 2)
			closest_points = findall(d -> d == minimum(distances[x, y, :]), distances[x, y, :])
			if length(closest_points) == 1
				grid[x, y] = closest_points[1]
			end
		end
	end
end

function find_biggest_area(grid::Array{Int,2}, selected_points::Array{Int})::Int
	maximum([count(grid .== p) for p in selected_points])
end

function find_region_nearest(grid::Array{Int,2}, selected_points::Array{Int})::Int
	count(
		[sum(distances[x,y,:])
		 for x in 1:size(grid,1), y in 1:size(grid,2)]
		.< 10000
	)
end

# Part 1
points = read_points("./dat/06.txt")
grid, xmin, xmax, ymin, ymax = build_grid(points)
#= println(xmin) =#
#= println(ymin) =#

selected_points = select_points(points, xmin, xmax, ymin, ymax)
#= for p in selected_points =#
#=		 println(p) =#
#= end =#

distances = [
manhattan_distance([x, y], points[p,:])
for x in xmin:xmax, y in ymin:ymax, p in 1:size(points, 1)
]
populate_grid!(grid, distances)
#= println("x,y,p") =#
#= for x in 1:size(grid,1) =#
#= for y in 1:size(grid,2) =#
	#= println("$x,$y,$(grid[x,y])") =#
#= end =#
#= end =#

area_1 = find_biggest_area(grid, selected_points)
println(area_1)

# Part 2
area_2 = find_region_nearest(grid, distances)
println(area_2)

# NOTE: https://github.com/KristofferC/NearestNeighbors.jl would be better

