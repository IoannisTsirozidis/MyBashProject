#!/bin/bash

textbook_name=$1
num=$2

while read line; do
#line="I'm sure _I_ sha'n't be able!"
IFS=' |-' 
read -ra stringarray <<< "$line"

for i in "${stringarray[@]}"; do
	
	result1=
	for (( j=0; j<${#i}; j++ )); do
  		currChar=${i:$j:1}
  		
  		if [[ "$currChar" == "'" ]]; then
  			i=${i%\'*}
  		fi
  		
  		if [[ "$currChar" =~ [a-zA-Z] ]];then
  			if [[ "$currChar" =~ [A-Z] ]]; then
  				currChar=${currChar,,}
			fi
  			
  			result1=$result1$currChar
		fi
  		
  		
	done;
	
	if ! [ -z "$result1" ]; then
		echo $result1
	fi
done;

done <"$textbook_name"
