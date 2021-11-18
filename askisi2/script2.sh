#!/bin/bash

file_name=$1


correct_structure1=" |-more
 | |-dataB.txt
 | |-dataC.txt
 |-dataA.txt"

correct_structure2=" |-dataA.txt
 |-more
 | |-dataB.txt
 | |-dataC.txt"



repositories_array=()
while IFS=  read -r -d $'\0'; do
    #array+=("$REPLY")
    	
    	flag=0
    	while read line && [[ $flag == 0 ]]; do 
   		
   		#echo $line; 
   		
   		check_string=${line:0:4}
		if [ "$check_string" == "http" ]; then 
	
			repositories_array+=("$line")
   			flag=1
		fi
   		
   		
   	done < $REPLY
   	
   	
done < <(find . -name '*.txt' -print0)

folders=()


FILE="assignments"
if ! [ -d "$FILE" ]; then
	mkdir assignments
	cd assignments
else
	exit 1
fi


for i in "${repositories_array[@]}"
do
   	
   	git clone --quiet $i &> /dev/null
   	
	if [ $? -eq 0 ]; then
    		#git clone executed successfully
    		echo "$i"": Cloning OK"
    		value=${i##*/}
		str=${value::-4}
    		
    		#successful repository directories names are saved in folders array
    		folders+=("$str")
	else
		#git clone failed
    		>&2 echo "$i"": Cloning FAILED"
	fi
done


for i in "${folders[@]}"
do


   	cd $i
   	
   	
   	dir_and_files=$(find . \! \( -name . -or -name ".git" -or -path "*/.git/*" \) | wc -l)
   	
   	num_of_directories=$(ls -l | grep "^d" | wc -l)
   	
   	num_of_txt_files=$(find . -name '*.txt' | wc -l)
	
	num_of_other_files=$((dir_and_files-num_of_txt_files-num_of_directories))
   	echo "$i"":"
   	echo "Number of directories: "$num_of_directories
   	echo "Number of txt files: "$num_of_txt_files
   	echo "Number of other files: "$num_of_other_files
   	
   	structure=$(find . \! \( -name . -or -name ".git" -or -path "*/.git/*" \) | sed -e "s/[^-][^\/]*\// |/g" -e "s/|\([^ ]\)/|-\1/")
   	
   	if [ "$structure" == "$correct_structure1" ] || [ "$structure" == "$correct_structure2" ]; then
   		echo "Directory structure is OK."
   	else
   		>&2 echo "Directory structure is NOT OK."
   	
   	fi
   	
   	
   	
   	cd ..
done
