#!/bin/bash

source $(dirname "$0")/../../.test/test.sh

BINARY=Start
OUTPUT=/tmp/output.txt
TIMEOUT=60
SKIPPED=0


init_feedback "Esercizio primo esempio di server multithread"

compile_and_run $BINARY $OUTPUT $TIMEOUT


perl -n -e '
if(/Richiesta\s(\d+)\sInviata\s\((\d+),\s(\d+)\)\s\[PID=(\d+)\]/) { $n=$1; $op1=$2; $op2=$3; $pid=$4; $req{$pid}[$n]=[$op1,$op2]; $requests++; }
if(/Risposta\s(\d+)\sRicevuta\s\((\d+)\)\s\[PID=(\d+)\]/) { $n=$1; $r=$2; $pid=$3; if(! exists($req{$pid}[$n])) { exit(1); } $resp{$pid}[$n]=$r; $responses++; }
END {
if($requests!=15 || $responses!=15 || keys(%req)!=3 || keys(%resp)!=3) { exit(1); }
foreach $pid(keys(%req)) { for $n(0..4) { if(!exists($resp{$pid})){exit(1);} ($op1,$op2) = @{$req{$pid}[$n]}; $r=$resp{$pid}[$n]; if($op1*$op2 != $r) { exit(1); } } } }
' $OUTPUT

if [ $? -ne 0 ]
then
    failure "L'esecuzione non effettua correttamente l'invio dei messaggi di richiesta e risposta"
fi


static_analysis


success


