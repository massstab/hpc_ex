#!/bin/bash
FILE=$1

if [ -z "$FILE" ] ; then
	echo "Give filename as 1st parameter!"
    exit 1
elif ! [ -f "$FILE" ] ; then
    	echo "$FILE does not exists"
    	exit 1
fi


while read line ; do
        echo "$line"
        echo
done <$FILE
exit 0
