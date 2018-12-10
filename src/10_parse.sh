#!/bin/sh

<"$1" tr -d '=<> ' |
sed 's/velocity/,/g' |
tr -d '[:lower:]=<> '
