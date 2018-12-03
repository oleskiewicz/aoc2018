#!/bin/sh
<"$1" tr '@:x' ',' | tr -d '# '
