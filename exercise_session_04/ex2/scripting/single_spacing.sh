#!/bin/bash
FILE=$1

if [ -z "$FILE" ] ; then
	echo "Give filename as 1st parameter!"
    exit 1
elif ! [ -f "$FILE" ] ; then
    	echo "$FILE does not exists"
    	exit 1
fi

rm -f tmp
cp $FILE tmp
echo -n "" >$FILE
while read line ; do
	if [ -z "$line" ] ; then
		continue
	else		
		echo >>$FILE "$line"
	fi
done <tmp
rm tmp
exit 0
