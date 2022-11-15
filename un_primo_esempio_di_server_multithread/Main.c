#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#include "Header.h"




int main(){

	pid_t pidc, pids;
	int id_c, id_s,i;
	int ret;


	id_c = /* Ottenere una coda per le richieste dal client al server */

	if(id_c < 0) {
		perror("Errore allocazione coda");
		exit(1);
	}

	id_s = /* Ottenere una coda per le risposte dal server al client */

	if(id_s < 0) {
		perror("Errore allocazione coda");
		exit(1);
	}



	for(i=0;i<CLIENT;i++){

		/* TBD: Avviare i processi client, chiamando client() */
	}


	pids = fork();

	if(pids<0) {
		perror("Errore fork server");
		exit(1);
	}

	/* TBD: Avviare il processo server, chiamando server() */


	/* TBD: Attendere la terminazione dei client */


	/* TBD: Inviare al server il messaggio di terminazione, con i valori {-1, -1} */

	ret = /* TBD */
	if(ret < 0) {
		perror("Errore invio messaggio di terminazione");
		exit(1);
	}

	wait(0);

	/* TBD: Deallocazione code */

	return 0;

}

