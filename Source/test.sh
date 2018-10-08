#!/bin/bash

FILE=$1

exec 3<&0
exec 0<$FILE
while read line
do
	echo $line > tmp.txt
	python3 pygeoipmap.py -i tmp.txt --service m --db GeoLiteCity.dat >> ciaobello.txt
done
exec 0<&3
