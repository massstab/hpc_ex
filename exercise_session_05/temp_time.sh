#!/bin/bash
RE="Temperature: ([0-9]*\.[0-9]*) deg at time: ([0-9]*\.[0-9]*) sec"

count=0
temp=0
while read A ; do
	if [[ "$A" =~ $RE ]] ; then
		echo "${BASH_REMATCH[1]} ${BASH_REMATCH[1]}" >> out.txt
		let count=count+1
		temp=$(echo "$temp + ${BASH_REMATCH[1]}" | bc)
	fi
done

average=$(bc <<< "scale=1;$temp/$count")
echo "The average measured temperature is $average deg."