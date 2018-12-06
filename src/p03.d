#!/usr/bin/env dk af4393e1aa8f rdmd
import
	std.stdio,
	std.file,
	std.algorithm,
	std.range,
	std.array;

void main() {
	auto rs = slurp!(int, int, int, int, int)("./dat/03.txt", "#%d @ %d,%d: %dx%d");
	auto xdim = rs
		.map!(x => x[1] + x[3])
		.maxElement;
	auto ydim = rs
		.map!(x => x[2] + x[4])
		.maxElement;
	auto grid = new int[][](xdim, ydim);
	int num_overlaps = 0;
	int id = -1;

	foreach(r; rs) {
		foreach(x; r[1] .. r[1] + r[3]) {
			foreach(y; r[2] .. r[2] + r[4]) {
				grid[x][y] += 1;
				if (grid[x][y] > 1)
					num_overlaps += 1;
			}
		}
	}

	writeln(num_overlaps); // 3a

}
