#!/usr/bin/env dk 202a3fcc9519 julia
using DelimitedFiles

function find_prerequisites(table::Array{Char,2})::Array{Char}
  setdiff(Set(table[:,1]), Set(table[:,2])) |> collect |> sort
end

function flatten_graph(table)
  if size(table, 1) > 1
    node = find_prerequisites(table)[1]
    print(node)
    flatten_graph(table[table[:,1] .!= node,:])
  elseif size(table, 1) == 1
    for node in table
      print(node)
    end
  else
  end
end

#= @assert flatten_graph(table) == "CABDFE" =#

table = readdlm("./dat/07.csv", ',', Char, '\n')

# Part 1
flatten_graph(table)
