#!/usr/bin/env -S dk julia julia
using Test

function read_grid(filename)
  grid = Matrix{Char}(undef, 10, 10)
  for (y, line) in enumerate(readlines(filename))
    for (x, char) in enumerate(split(line, ""))
    grid[y,x] = Char(char[1])
    end
  end
  #= split.(readlines(filename),"") =#
  grid
end

function neighbours(grid, x, y)
  x_min = x - 1 < 1 ? 1 : x - 1
  x_max = x + 1 > 10 ? 10 : x + 1
  y_min = y - 1 < 1 ? 1 : y - 1
  y_max = y + 1 > 10 ? 10 : y + 1
  result = copy(grid)
  result[x,y] = ' '
  result = result[x_min:x_max,y_min:y_max]
  result
end

function rules(cell, neighbourhood)
  n_open = count(c -> c == '.', neighbourhood)
  n_trees = count(c -> c == '|', neighbourhood)
  n_lumber = count(c -> c == '#', neighbourhood)

  # An open acre will become filled with trees if three or more adjacent acres contained trees. Otherwise, nothing happens.
  if cell == '.'
    if n_trees >= 3
      return '|'
    else
      return '.'
    end
  # An acre filled with trees will become a lumberyard if three or more adjacent acres were lumberyards. Otherwise, nothing happens.
  elseif cell == '|'
    if n_lumber >= 3
      return '#'
    else
      return '|'
    end
  # An acre containing a lumberyard will remain a lumberyard if it was adjacent to at least one other lumberyard and at least one acre containing trees. Otherwise, it becomes open.
  elseif cell == '#'
    if n_lumber >= 1 && n_trees >= 1
      return '#'
    else
      return '.'
    end
  end
end

function advance!(grid)
  for x in 1:10
    for y in 1:10
      grid[x,y] = rules(grid[x,y], neighbours(grid,x,y))
    end
  end
end

# Part 1
grid = read_grid("./dat/18_test.txt")
println(grid)

