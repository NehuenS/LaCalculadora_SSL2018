
%{
#include <stdlib.h>
#include "calculadora.tab.h"
%}
%option noyywrap

%%

0[0-7]* {yylval = strtol(yytext, NULL, 0); return NUM;} //Entero base 8
[0-9]+(\.[0-9]+)?  {yylval = atof(yytext); return NUM;} //Real base 10
0[xX][0-9a-fA-f]* {yylval = strtol(yytext, NULL, 0); return NUM;} //Entero base 16
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"\n"    {return '\n';} // Comentario para primer comit

%%

