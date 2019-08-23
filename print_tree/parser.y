%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */

#include <stdio.h>
#include <stdlib.h>

typedef struct No {
    char token[50];
    struct No* direita;
    struct No* esquerda;
} No;


No* allocar_no();
void liberar_no(void* no);
void imprimir_arvore(No* raiz, int loop, char lado[]);
No* novo_no(char[50], No*, No*);

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
    | calc exp EOL       { imprimir_arvore($2, 1, "raiz"); printf("\n"); } 

exp: fator              
   | exp ADD fator       { $$ = novo_no("+", $1, $3); }
   | exp SUB fator       { $$ = novo_no("-", $1, $3); }
   ;

fator: termo            
     | fator MUL termo  { $$ = novo_no("*", $1, $3); }
     | fator DIV termo  { $$ = novo_no("/", $1, $3); }
     ;

termo: NUM {
    $$ = novo_no($1, NULL, NULL);
}

           
%%

/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */

No* allocar_no() {
    return (No*) malloc(sizeof(No));
}

void liberar_no(void* no) {
    free(no);
}

No* novo_no(char token[50], No* esquerda, No* direita) {
   No* no = allocar_no();
   snprintf(no->token, 50, "%s", token);
   no->direita = direita;
   no->esquerda = esquerda;

   return no;
}

void imprimir_arvore(No* raiz, int loop, char lado[]) {
    int i;
    for(i = 0; i < loop; i++)
        printf("-");
    
    if(raiz == NULL) { printf("***<%s>\n", lado); return; }
    printf("(%s)<%s>\n", raiz->token, lado);
    imprimir_arvore(raiz->direita, loop + 2, "direita");
    imprimir_arvore(raiz->esquerda, loop + 2, "esquerda");
}


int main(int argc, char** argv) {
    yyparse();
}

yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}


