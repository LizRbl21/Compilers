%{
#include <stdio.h>
%}
%option noyywrap


%%
"int"|"return"   { printf("Palabra clave: %s\n", yytext); fflush(stdout); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("Identificador: %s\n", yytext); fflush(stdout); }
[0-9]+     { printf("Número: %s\n", yytext); fflush(stdout); }
\"([^\\\"]|\\.)*\"  { printf("Cadena: %s\n", yytext); fflush(stdout); }
"//".*     { printf("Comentario de una línea: %s\n", yytext); fflush(stdout); }
"/*"(.|\n)*?"*/"  { printf("Comentario de múltiples líneas\n"); fflush(stdout); }
[ \t\r\n]+   ;  // Ignorar espacios, tabulaciones y saltos de línea
.          { printf("Símbolo desconocido: %s\n", yytext); fflush(stdout); }
%%

int main() {
    yylex();
    return 0;
}
