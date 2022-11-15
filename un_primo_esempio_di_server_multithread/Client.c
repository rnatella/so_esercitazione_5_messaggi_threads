#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <unistd.h>

#include "Header.h"

void client(int id_c, int id_s){

	int k;
	int ret;

	srand(getpid());



	for(k=0;k<RICHIESTE;k++){

		/* TBD: Inviare un messaggio di richiesta */

		int v1 = rand()%101;
		int v2 = rand()%101;

		printf("Richiesta %d Inviata (%d, %d) [PID=%ld]\n\n", k, v1, v2, getpid());

		ret = /* TBD */

		if(ret < 0) {
			perror("Errore invio richiesta client");
			exit(1);
		}


		/* TBD: Ricevere un messaggio di risposta */

		ret = /* TBD */

		if(ret < 0) {
			perror("Errore ricezione risposta client");
			exit(1);
		}

		int v3 = /* TBD */

		printf("Risposta %d Ricevuta (%d) [PID=%ld]\n\n", k, v3, getpid();
	}

}

