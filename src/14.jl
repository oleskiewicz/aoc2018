#!/usr/bin/env -S dk julia julia
using Test

function tick(scores::Array{Int,1}, e1::Int, e2::Int)::Tuple{Array{Int,1},Int,Int}
	append!(scores, scores[[e1, e2]] |> sum |> digits |> reverse)
	e1 += scores[e1] + 1
	e2 += scores[e2] + 1
	e1 = e1 > length(scores) ? e1 % length(scores) : e1
	e2 = e2 > length(scores) ? e2 % length(scores) : e2
	return scores, e1, e2
end

function improve(scores::Array{Int,1}, e1::Int, e2::Int, iters::Int)::String
	while length(scores) < iters + 10
		scores, e1, e2 = tick(scores, e1, e2)
	end
	return scores[iters+1:iters+10] |> join
end

function backwards(scores::Array{Int,1}, e1::Int, e2::Int, a1::String)::Int
	iters::Int = 0
	while true
		scores, e1, e2 = tick(scores, e1, e2)
		if length(scores) < length(a1)
			continue
		elseif join(scores[iters+1:iters+length(a1)]) == a1
			break
		end
		iters += 1
	end
	return iters
end

# Part 1
@test improve([3, 7], 1, 2, 9) == "5158916779"
@test improve([3, 7], 1, 2, 5) == "0124515891"
@test improve([3, 7], 1, 2, 18) == "9251071085"
@test improve([3, 7], 1, 2, 2018) == "5941429882"

a1 = improve([3, 7], 1, 2, 920831)
println(a1)

# Part 2
@test backwards([3, 7], 1, 2, improve([3, 7], 1, 2, 9)[1:5]) == 9
@test backwards([3, 7], 1, 2, "01245") == 5
@test backwards([3, 7], 1, 2, "92510") == 18
@test backwards([3, 7], 1, 2, "59414") == 2018

a2 = backwards([3, 7], 1, 2, a1[1:10])
println(a2)
