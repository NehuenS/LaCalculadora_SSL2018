/* Calculadora de notación infija */

%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%token NUM
%token ENTERO

%left '+' '-'
%left '*' '/'
%left '^'
%left '(' ')'

%union { /*Permite el uso de multiples tipos en yylval*/
  int ival; 
  double val;
}


%% /* A continuación las reglas gramaticales y las acciones */

input:    /* vacío */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t %g\n", $<val>1); }
;

exp:      NUM             { $<val>$ = $<val>1;         		}
		| ENTERO		  { $<val>$ = $<ival>1;         	}
        | exp '+' exp     { $<val>$ = $<val>1 + $<val>3;    }
        | exp '-' exp     { $<val>$ = $<val>1 - $<val>3;    }
        | exp '*' exp     { $<val>$ = $<val>1 * $<val>3;    }
        | exp '/' exp     { if($<val>3 == 0) {yyerror("Division por 0"); return 1;} else $<val>$ = $<val>1 / $<val>3; 						   		 }
        | exp '^' exp     { if($<val>1 == 0 && $<val>3 == 0) {yyerror("0^0 es una indeterminacion"); return 1;} else $<val>$ = pow ($<val>1, $<val>3); }
		| '-' exp		  { $<val>$ = -$<val>2;		 		}
		| '(' exp ')'     { $<val>$ = $<val>2;		 		}
;

%%

yyerror (char *s)  /* Llamada por yyparse ante un error */
{
  printf ("Error: %s\n", s);
}

void main(){
   printf("Ingrese una expresion aritmetica:\n");
   yyparse();
}
