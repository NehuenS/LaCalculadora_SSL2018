/* Calculadora de notación infija */

%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%token NUM

%left '+' '-'
%left '*' '/'
%left '^'
%left '(' ')'

%% /* A continuación las reglas gramaticales y las acciones */

input:    /* vacío */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t %g\n", $1); }
;

exp:      NUM             { $$ = $1;         }
        | exp '+' exp     { $$ = $1 + $3;    }
        | exp '-' exp     { $$ = $1 - $3;    }
        | exp '*' exp     { $$ = $1 * $3;    }
        | exp '/' exp     { if($3 == 0) yyerror("Division por 0"); else $$ = $1 / $3; }
        | exp '^' exp     { if($1 == 0 && $3 == 0) yyerror("0^0 es una indeterminacion"); else $$ = pow ($1, $3); }
		| '-' exp		  { $$ = -$2;		 }
		| '(' exp ')'     { $$ = $2;		 }
;
%%

yyerror (char *s)  /* Llamada por yyparse ante un error */
{
  printf ("Error: %s\n", s);
}

void main(){
   printf("\nIngrese una expresion aritmetica:\n");
   yyparse();
}
