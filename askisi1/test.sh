#!/bin/bash
filename='list1.txt'
n=1
arrUrl=()

while read line; do
# reading each line

firstCharacter=${line:0:1}
if ! [[ "$firstCharacter" == "#" ]]; then
    	arrUrl+=($line)
        echo $line
fi
    
# echo ${arrUrl[n-1]}
n=$((n+1))

done < $filename


