#!/bin/bash

# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178
# ADMINISTRACAO DE SISTEMAS - 2016.1	

# RECEBENDO APENAS UM PARAMETRO
if [ ! -z $1 ] && [ ! $2 ]; then
	while read LINHA; do
		wget $LINHA 2> teste.txt
		STATUS=$(grep "A requisição HTTP foi enviada, aguardando resposta..." teste.txt | tail -n 1 | cut -d "." -f4 | cut -d " " -f2)  
		echo $LINHA $STATUS
	done < $1
	rm teste.txt | rm $(ls | grep "index")
# RECEBENDO DOIS PARAMETROS, SENDO O SEGUNDO UM ARQUIVO DE TEXTO .TXT CONTENDO PALAVRAS	
elif [ $1 ] && [ $2 ]; then
	while read LINHA; do
		wget $LINHA 2> teste.txt
		STATUS=$(grep "A requisição HTTP foi enviada, aguardando resposta..." teste.txt | tail -n 1 | cut -d "." -f4 | cut -d " " -f2) 
		if [ $STATUS -eq 200 ]; then
			COUNT=0
			for palavra in $(cat $2); do
				ARQUIVO=$(ls | grep "index")
				if [ "$(grep $palavra $ARQUIVO)" ]; then
					COUNT=$(($COUNT+1))
				fi
			done
		fi
		QTD_LINHAS=$(wc -l $2 | cut -d " " -f1) 
		if [ $COUNT  -eq $QTD_LINHAS ]; then
			echo $LINHA $STATUS "OK!" 
		else
			echo $LINHA $STATUS
			# FUNCIONALIDADE EXTRA
			echo "Quantidade de palavras que não foram encontradas no site:" $(($QTD_LINHAS - $COUNT))
		fi
	done < $1
	rm teste.txt | rm $(ls | grep "index")	
# CASO OS PARAMETROS ESTEJAM VAZIOS, MOSTRA UMA MENSAGEM DE ERRO COM SAIDA 1
else
	echo "Erro!"
	exit 1
fi		
