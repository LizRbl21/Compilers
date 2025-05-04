%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ID 100
char *tabla[MAX_ID];
int ntabla = 0;

void agregar(char *id) {
  for (int i = 0; i < ntabla; i++)
    if (strcmp(tabla[i], id) == 0) return;
  tabla[ntabla++] = strdup(id);
}

int buscar(char *id) {
  for (int i = 0; i < ntabla; i++)
    if (strcmp(tabla[i], id) == 0) return 1;
  return 0;
}

int yylex(void);
int yyerror(const char *s) {
  fprintf(stderr, "Error: %s\n", s);
  return 0;
}
%}

%union { char *str; }

%token <str> ID
%token INT PUNTOYCOMA FUNC RETURN COMMA
%token ASSIGN LPAREN RPAREN LBRACE RBRACE

%%

programa
  : declaraciones elementos
  ;

declaraciones
  :
  | declaraciones INT ID PUNTOYCOMA   { agregar($3); }
  ;

elementos
  :
  | elementos elemento
  ;

elemento
  : sentencia
  | funcion_def
  ;

sentencia
  : ID PUNTOYCOMA
      { if (!buscar($1)) printf("Error semántico: '%s' no está declarado\n", $1); }
  | ID ASSIGN ID PUNTOYCOMA
      { if (!buscar($1)) printf("Error semántico: '%s' no está declarado\n", $1);
        if (!buscar($3)) printf("Error semántico: '%s' no está declarado\n", $3);
      }
  | ID LPAREN args RPAREN PUNTOYCOMA
      { if (!buscar($1)) printf("Error semántico: función '%s' no está declarada\n", $1); }
  ;

args
  :
  | ID                { if (!buscar($1)) printf("Error semántico: '%s' no está declarado\n", $1); }
  | args COMMA ID     { if (!buscar($3)) printf("Error semántico: '%s' no está declarado\n", $3); }
  ;

funcion_def
  : FUNC ID LPAREN listaParam RPAREN LBRACE declaraciones elementos RETURN ID PUNTOYCOMA RBRACE
      { agregar($2); }
  ;

listaParam
  :
  | ID            { agregar($1); }
  | listaParam COMMA ID  { agregar($3); }
  ;

%%

int main() {
  return yyparse();
}
