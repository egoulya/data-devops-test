#!/bin/bash

exec 2>/dev/null

for line in $(cat task2.3input)
do
  nf=$(find $line -type f -maxdepth 1 | wc -l)
  nd=$(find $line -type d -maxdepth 1 | wc -l)
  echo "$line - Files: $nf, Directories: $(($nd-1))" #Don't count upper directory
done
