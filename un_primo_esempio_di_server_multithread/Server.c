#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <unistd.h>

#include "Header.h"

/* Il thread padre condivide l'id della coda 
   delle risposte con i figli, tramite una 
   variabile globale */

int id_coda_risposte;



void server(int id_c, int id_s){

	int k;
	int ret;

	id_coda_risposte = id_s;


	while(1){

		/* TBD: Ricevere un messaggio di richiesta dal client */
	
		ret = /* TBD */

		if(ret < 0) {
			perror("Errore ricezione richiesta server");
			exit(1);
		}

		if( /* TBD */ == -1 && /* TBD */ == -1){

			/* Il processo esce quando si riceve un messaggio di terminazione,
			   con i valori {-1, -1}
			 */
			
			exit(0);
		}

		/* TBD: Avviare un thread figlio per l'elaborazione del messaggio,
				passandogli una **copia sullo heap** del messaggio ricevuto.
				(ogni thread figlio deve elaborare un messaggio diverso)
		 */

	}

}



void* Prodotto(void* v){

	int ret;

	int v3 = /* TBD: Calcolare il prodotto */


	/* TBD: Inviare il messaggio di risposta al client.
	        Si chiami la funzione msgsnd() all'interno di una
			sezione critica.
	 */

	printf("\nSono Prodotto di Server. Invio del calcolo: %d\n\n", v3);  

	ret = /* TBD */

	if(ret < 0) {
		perror("Errore invio risposta server");
		exit(1);
	}


	pthread_exit(NULL);
}

