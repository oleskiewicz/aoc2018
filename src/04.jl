#!/usr/bin/env dk 202a3fcc9519 julia
using Dates

function parselines(lines)
    naps = Dict()
    totals = Dict()

    for l in lines
        time, event = split(l, "] ")
        time = String(time[2:end])
        time = DateTime(time, "y-m-d H:M")

        if startswith(event, "Guard")
            global guard = parse(Int, split(event, " ")[2][2:end])
        elseif event == "falls asleep"
            global start = time
        elseif event == "wakes up"
            global finish = time
            delta_t = get!(totals, guard, -1)
            if delta_t == -1
                push!(naps, guard => [start, finish])
                push!(totals, guard => finish - start)
            else
                push!(naps, guard => push!(naps[guard], start))
                push!(naps, guard => push!(naps[guard], finish))
                push!(totals, guard => delta_t + (finish - start))
            end
        end
    end
    for (k,v) in naps
        naps[k] = Dates.value.(Minute.(naps[k]))
        totals[k] = Dates.value.(Minute.(totals[k]))
    end
    return naps, totals
end

function mins(nap)
    mins = zeros(Int, 60)
    for (a,b) in zip(nap[1:2:end], nap[2:2:end])
        mins[a:b] .+= 1
    end
    return mins
end

function fav_min(nap)
    return findmax(mins(nap))[2]
end

lines = readlines("./dat/04.txt") |> sort
naps, totals = parselines(lines)

function a1()
    sleepiest_guard = reduce((x, y) -> totals[x] > totals[y] ? x : y, keys(totals))
    sleepiest_minute = fav_min(naps[sleepiest_guard])
    return sleepiest_guard * sleepiest_minute
end

# TODO: not working. defeated by 1-indexing! (minutes count from 0)
function a2()
    max_minute = 0
    max_minute_guard = 0
    for (guard, nap) in naps
        _, t = findmax(mins(nap))
        if t > max_minute
            max_minute = t
            max_minute_guard = guard
        end
    end
    return max_minute * max_minute_guard
end

