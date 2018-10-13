/* Calculadora de notación polaca inversa */

%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%token NUM

%% /* A continuación las reglas gramaticales y las acciones */

input:    /* vacío */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t %d\n", $1); }
;

exp:      NUM             { $$ = $1;         }
        | exp exp '+'     { $$ = $1 + $2;    }
        | exp exp '-'     { $$ = $1 - $2;    }
        | exp exp '*'     { $$ = $1 * $2;    }
        | exp exp '/'     { $$ = $1 / $2;    }
        | exp exp '^'     { $$ = pow ($1, $2); }

;
%%

yyerror (s)  /* Llamada por yyparse ante un error */
     char *s;
{
  printf ("%s\n", s);
}

main ()
{
  yyparse ();
}
