/*

- Para gerar o fonte digite
$ lex ex01.l

- Para compilar o fonte me C gerado digite
$ gcc ex01.yy.c

- Para executar
$ ./a.out

*/   


/* SEÇÃO DE DEFINIÇÕES */

%{
    /*
        Definições que estarão disponíveis 
            - variáveis
            - constantes
        O que for aqui será copiado para o arquivo *.yy.c
    
        Variáveis declaradas aqui estarão acessível nas funções yylex() e 
        main().
    */
    int contador = 0;
%}

/* Definições de Nomes */
MACRO #[a-zA-Z0-9]*
BIBLIOTECA <[a-zA-Z0-9//./+]*>
FUNCAO [a-zA-Z_][a-zA-Z0-9_]*[ ]*?"("
TIPO_DADO (("unsigned "|"signed ")?+("long "|"short ")?+("long"|"int"|"float"|"char"|"double"))
OPER_ATRIBUICAO "="|"+="|"-="|"*="|"/="|"<<="|">>="
OPER_ARITMETICO "+"|"++"|"-"|"--"|"//"|"*"|"%"
OPER_COMPARACAO "<"|">"|"<="|">="|"=="|"!"|"!="|"&&"|"||"|"<<"|">>"
RESERVADO "continue"|"break"|"auto"|"struct"|"return"
CONDICIONAL "if"|"else"|"else if"|"case"|"switch"|"default"
REPETICAO "for"|"while"|"do"
STRING "\""(.)*"\""
NUMERO [-+]?[0-9]*("."+[0-9]+)?
RESERVADA   "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"
VARIAVEL [a-zA-Z_][a-zA-Z0-9_]*

/* FIM DA SEÇÃO DE DEFINIÇÕES */

%%
    /* SEÇAO DE REGRAS 
        Uma entrada por linha no formato:
        
        padrão  ação

    */

{MACRO}     {printf("<Macro, %s>", yytext); contador++;}
{BIBLIOTECA}     {printf("<Biblioteca, %s>", yytext); contador++;}
{FUNCAO}     {printf("<Nome da função, %s>", yytext); contador++;}
{TIPO_DADO}     {printf("<Tipo de dado, %s>", yytext); contador++;}
{RESERVADO}     {printf("<Reservado, %s>", yytext); contador++;}
{OPER_ATRIBUICAO}     {printf("<Atribuição, %s>", yytext); contador++;}
{OPER_ARITMETICO}     {printf("<Aritmético, %s>", yytext); contador++;}
{OPER_COMPARACAO}     {printf("<Aritmético, %s>", yytext); contador++;}
{CONDICIONAL}    {printf("<Condicional, %s>", yytext); contador++;}
{REPETICAO}     {printf("<Repeticao, %s>", yytext); contador++;}
{STRING}     {printf("<String, %s>", yytext); contador++;}
{NUMERO}     {printf("<Numero, %s>", yytext); contador++;}
{RESERVADA}     {printf("<Reservadas, %s>", yytext); contador++;}
{VARIAVEL}     {printf("<Variavel, %s>", yytext); contador++;}
<<EOF>>             return 0;
    
%%

/*
Seção de Código do Usuário
*/

int yywrap() {}
int main() {
    printf("Iniciando Análise Léxica...\n---\n");
    yylex();
    printf("Foram encontradas %d ocorrências de identificadores.\n", contador);
    printf("---\nÁnalise Finalizada!\n");
    
    return 0;
}
