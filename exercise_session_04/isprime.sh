#!/bin/bash

if ! [ -z "$1" ] ; then
	n=$1
else
	echo "Enter number to test for prime: "
	read n	
fi

if ((n <= 3)) ; then
	if ((n > 1	)); then
		echo "$n is prime."
		exit 0
	else
		echo "$n is not prime."
		exit 0
	fi
fi

if ((n % 2 == 0)) || ((n % 3 == 0)) ; then
	echo "$n is not prime."
	exit 0
fi

i=5
while ((i**2 <= n)); do
	if ((n % i == 0)) || ((n % (i + 2) == 0)) ; then
		echo "$n is not prime"
		exit 0
	fi
	i+=6
done

array[0]="Wuaaat? $n is prime! How did you know that??"
array[1]="Yes, it's prime."
array[2]="Crazy dude! You are the prime minister!"
array[3]="Prima! Ja, isch e Primzahl."
array[4]="You got it!!! $n is prime!"
array[5]="Alte! Geile siech. $n isch e Primzahl."
array[6]="Why do you know? $n is prime."
array[7]="Prima! Ja isch e Primzahl. E sogenannti Primazahl. Haha."
array[8]="$n prime $n prime $n prime !!"
array[9]="Go tell it on the Mountain that $n iiiis prime!"
array[10]="$n is prime"
array[11]="$n is a beautiful prime."

size=${#array[@]}
index=$(($RANDOM % $size))
echo ${array[$index]}