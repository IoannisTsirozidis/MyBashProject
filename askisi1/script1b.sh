#!/bin/bash
	
my_func(){

	foo="$line"
	result1=${foo:0:1}
	for (( i=1; i<${#foo}; i++ )); do
		currChar=${foo:$i:1}
  		if ! [ "$currChar" == "." ] && ! [ "$currChar" == "/" ]; then
  			result1=$result1$currChar
  		fi
	done
	textname=${result1##h*:}".txt"
	
	
	if test -f "$textname"; then
    		#echo $textname" exists"
    		hashcode=$(head -n 1 $textname)
    		> $textname 
    		wget -q $line -O $textname
		
		if [[ $? -ne 0 ]]; then
    			echo $line" FAILED"
		
		else
			hashcode1="`md5sum $textname`"
    			> $textname
    			echo "$hashcode1" > "$textname"
    		
    			if [ "$hashcode" != "$hashcode1" ]; then
    				echo $hashcode
    				echo
    				echo $hashcode1
			fi
    		 	
		fi
		
    		
    		
    	else 
    		
    		wget -q $line -O $textname
    		
    		if [[ $? -ne 0 ]]; then
    			echo $line" FAILED"
		else
			echo $line" INIT"
			hashcode="`md5sum $textname`"
			> $textname
			echo "$hashcode" > "$textname"
    		
		fi
		
		
    		
	fi

}

	
filename='list1.txt'


while read line; do
# reading each line

firstCharacter=${line:0:1}
if ! [[ "$firstCharacter" == "#" ]]; then
        
        my_func "$line" &
	
fi

done < $filename
wait
