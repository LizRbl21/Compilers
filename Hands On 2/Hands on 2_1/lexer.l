%{
#include <stdio.h>
%}
%option noyywrap


%%
"int"      { printf("Palabra clave: %s\n", yytext); fflush(stdout); }
"return"   { printf("Palabra clave: %s\n", yytext); fflush(stdout); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("Identificador: %s\n", yytext); fflush(stdout); }
[0-9]+     { printf("Número: %s\n", yytext); fflush(stdout); }
[ \t\r\n]+   ;  // Ignorar espacios y saltos de línea
.          { printf("Símbolo desconocido: %s\n", yytext); fflush(stdout); }

%%

int main() {
    yylex();
    return 0;
}
