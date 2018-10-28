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

%union {
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
        | exp '/' exp     { if($<val>3 == 0) {yyerror("Division por 0");} else $<val>$ = $<val>1 / $<val>3; 						   		 }
        | exp '^' exp     { if($<val>1 == 0 && $<val>3 == 0) {yyerror("0^0 es una indeterminacion");} else $<val>$ = pow ($<val>1, $<val>3); }
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

/*ent:      ENTERO          { $<ival>$ = $<ival>1;         		}
		| exp			  { $<val>$ = $<ival>1;         		}
        | ent '+' ent     { $<ival>$ = $<ival>1 + $<ival>3;     }
        | ent '-' ent     { $<ival>$ = $<ival>1 - $<ival>3;     }
        | ent '*' ent     { $<ival>$ = $<ival>1 * $<ival>3;     }
        | ent '/' ent     { if($<ival>3 == 0) {yyerror("Division por 0");} else $<ival>$ = $<ival>1 / $<ival>3; 						   		  }
        | ent '^' ent     { if($<ival>1 == 0 && $<ival>3 == 0) {yyerror("0^0 es una indeterminacion");} else $<ival>$ = pow ($<ival>1, $<ival>3); }
		| '-' ent		  { $<ival>$ = -$<ival>2;		 		}
		| '(' ent ')'     { $<ival>$ = $<ival>2;		 		}
;*/
