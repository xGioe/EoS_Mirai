#!/bin/bash

FILE=$1

exec 3<&0
exec 0<$FILE
count=1
limit=1
while read line
do
	#skip first 94695
	if [ $limit -lt 94695 ]
	then 
		#Feedback for the progress
		echo $count
		count=$(( $count + 1 ))
		limit=$(( $limit + 1 ))
		continue
	fi
	
	ip=$(echo $line | cut -d',' -f2)
	echo $ip
	aut_name=$(curl -X POST -F "ipAddress="$ip https://www.ultratools.com/tools/ipWhoisLookupResult | grep aut-num)
	aut_name_sanitized=$(echo $aut_name | sed 's/[^0-9]*//g')
	#san_aut_name=$(echo "$aut_name_sanitized" | tr , _)
	echo "$ip,$aut_name_sanitized" >> aut_nam.csv
	
	
	#Feedback for the progress
	echo $count
	count=$(( $count + 1 ))
done
exec 0<&3
