#!/bin/bash

# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178
# ADMINISTRACAO DE SISTEMAS - 2016.1	

while read LINHA; do
	
	CHEKSUM=$(echo $LINHA | cut -d " " -f1)
	ALGORITMO=$(echo $LINHA | cut -d " " -f2)
	ARQUIVO=$(echo $LINHA | cut -d " " -f3-)
	
	if test -f "$ARQUIVO"; then
		
		case $ALGORITMO in
		
			"CRC") 
				VALOR=$(cksum "$ARQUIVO" | cut -d " " -f1)
				if [ "$VALOR" = "$CHEKSUM" ]; then
					echo "OK" $ARQUIVO
				else
					echo "ERROR" $ARQUIVO
				fi
				echo "Valor de checagem gerado:" $VALOR
				echo "Valor de checagem recebido:" $CHEKSUM
				;;
			"MD5")
				VALOR=$(md5sum "$ARQUIVO" | cut -d " " -f1)
				if [ "$VALOR" = "$CHEKSUM" ]; then
					echo "OK" $ARQUIVO
				else
					echo "ERROR" $ARQUIVO
				fi
				echo "Valor de checagem gerado:" $VALOR
				echo "Valor de checagem recebido:" $CHEKSUM
				;;
			"SHA1")
				VALOR=$(sha1sum "$ARQUIVO" | cut -d " " -f1)
				if [ "$VALOR" = "$CHEKSUM" ]; then
					echo "OK" $ARQUIVO
				else
					echo "ERROR" $ARQUIVO
				fi
				echo "Valor de checagem gerado:" $VALOR
				echo "Valor de checagem recebido:" $CHEKSUM
				;;
				
		esac
		
	else
	
		echo "NOT_FOUND" $ARQUIVO
	
	fi
done < $1 
