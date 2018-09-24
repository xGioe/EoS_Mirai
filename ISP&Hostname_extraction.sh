#!/bin/bash

FILE=$1

exec 3<&0
exec 0<$FILE
count=1
while read line
do
	ip=$(echo $line | cut -d',' -f2)
	isp=$(curl -s https://www.whoismyisp.org/ip/$ip | grep -oP '\bisp">\K[^<]+')
	san_isp=$(echo "$isp" | tr , _)
	hostname=$(dig -x "$ip" +short)
	echo "$line,$san_isp,$hostname" >> isp.csv
	
	
	#Feedback for the progress
	echo $count
	count=$(( $count + 1 ))
done
exec 0<&3
