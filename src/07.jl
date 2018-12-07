#!/usr/bin/env dk 202a3fcc9519 julia
using DelimitedFiles

function find_first(table::Array{Char,2})::Array{Char}
  setdiff(Set(table[:,1]), Set(table[:,2])) |> collect |> sort
end

function flatten_graph(firsts, table)
  sort!(firsts)
  for c in firsts
    println(c)
  end
  nexts::Array{Char,1} = []
  for c in firsts
    append!(nexts, table[table[:,1] .== c, 2])
    flatten_graph(
      table[table[:,1] .== c, 2],
      table[table[:,1] .!= c, :]
    )
  end
end

table = readdlm("./dat/07_test.csv", ',', Char, '\n')
beginning = find_first(table)
flatten_graph(beginning, table)
