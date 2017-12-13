#!/bin/bash

# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178
# ADMINISTRACAO DE SISTEMAS - 2016.1

if [ $# -eq 2 ]; then
		
		DIRETORIO_ORIGEM=$1
		DIRETORIO_DESTINO=$2
		
		NUMERO_BACKUPS=$(ls $DIRETORIO_DESTINO | grep -c $DIRETORIO_ORIGEM)
		
		if [ $NUMERO_BACKUPS -eq 0 ]; then
			
			cp -r $DIRETORIO_ORIGEM $DIRETORIO_DESTINO/$DIRETORIO_ORIGEM
			
			echo "Data do backup:" $(date)
			
		else 
		
			cp -r $DIRETORIO_ORIGEM $DIRETORIO_DESTINO/$DIRETORIO_ORIGEM.$NUMERO_BACKUPS
			
			echo "Data do backup:" $(date)
			
		fi
		
		
elif [ $# -eq 3 ] && [ $1 = "-z" ]; then

	DIRETORIO_ORIGEM=$2
	DIRETORIO_DESTINO=$3
		
	if [ -e $DIRETORIO_DESTINO/$DIRETORIO_ORIGEM.zip ]; then
		
		echo "ERRO: ARQUIVO EXISTENTE!"
		exit 2
		
	else
		
		zip -r $DIRETORIO_DESTINO/$DIRETORIO_ORIGEM.zip $DIRETORIO_ORIGEM
		
		echo "Data do backup:" $(date)
	
	fi

else

	echo "ERROR"
	exit 1

fi
	
