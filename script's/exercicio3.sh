#!/bin/bash

#ALUNO: HIAGO FERNANDES DE SOUSA - MAT.: 114210178
#SISTEMAS - 2016.1

# REPASSANDO DOIS PARAMETROS (EXERCICIO E ALUNO)
if [ $# -eq 2 ]; then
	EXERCICIO=$(ls -a | grep $1 | grep $2)
	NUMERO_DO_EXERCICIO=$(echo $1 | cut -d "_" -f2)
	
	EXTENSAO_IN=$(ls -a | grep $1 | grep .in)
	
	for arquivo in $EXTENSAO; do
		./$EXERCICIO < $arquivo
		SELECAO=$(echo $arquivo | cut -d "." -f1)
		EXTENSAO_OUT=$(ls -a | grep $SELECAO | grep .out)
		./$EXERCICIO < $arquivo > test.txt
		$EXTENSAO_OUT > test_ext.txt
		
		diff test.txt test_ext.txt
		
	done
	
fi
# APENAS O EXERCICIO FOI REPASSADO

if [ $# -eq 1 ]; then
