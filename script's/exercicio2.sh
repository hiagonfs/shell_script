#!/bin/bash
# SISTEMAS - 2016.1
# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178		

# FUNCAO UTILIZADA PARA VALIDAR DADOS
function validaDados {

	if [ $N -le 0 ]; then
		exit 1
	fi
	if [ $S -le 0 ]; then
		exit 1
	fi
	if [ ! $P_USER ]; then
		exit 1
	fi 

}

# CONDICAO UTILIZADA PARA LEITURA DE PARAMETROS/DADOS 
if [ $# -lt 3 ]; then
	read N
	read S
	read P_USER
else
	N=$1
	S=$2
	P_USER=$3
fi

# CHAMADA DA FUNCAO PARA VALIDAR OS DADOS LIDOS DA ENTRADA
validaDados

COUNT=0

# GERACAO DO ARQUIVO COM TODOS OS PROCESSOS LISTADOS %CPU E %MEM
while [ $COUNT -lt $N ]; do	
	sleep $S;
	ps -aux > file_process
	COUNT=$(($COUNT+1))
	
done

# VALOR DE %CPU TOTAL ENCONTRADO

ARQUIVO_CPU= cat file_process | awk -F ' ' '{ print: $3 }' | grep -v "%CPU"

COUNT_CPU=0
for linha in $ARQUIVO_CPU; do
	COUNT_CPU=$(echo "$COUNT_CPU + $linha" | bc -l)
done

echo "O valor de %CPU total encontrado: " $COUNT_CPU 

# VALOR DE %MEM TOTAL ENCONTRADO

ARQUIVO_MEM= cat file_process | awk -F ' ' '{ print: $4 }' | grep -v "%MEM"

COUNT_MEM=0
for linha in $ARQUIVO_MEM; do
	COUNT_MEM=$(echo "$COUNT_MEM + $linha" | bc -l)
done 

echo "O valor de %MEM total encontrado: " $COUNT_MEM

# MAIOR VALOR DE %CPU ENCONTRADO

MAIOR_VALOR_CPU=0
for linha in $ARQUIVO_CPU; do
	if [ $linha -ge $MAIOR_VALOR_CPU ]; then	
		$MAIOR_VALOR_CPU=$(($linha))
	fi
done

echo "Maior valor de %CPU encontrado" $MAIOR_VALOR_CPU

# MENOR VALOR DE %CPU ENCONTRADO

MENOR_VALOR_CPU=$MAIOR_VALOR_CPU
for linha in $ARQUIVO_CPU; do
	if [ $linha -lt $MENOR_VALOR_CPU ]; then	
		$MENOR_VALOR_CPU=$(($linha))
	fi
done

echo "Menor valor de %CPU encontrado" $MAIOR_VALOR_CPU
		 
# MAIOR VALOR DE %MEM ENCONTRADO

MAIOR_VALOR_MEM=0
for linha in $ARQUIVO_CPU; do
	if [ $linha -ge $MAIOR_VALOR_MEM ]; then	
		$MAIOR_VALOR_MEM=$(($linha))
	fi
done

echo "Maior valor de %MEM encontrado: " $MAIOR_VALOR_MEM

# MENOR VALOR DE %MEM ENCONTRADO

MENOR_VALOR_MEM=$MAIOR_VALOR_MEM
for linha in $ARQUIVO_CPU; do
	if [ $linha -lt $MENOR_VALOR_MEM ]; then	
		$MENOR_VALOR_MEM=$(($linha))
	fi
done

echo "Menor valor de %MEM encontrado: " $MENOR_VALOR_MEM
