#!/bin/bash

ARQUIVO=$(grep --binary-files=text ' - -' ./calgary_access_log | cut -d ' ' -f1)

# CONTAGEM LOCAL E REMOTE
cont_local=$(grep --binary-files=text ' - -' ./calgary_access_log | grep -c "local")
cont_remote=$(grep --binary-files=text ' - -' ./calgary_access_log | grep -c "remote")


echo "$cont_local; $cont_remote"

# HORAS LOCAIS

grep --binary-files=text 'local - -' ./calgary_access_log | cut -d ':' -f2 > log_hiago
cont_localHour=0


while read line; do
	cont_localHour=$(( $cont_localHour + 10#$line ))
done < "log_hiago"

mediaLocal=$(( $cont_localHour / $cont_local ))

echo $mediaLocal

grep --binary-files=text 'remote - -' ./calgary_access_log | cut -d ':' -f2 > log_hiago

cont_remoteHour=0

while read line; do
	cont_remoteHour=$(( $cont_remoteHour + 10#$line ))
done < "log_hiago"

mediaRemote=$(( $cont_remoteHour / $cont_remote ))

echo $mediaRemote

