%code requires {
  int yylex(void);
}

%code {
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

int yyerror(char *s) {
  fprintf(stderr, "Error: %s\n", s);
  return 0;
}
}

%union { char *str; }

%token <str> ID
%token INT PUNTOYCOMA FUNC RETURN COMMA

%%

programa
  : elemento*  
  ;


elemento
  
  : INT ID PUNTOYCOMA       { agregar($2); }
  
  | ID PUNTOYCOMA           { if (!buscar($1)) printf("Error semántico: '%s' no está declarado\n", $1); }
  
  | ID '=' ID PUNTOYCOMA    { if (!buscar($1)) printf("Error semántico: '%s' no está declarado\n", $1);
                              if (!buscar($3)) printf("Error semántico: '%s' no está declarado\n", $3);
                            }
  
  | ID '(' args ')' PUNTOYCOMA  { if (!buscar($1)) printf("Error semántico: función '%s' no está declarada\n", $1); }
  
  | FUNC ID '(' listaParam ')' '{' elemento* RETURN ID PUNTOYCOMA '}'
      { agregar($2); /* registrar nombre de función */ }
  ;

args
  :
  | ID                { if (!buscar($1)) printf("Error semántico: '%s' no está declarado\n", $1); }
  | args COMMA ID     { if (!buscar($3)) printf("Error semántico: '%s' no está declarado\n", $3); }
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