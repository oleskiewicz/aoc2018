#!/usr/bin/env julia
using DelimitedFiles

function shift_index(rs)
  rs[:,2] = rs[:,2] .+ 1
  rs[:,3] = rs[:,3] .+ 1
  return rs
end

function populate(rs)
  max_x = maximum(rs[:,2] + rs[:,4])
  max_y = maximum(rs[:,3] + rs[:,5])
  g = zeros(Int, max_x, max_y)
  for i in 1:size(rs,1)
    r = rs[i,:]
    for x in r[2]:r[2]+r[4]-1
      for y in r[3]:r[3]+r[5]-1
        g[x, y] += 1
      end
    end
  end
  return g
end

function find_nonoverlap(g, rs)
  for i in 1:size(rs,1)
    i, x, y, w, h = rs[i,:]
    if all(c -> c == 1, g[x:x+w-1, y:y+h-1])
      return i
    end
  end
end

rs = readdlm("./dat/03.csv", ',', Int, '\n') |> shift_index
g = populate(rs)
overlaps = count(c -> c > 1, g)
nonoverlap = find_nonoverlap(g, rs)

println(nonoverlap)

