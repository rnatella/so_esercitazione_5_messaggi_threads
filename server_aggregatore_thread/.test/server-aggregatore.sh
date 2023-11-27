#!/bin/bash

source $(dirname "$0")/../../.test/test.sh

BINARY=programma
OUTPUT=/tmp/output.txt
TIMEOUT=60
SKIPPED=0


init_feedback "Esercizio server aggregatore con thread"

compile_and_run $BINARY $OUTPUT $TIMEOUT


perl -n -e '
if(/Sensore:\sInvio\svalore=(\d+)/) { push @sensore, $1; }
if(/Aggregatore:\sRicevuto\svalore=(\d+)/) { push @aggregatore, $1; }
if(/Aggregatore:\sScrittura\svalore=(\d+)/) { push @scritture, $1; }
if(/Aggregatore:\sLettura\svalore=(\d+)/) { push @letture, $1; if($letture[$#letture] != $scritture[$#scritture]) { exit(1); } }
if(/Collettore:\sRicevuto\svalore=(\d+)/) { push @collettore, $1; }
END{
if($#sensore +1 != 10) { exit(1); }
if($#aggregatore +1 != 10) { exit(1); }
foreach $i(0..$#sensore) { if($sensore[$i]!=$aggregatore[$i]) { exit(1); } }
if($#letture +1 != 30) { exit(1); }
if($#collettore +1 != 30) { exit(1); }
@letture_sort=sort(@letture);
@collettore_sort=sort(@collettore);
foreach $i(0..29) { print "${letture_sort[$i]} ${collettore_sort[$i]}\n"; if($letture_sort[$i]!=$collettore_sort[$i]) { exit(1); } }
}
' $OUTPUT

if [ $? -ne 0 ]
then
    failure "L'esecuzione non rispetta l'ordine corretto dei messaggi e delle letture-scritture"
fi


static_analysis


success


