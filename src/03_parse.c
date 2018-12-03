#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
	int i, x, y, w, h;
	FILE *f = fopen(argv[1], "r");

	while(fscanf(f, "#%d @ %d,%d: %dx%d\n", &i, &x, &y, &w, &h) != EOF) {
		printf("%d,%d,%d,%d,%d\n", i, x, y, w, h);
	}

	fclose(f);
}
