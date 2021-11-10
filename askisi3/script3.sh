#!/bin/bash

textbook_name=$1
num=$2
field_box=()
all_words=()
count_times=()
counta=0

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
		field_box+=("$result1")
		#echo $result1
		#if [[ " ${field_box[*]} " =~ " ${result1} " ]]; then
    			#all_words+=("$result1")
    			#when array contains value
    			
		#fi

		#if [[ ! " ${field_box[*]} " =~ " ${result1} " ]]; then
    			#field_box+=("$result1")
    			#when array doesn't contain value
		#fi
	fi
done;

done <"$textbook_name"

#echo Items: ${#field_box[@]}
#echo Data: ${field_box[@]}

> "appendmode.txt"
for i in "${field_box[@]}"
do
: 

echo -n $i" " >> "appendmode.txt"
done

sed -e 's/\s/\n/g' < "appendmode.txt" | sort | uniq -c | sort -nr | head  -$num | awk '{print $2,$1}'
rm "appendmode.txt"



