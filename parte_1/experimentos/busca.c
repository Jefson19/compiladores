#include<stdio.h>

int main(){
	int busca, i, indice;
	int vetor[10] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100}	;

	busca = 80;
	indice = -1;

	for(i = 0; i < 10; i++){
		if(vetor[i] == busca)
			indice = i;
	}

	if(indice != -1)
		printf("Achou no indice: %d\n", indice);
	else
		printf("Nao achou o elemento\n");

	return 0;
}
