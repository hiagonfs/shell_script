#!/bin/bash

# HIAGO NATAN FERNANDES DE SOUSA - MAT.: 114210178
# ADMINISTRAÇÃO DE SISTEMAS - 2016.1

# RESPOSTA TEÓRICA:

# O que representa X, Y, Z na linha abaixo:
# PING X (Y) Z(W) bytes of data.
# RESPOSTA: 
# X = destinatario dos pacotes, Y = IP que esta sendo "pingado", Z = tamanho do pacote que esta sendo enviado

# O que representa A, B, C na linha abaixo:
# A bytes from B (C): icmp_seq=D ttl=E time=F ms
# RESPOSTA:
# A = numero de bytes recebidos, B = dominio que esta sendo "pingado", C = IP do dominio que esta sendo "pingado"

# (Bônus) Por que, para X sendo google.com, X e B são diferentes?
# RESPOSTA:
# Porque X é o hostname que está recebendo os pacotes atraves do ping e B o servidor do hostname que esta recebendo os pacotes.

# SCRIPT QUE MANIPULA O USO DO PING

# UTILIZANDO COMPORTAMENTO PADRAO DO PING (56 BYTES)
ping -c 10 facebook.com | grep "from" > analysisPingDefault.txt

# GERANDO UM NOVO ARQUIVO COM OS TEMPOS OBSERVADOS PARA O ENVIO DE PACOTES PADRAO DO PING

while read LINHA; do
	TEMPO=$(echo $LINHA | cut -d " " -f8 | cut -d "=" -f2)
	echo $TEMPO >> tempoAnalysisDefault.txt
done < analysisPingDefault.txt

QTD_LINHAS_DEFAULT=$(wc -l < tempoAnalysisDefault.txt)

# CRIANDO UM NOVO ARQUIVO COM OS TEMPOS ORDENADOS EM ORDEM CRESCENTE
sort -n tempoAnalysisDefault.txt > tempoAnalysisDefaultOrd.txt

#IMPRESSAO DO RESULTADO APOS TODO PROCESSAMENTO
echo "A mediana de tempo dos pacotes enviados para o comportamento default do ping eh: "
cat tempoAnalysisDefaultOrd.txt | sed -n "$(($QTD_LINHAS_DEFAULT/2))p"  

# A MEDIA DOS 3 MAIORES TEMPOS PARA COMPORTAMENTO DEFAULT

echo "A media de tempo para os 3 maiores tempos do comportamento default eh:" 

SOMATORIO_DEFAULT=0
for number in $(tail -n 3 tempoAnalysisDefaultOrd.txt); do
	SOMATORIO_DEFAULT=$(($SOMATORIO_DEFAULT+$number))
done

echo $(($SOMATORIO_DEFAULT/3))

# EXTRA:
# A MEDIA DOS 3 MENORES TEMPOS PARA COMPORTAMENTO DEFAULT

echo "A media de tempo para os 3 menores tempos do comportamento default eh:" 

SOMATORIO_DEFAULT_MENORES=0
for number in $(head -n 3 tempoAnalysisDefaultOrd.txt); do
	SOMATORIO_DEFAULT_MENORES=$(($SOMATORIO_DEFAULT_MENORES+$number))
done

echo $(($SOMATORIO_DEFAULT_MENORES/3))

echo "-------------------------------------------------------------------------"

# PAUSA DE 10 SEGUNDOS 
sleep 10; 

# ENVIADO PACOTES DE 64 BYTES NUMA SEGUNDA EXECUCAO 
ping -c 10 -s 64 facebook.com | grep "from" > analysisPing64.txt

# GERANDO UM NOVO ARQUIVO COM OS TEMPOS OBSERVADOS PARA O ENVIO DE PACOTES COM 64 BYTES

while read LINHA; do
	TEMPO=$(echo $LINHA | cut -d " " -f8 | cut -d "=" -f2)
	echo $TEMPO >> tempoAnalysis64.txt
done < analysisPingDefault.txt

QTD_LINHAS_64=$(wc -l < tempoAnalysis64.txt)

# CRIANDO UM NOVO ARQUIVO COM OS TEMPOS ORDENADOS EM ORDEM CRESCENTE
sort -n tempoAnalysis64.txt > tempoAnalysis64Ord.txt

#IMPRESSAO DO RESULTADO APOS TODO PROCESSAMENTO
echo "A mediana de tempo dos pacotes enviados para o comportamento enviando pacotes de 64 bytes do ping eh: "
cat tempoAnalysis64Ord.txt | sed -n "$(($QTD_LINHAS_64/2))p"  

# A MEDIA DOS 3 MAIORES TEMPOS PARA COMPORTAMENTO COM PACOTES DE 64 BYTES

echo "A media de tempo para os 3 maiores tempos do comportamento com 64 bytes eh:" 

SOMATORIO_64=0
for number in $(tail -n 3 tempoAnalysis64Ord.txt); do
	SOMATORIO_64=$(($SOMATORIO_64+$number))
done

echo $(($SOMATORIO_64/3))

# EXTRA:
# A MEDIA DOS 3 MENORES TEMPOS PARA COMPORTAMENTO COM PACOTES DE 64 BYTES

echo "A media de tempo para os 3 menores tempos do comportamento com 64 bytes eh:" 

SOMATORIO_64_MENORES=0
for number in $(head -n 3 tempoAnalysis64Ord.txt); do
	SOMATORIO_64_MENORES=$(($SOMATORIO_64_MENORES+$number))
done

echo $(($SOMATORIO_64_MENORES/3))

# REMOCAO DOS ARQUIVOS DA MEMORIA DEPOIS DE TODO PROCESSAMENTO

rm analysisPingDefault.txt | rm analysisPing64.txt |  rm tempoAnalysisDefault.txt | rm tempoAnalysisDefaultOrd.txt | rm tempoAnalysis64.txt | rm tempoAnalysis64Ord.txt
