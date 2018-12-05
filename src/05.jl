#!/usr/bin/env dk 202a3fcc9519 julia

function fold(s::String)
	# string to array, and split into two shifted arrays
	s = collect(s)
	s1, s2 = s[1:end-1], s[2:end]

	# indices at which characters match
	# I wanted to add consecutive index here, but can't figure out julia arrya
	# comprehension with more than one element...
	indices = [i
		for (i, (c1, c2))
		in enumerate(zip(s1, s2))
		if ((uppercase(c1) == c2) || (lowercase(c1) == c2))
	]

	# remove triplets
	for (i, index) in enumerate(indices[1:end-1])
		if indices[i] == indices[i+1] - 1
			deleteat!(indices, i+1)
		end
	end

	# fold
	deleteat!(s, indices)
	deleteat!(s, indices)

	return indices, String(s)
end

s = readline("./dat/05_test.txt")
while true
	global i, s = fold(s)
	if length(i) == 0
		break
	end
end

println(length(s))

