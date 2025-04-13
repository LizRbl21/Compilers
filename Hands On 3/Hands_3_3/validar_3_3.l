%{
#include "validar_3_3.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

[ \t]+              ; // ignorar espacios
\n                  { return '\n'; }

"true"|"false"      { return BOOL; }
[0-9]+              { yylval = atoi(yytext); return NUMBER; }

"AND"               { return AND; }
"OR"                { return OR; }
"NOT"               { return NOT; }

"("                 { return '('; }
")"                 { return ')'; }

.                   { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
