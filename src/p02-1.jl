#!/usr/bin/env julia

function checksum(ids)
	num_2 = 0
	num_3 = 0
	for id in ids
		chars = split(id, "")
		char_map = Dict([a => count(b -> b == a, chars) for a in unique(chars)])
		if 2 in values(char_map)
			num_2 += 1
		end
		if 3 in values(char_map)
			num_3 += 1
		end
	end
	return num_2 * num_3
end

readlines("./dat/02.txt") |>
	checksum |>
	println
