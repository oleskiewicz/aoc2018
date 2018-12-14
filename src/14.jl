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

# Part 1
@test improve([3, 7], 1, 2, 9) == "5158916779"
@test improve([3, 7], 1, 2, 5) == "0124515891"
@test improve([3, 7], 1, 2, 18) == "9251071085"
@test improve([3, 7], 1, 2, 2018) == "5941429882"

println(improve([3, 7], 1, 2, 920831))
