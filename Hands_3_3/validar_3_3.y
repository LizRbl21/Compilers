%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
int yyerror(const char *s);
%}

%token NUMBER
%token BOOL
%token AND OR NOT

%left OR
%left AND
%left '+' '-'
%left '*' '/'
%right NOT

%%

input:
      input expr '\n'   { printf("Expresión Válida\n\n"); }
    | input error '\n'  {
        yyerror("Expresión Inválida");
        yyerrok;
        printf("\n\n");
    }
    | /* vacío */       { printf("Ingrese Expresión\n"); }
    ;

expr:
      expr '+' term
    | expr '-' term
    | term
    ;

term:
      term '*' factor
    | term '/' factor
    | factor
    ;

factor:
      '(' expr ')'
    | logical
    ;

logical:
      logical AND logic_term
    | logical OR logic_term
    | logic_term
    ;

logic_term:
      NOT factor
    | BOOL
    | NUMBER
    ;

%%

int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void) {
    return yyparse();
}
