%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct No {
    char token[50];
    int num_filhos;
    struct No** filhos;
} No;


No * ramo(char *operador, char *label, No *esq, No *dir);
No* allocar_no();
void liberar_no(No* no);
void imprimir_arvore(No* raiz);
No* novo_no(char[50], No**, int);

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union 
{
    int number;
    char simbolo[50];
    struct No* no;
}
%token NUM
%token ADD
%token SUB
%token MUL
%token DIV
%token APAR
%token FPAR
%token EOL

%type<no> calc
%type<no> termo
%type<no> fator
%type<no> exp
%type<simbolo> NUM
%type<simbolo> MUL
%type<simbolo> DIV
%type<simbolo> SUB
%type<simbolo> ADD


%%
/* Regras de Sintaxe */

calc:
    | calc exp EOL       { imprimir_arvore($2); } 

exp: fator               
   | exp ADD fator       { $$ = ramo("+", "exp", $1, $3); }
   | exp SUB fator       { $$ = ramo("-", "exp", $1, $3); }
   ;

fator: termo            
     | fator MUL termo  { $$ = ramo("*", "termo", $1, $3); }
     | fator DIV termo  { $$ = ramo("/", "termo", $1, $3); }
     ;

termo: NUM { $$ = novo_no($1, NULL, 0); }               


%%

/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */

No * ramo(char *operador, char *label, No *op1, No *op2){
    No** filhos = (No**) malloc(3 * sizeof(No*));

    filhos[0] = op1;
    filhos[1] = novo_no(operador, NULL, 0);
    filhos[2] = op2;

    return novo_no(label, filhos, 3);
}

No* allocar_no(int num_filhos) {
    return (No *) malloc(num_filhos * sizeof(No));
}

void liberar_no(No* no) {
    free(no);
}

No* novo_no(char token[50], No** filhos, int num_filhos) {
   No *no = allocar_no(3);

   strcpy(no->token, token);

   no->num_filhos = num_filhos;
   no->filhos = filhos;

   return no;
}

void imprimir_arvore(No* raiz) {
    int i;
    if(raiz == NULL){
        printf("***");
        return;
    }

    printf("<%s>", raiz->token);

    if(raiz->filhos != NULL){
        printf(" -> ");
        for(i = 0; i < 3; i++)
            imprimir_arvore(raiz->filhos[i]);
        printf("(folha)\n");
    }else
        printf(" ");
}


int main(int argc, char** argv) {
    yyparse();
}

yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}

