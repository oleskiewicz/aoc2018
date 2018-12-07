#!/usr/bin/env dk 202a3fcc9519 julia
using DelimitedFiles

function find_prerequisites(table::Array{Char,2})::Array{Char}
  setdiff(Set(table[:,1]), Set(table[:,2])) |> collect |> sort
end

function flatten_graph(table)
	if ! isempty(table)
		prerequisites = find_prerequisites(table)
		for c in prerequisites
			println(c)
		end
		flatten_graph(table[findall(c-> !(c in prerequisites), table[:,1]),:])
	else
		return
	end

	# nexts::Array{Char,1} = []
	# for c in prerequisites
	#   append!(nexts, table[table[:,1] .== c, 2])
	#   flatten_graph(
	#     table[table[:,1] .== c, 2],
	#     table[table[:,1] .!= c, :]
	#   )
	# end

end

table = readdlm("./dat/07_test.csv", ',', Char, '\n')
beginning = find_prerequisites(table)
flatten_graph(table)
