#!/bin/bash

States=('NSW' 'VIC' 'QLD' 'NT' 'WA' 'SA' 'TAS')

for state in ${States[@]}
do
 echo "The State is $state"
	if [ $state == 'NSW' ];
	then
	echo "$state is the Best!"
	else 
	echo "I am not fond of $state"
	fi
done
