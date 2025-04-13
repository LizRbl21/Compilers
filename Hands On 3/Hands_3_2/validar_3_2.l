%{
#include "validar_3_2.tab.h"
#include <string.h>
%}

%%

[ \t]+           ; // ignorar espacios
\n               { return '\n'; }

"1"|"0"   { return BOOLEAN; }

"AND"            { return AND; }
"OR"             { return OR; }
"NOT"            { return NOT; }

"("              { return '('; }
")"              { return ')'; }

.                { return yytext[0]; }

%%

int yywrap() {
    return 1;
}

