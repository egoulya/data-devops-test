#!/bin/bash

exec 2>err.log
parentdir="$(dirname "$(pwd)")"
if [[ $(ls "$parentdir" | grep "task2.txt") != "" ]]
then 
  echo "Error: File already exists" >&2
  echo "Error: File already exists"
else
ve=$(touch "$parentdir"/task2.txt 2>&1 > /dev/null)
if [[ $(echo $ve | grep 'Permission') != "" ]]
then
  echo "Error: Permission denied"
  echo "Error: Permission denied" >&2
fi
fi
