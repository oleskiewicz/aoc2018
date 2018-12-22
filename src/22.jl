#!/usr/bin/env -S dk julia julia
using Match
using Memoize

@memoize function geologic_index(x, y, depth)
    @match (x, y) begin
        (0, 0) => 0
        (7, 782) => 0
        (x, 0) => x * 16807
        (0, y) => y * 48271
        (x, y) => erosion_level(x - 1, y, depth) * erosion_level(x, y - 1, depth)
    end
end

function erosion_level(x, y, depth)
    return (geologic_index(x, y, depth) + depth) % 20183
end

function region(x, y, depth)
    return erosion_level(x, y, depth) % 3
end

# Part 1
a1 = sum(region(x, y, 11820) for x in 0:7 for y in 0:782)
println(a1)
