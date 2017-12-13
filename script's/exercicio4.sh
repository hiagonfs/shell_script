#!/bin/bash

# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178
# SISTEMAS - 2016.1

# GERA UM ARQUIVO TXT COM AS CHAMADAS DO SISTEMAS
strace -T $* 2> analysis.txt

cat analysis.txt | head -n -2 > analysis.txt

# LEITURA DE LINHAS DO ARQUIVO E SEPARACAO DO TEMPO SYSCALL
CONT=0
while read LINHA; do
	CONT=$(($CONT+1))
	TEMPO=$(echo $LINHA | grep "=" | cut -d "<" -f2 | cut -d ">" -f1)
	echo "Tempo: $TEMPO na linha $CONT" >> tempoSyscalls.txt
done < analysis.txt	

# ORDENANDO TEMPO DE CHAMADA
sort -rk2 tempoSyscalls.txt > syscallOrd.txt

# CAPTURANDO AS 3 LINHAS COM MAIOR TEMPO DE CHAMADA REPASSANDO O ARQUIVO ORDENADO
LINHA_1=$(cat syscallOrd.txt | sed -n '1p' | cut -d " " -f5)
LINHA_2=$(cat syscallOrd.txt | sed -n '2p' | cut -d " " -f5)
LINHA_3=$(cat syscallOrd.txt | sed -n '3p' | cut -d " " -f5)

# IMPRESSAO DO RESULTADO APOS TODO PROCESSAMENTO (MAIOR TEMPO)	
echo "Chamadas com maior tempo:"
cat analysis.txt | sed -n "$LINHA_1"p
cat analysis.txt | sed -n "$LINHA_2"p 
cat analysis.txt | sed -n "$LINHA_3"p

# FUNCIONALIDADE EXTRA: OS 3 MENORES TEMPOS DE CHAMADA

# ORDENACAO DO ARQUIVO DE FORMA INVERSA AO QUE FOI PEDIDO

sort -k2 tempoSyscalls.txt > syscallOrd1.txt

# CAPTURANDO AS 3 LINHAS COM MENOR TEMPO DE CHAMADA REPASSANDO O ARQUIVO ORDENADO
LINHA_1=$(cat syscallOrd1.txt | sed -n '1p' | cut -d " " -f5)
LINHA_2=$(cat syscallOrd1.txt | sed -n '2p' | cut -d " " -f5)
LINHA_3=$(cat syscallOrd1.txt | sed -n '3p' | cut -d " " -f5)

# IMPRESSAO DO RESULTADO APOS TODO PROCESSAMENTO (MENOR TEMPO)	
echo "Chamadas com menor tempo:"
cat analysis.txt | sed -n "$LINHA_1"p
cat analysis.txt | sed -n "$LINHA_2"p 
cat analysis.txt | sed -n "$LINHA_3"p

# REMOCAO DOS ARQUIVOS APOS PROCESSAMENTO

rm analysis.txt | rm tempoSyscalls.txt | rm syscallOrd.txt | rm syscallOrd1.txt
