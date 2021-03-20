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
	echo -e >>$FILE "$line\n\n"
done <tmp
#echo -e >>$FILE "\n"
rm tmp
exit 0
