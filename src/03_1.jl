#!/usr/bin/env julia
using DelimitedFiles

function shift_index(rs)
  rs[:,1] = rs[:,1] .+ 1
  rs[:,2] = rs[:,2] .+ 1
  return rs
end

function populate(rs)
  max_x = maximum(rs[:,1] + rs[:,3])
  max_y = maximum(rs[:,2] + rs[:,4])
  g = zeros(Int, max_x, max_y)
  for i in 1:size(rs,1)
    r = rs[i,:]
    for x in r[1]:r[1]+r[3]-1
      for y in r[2]:r[2]+r[4]-1
        g[x, y] += 1
      end
    end
  end
  return count(e -> e > 1, g)
end

readdlm("./dat/03_test.csv", ',', Int, '\n') |>
  shift_index |>
  populate |>
  println
