#!/bin/bash
filename='list1.txt'
n=0
arrUrl=()

while read line; do
# reading each line

firstCharacter=${line:0:1}

if ! [[ "$firstCharacter" == "#" ]]; then
    	arrUrl+=($line)
        #echo $line  #prints every line that doesn't start with hash
        n=$((n+1))
fi

done < $filename

echo ${arrUrl[1]}


