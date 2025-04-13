%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
int yyerror(const char *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%

input:
      /* permite múltiples líneas */
      input expr '\n'   { printf("Expresión Válida\n\n"); }
    | input error '\n'  {
        yyerror("Expresión Inválida");
        yyerrok;
        printf("\n\n");
    }
    | /* vacío */       { printf("Ingresar Expresion:\n\n"); }
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



