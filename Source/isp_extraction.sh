#!/bin/bash

FILE=$1

exec 3<&0
exec 0<$FILE
count=1
while read line
do
	code=$(echo $line | cut -d'|' -f1)
	ip=$(echo $line | cut -d'|' -f2)
	size=$(echo $line | cut -d'|' -f3)
	num=$(echo $size | cut -d'/' -f2)
	size_as=$(echo "2^(32-$num)" | bc)
	country=$(echo $line | cut -d'|' -f4)
	#date=$(echo $line | cut -d'|' -f6)
	#time=$(echo $line | cut -d'|' -f7)
	name=$(echo $line | cut -d'|' -f7)
	name_isp=$(echo $name | cut -d',' -f1)
	echo "$code,$ip,$num,$size_as,$country,$name_isp" >> mapping_time_3.csv
	
	#Feedback for the progress
	echo $count
	count=$(( $count + 1 ))
	
done
exec 0<&3
