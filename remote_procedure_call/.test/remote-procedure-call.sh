#!/bin/bash

source $(dirname "$0")/../../.test/test.sh

BINARY=start
OUTPUT=/tmp/output.txt
TIMEOUT=60
SKIPPED=0


init_feedback "Esercizio remote procedure call"

compile_and_run $BINARY $OUTPUT $TIMEOUT


perl -n -e '
if(/\[Produttore\]\sChiamo\sPRODUCI\sCON\sSOMMA\((\d+),\s(\d+),\s(\d+)\)/) { push @produzioni, ($1+$2+$3); }
if(/\[Produttore\]\sChiamo\sPRODUCI\((\d+)\)/) { push @produzioni, $1; }
if(/\[Worker\]\sRicevuta\srichiesta\sdi\stipo\sPRODUCI\sCON\sSOMMA\((\d+),\s(\d+),\s(\d+)\)/) { if($produzioni[$#produzioni] != ($1+$2+$3)) { exit(1); } $tot_produzioni++; }
if(/\[Client\]\sRicevuto\srisposta:\srisultato=(\d+),\serrore=(\d+)/) { if($2!=0) { exit(1); } $tot_risposte++; }
if(/\[Worker\]\sRicevuta\srichiesta\sdi\stipo\sPRODUCI\((\d+)\)/) { if($produzioni[$#produzioni] != $1) { exit(1); } $tot_produzioni++; }
if(/\[Consumatore\]\sChiamo\sCONSUMA\(\)/) { }
if(/\[Worker\]\sRicevuta\srichiesta\sdi\stipo\sCONSUMA\(nessun\sparametro\)/) { $tot_consumazioni++; }
if(/\[Consumatore\]\sRicevuto\srisultato=(\d+)/) { push @consumazioni, $1; }
END{
if($tot_produzioni!=3 || $tot_consumazioni!=3 || $tot_risposte!=6) { exit(1); }
foreach $i(0..2) { if($produzioni[$i]!=$consumazioni[$i]) { exit(1); } }
}
' $OUTPUT

if [ $? -ne 0 ]
then
    failure "L'esecuzione non rispetta l'ordine corretto delle produzioni e delle consumazioni"
fi


static_analysis


success


