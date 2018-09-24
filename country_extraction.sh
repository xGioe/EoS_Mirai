#!/bin/bash

FILE=$1

exec 3<&0
exec 0<$FILE
count=1
while read line
do
	ip=$(echo $line | cut -d',' -f2)
	country=$(geoiplookup $ip)
	countryfinal=$(echo $country | cut -d',' -f2)
	echo "$line,$countryfinal" >> country.csv
	
	#Feedback for the progress
	echo $count
	count=$(( $count + 1 ))
	
done
exec 0<&3
