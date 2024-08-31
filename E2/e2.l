/* e2.l */
%{
#include <stdio.h>
#include <stdlib.h>   // Para usar atoi
#include "token.h"


int lines = 0;
int words = 0;
int chars = 0;
int yylval;   
%}

%option noyywrap nodefault yylineno

%%

[ \t]+               {}

\n                   { lines++; return EOL; } 

[0-9]+               {
                        yylval = atoi(yytext);  
                        words++;  
                        printf("constante decimal: %d\n", yylval);
                        return NUMBER;
                     }

"+"                  { chars++; return PLUS; }
"-"                  { chars++; return MINUS; }
"*"                  { chars++; return TIMES; }
"/"                  { chars++; return DIV; }

.                    { chars++; return ERROR; }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            printf("error\n");
            return 1;
        }
    }
    yylex();  // Chama o analisador léxico

    printf("%8d%8d%8d %s\n", lines, words, chars, argc > 1 ? argv[1] : "stdin");

    return 0;
}




