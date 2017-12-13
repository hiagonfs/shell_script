#!/bin/bash

# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178
# ADMINISTRACAO DE SISTEMAS - 2016.1	

removeTemporaryFiles() 
{
	rm tempFile.txt
}

if [ $1 ]; then 

	INICIO=$(uptime | cut -d " " -f1) 
	
	curl -I $1 > tempFile.txt
	
	FIM=$(uptime | cut -d " " -f1)
	
	HORA_INICIO=$(echo $INICIO | cut -d ":" -f1)
	HORA_FIM=$(echo $FIM | cut -d ":" -f1)
	MINUTOS_INICIO=$(echo $INICIO | cut -d ":" -f2)
	MINUTOS_FIM=$(echo $FIM | cut -d ":" -f2)
	SEGS_INICIO=$(echo $INICIO | cut -d ":" -f3)
	SEGS_FIM=$(echo $FIM | cut -d ":" -f3)	
	
	HORA_DIF=$((HORA_FIM-HORA_INICIO))
	MINS_DIF=$((MINUTOS_FIM-MINUTOS_INICIO))
	SEG_DIFS=$((SEGS_FIM-SEGS_INICIO))
	
	OPERACAO_HORA=$(($HORA_DIF * 60*60*1000))
	OPERACAO_MINS=$(($MINS_DIF * 60*1000))
	OPERACAO_SEGS=$(($SEG_DIFS * 1000))
	
	echo $(($OPERACAO_HORA + $OPERACAO_MINS + $OPERACAO_SEGS))
	 
	HORA_SERVIDOR=$( cat tempFile.txt | grep "Date:" | cut -d " " -f6)
	HORA_MAQUINA=$(date +%H:%M:%S)
	
	echo $HORA_SERVIDOR
	echo $HORA_MAQUINA
	
	HORA_SERVIDOR_SEGUNDOS=$(date -d $HORA_SERVIDOR +%s)
	HORA_MAQUINA_SEGUNDOS=$(date -d $HORA_MAQUINA +%s)
	
	DIF_HORA_MAQUINA_SERVIDOR=$(($HORA_MAQUINA_SEGUNDOS-$HORA_SERVIDOR_SEGUNDOS))
	
	echo $DIF_HORA_MAQUINA_SERVIDOR

#FUNCIONALIDADE EXTRA: RETORNA O STATUS DO DOMINIO

STATUS=$( cat tempFile.txt | grep "HTTP" | cut -d " " -f2)

echo "STATUS DO DOMINIO:" $STATUS
	
	removeTemporaryFiles
	
else
	echo "ERRO!"
	exit 1
fi	
