#!/bin/bash

# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178
# ADMINISTRACAO DE SISTEMAS - 2016.1	

# EXTRA: MODULARIZACAO PARA APLICAR REUSO NO CODIGO
coutingAndProcessingIps()
{
	getent hosts $1 > tempfile.txt
	getent hosts "m."$1 > tempfile_mobile.txt
	NUMBER_OF_LINES=$( wc -l < tempfile.txt)
	NUMBER_OF_LINES_MOBILE=$( wc -l < tempfile_mobile.txt)
}

removeTemporaryFiles() 
{
	rm tempfile.txt | rm tempfile_mobile.txt
}
	
# GETTING GIVEN FILE 

if [ $1 = "-f" ] && [ $2 ]; then
	
	while read LINE; do
		
		coutingAndProcessingIps $LINE
		
		if [ $NUMBER_OF_LINES_MOBILE -ge 1 ]; then
			
			echo $LINE $NUMBER_OF_LINES "MOBILE"
	
		elif [ $NUMBER_OF_LINES -eq 0 ]; then
				
			echo $LINE "ERRO"
		
		else
			
			echo $LINE $NUMBER_OF_LINES
		
		fi
	
	removeTemporaryFiles
	
	done < $2	

# WORKING ONLY WITH DOMAIN

elif [ $1 ] && [ ! $2 ]; then

	coutingAndProcessingIps $1
	
	if [ $NUMBER_OF_LINES_MOBILE -ge 1 ]; then
		
		echo $1 $NUMBER_OF_LINES "MOBILE"
		
	elif [ $NUMBER_OF_LINES -ne 0 ]; then
				
			echo $LINE "ERRO"
		
	else 
		
		echo $1 $NUMBER_OF_LINES
		
	fi
		
	removeTemporaryFiles
	
# IF NONE OF THE CONDITIONS IS MET, ERROR OUTPUT.
else
	echo "ERROR!"
	exit 1
fi 
