
%{
#include "calculadora.tab.h"
%}


%%

[0-9]+  {yylval = atoi(yytext); return NUM;}
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"\n"    {return '\n';} // Comentario para primer comit

%%

