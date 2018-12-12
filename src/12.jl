#!/usr/bin/env dk 202a3fcc9519 julia

function read_rules(filename::String)::Dict{String,String}
result = Dict{String,String}()
  for line in readlines(filename)
    k, v = split(line, " => ")
    if v == "#"
      push!(result, k => v)
    end
  end
  return result
end

function evolve(current::Set{Int}, rules::Dict{String,String})::Set{Int}
  next = Set{Int}()
  for i in minimum(current)-2:maximum(current)+2
    window = join([k + i in current ? '#' : '.' for k in [-2, -1, 0, 1, 2]], "")
    if haskey(rules, window)
      push!(next, i)
    end
  end
  return next
end

function evolve(current::Set{Int}, rules::Dict{String,String}, steps::Int)::Set{Int}
  next = current
  for t in 1:steps
     next = evolve(next, rules)
  end
  return next
end

#= plants = "#..#.#..##......###...###" =#
#= rules = read_rules("./dat/12_test.txt") =#
plants = "##..#.#.#..##..#..##..##..#.#....#.....##.#########...#.#..#..#....#.###.###....#..........###.#.#.."
rules = read_rules("./dat/12.txt")
pots = Set(i - 1 for (i, c) in enumerate(plants) if c == '#')

# Part 1
evolve(pots, rules, 20) |> sum |> println

