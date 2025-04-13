%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
int yyerror(const char *s);
%}

%token BOOLEAN
%token AND OR NOT

%left OR
%left AND
%right NOT

%%

input:
      input expr '\n'   { printf("Expresión Lógica Válida\n\n"); }
    | input error '\n'  {
        yyerror("Expresión lógica inválida");
        yyerrok;
        printf("\n\n");
    }
    | /* vacío */       { printf("Ingresa una Expresión Lógica:\n"); }
    ;

expr:
      expr AND term
    | expr OR term
    | term
    ;

term:
      NOT factor
    | factor
    ;

factor:
      '(' expr ')'
    | BOOLEAN
    ;

%%

int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void) {
    return yyparse();
}
