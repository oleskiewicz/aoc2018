#!/bin/sh
<"$1" \
sed "s/Step //g" |
sed "s/ must be finished before step /,/g" |
sed "s/ can begin.//g"
