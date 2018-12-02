#!/usr/bin/env julia

function index_repeated(ids)
	result = -1
	for i in (1:length(ids)-1)
		result = count([c1 != c2 for (c1, c2) in zip(ids[i],ids[i+1])])
		if result == 1
			return (i, i+1)
		end
	end
end

function common_characters(s1, s2)
	for (c1, c2) in zip(s1, s2)
		if c1 == c2
			print(c1)
		end
	end
	print("\n")
end

ids = readlines("./dat/02.txt") |> sort
ids_repeated = index_repeated(ids)
common_characters(ids[ids_repeated[1]], ids[ids_repeated[2]])

