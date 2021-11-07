#!/bin/bash

#Read the main string
echo "Enter the string with colon(:) to split"
read mainstr

#Split the string based on the delimiter, ':'
readarray -d : -t strarr <<< "$mainstr"
printf "\n"

# Print each value of the array by using loop
for (( n=0; n < ${#strarr[*]}; n++))
do
  echo "${strarr[n]}"
done
