%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%
"#".*               ;  // Yorum satırlarını yoksay
[0-9]+\.[0-9]+         { yylval.val = atof(yytext); return NUMBER; }
[0-9]+                 { yylval.val = atof(yytext); return NUMBER; }
"**"                   { return EXP; }
"^"                    { return EXP; }
"+"                    { return PLUS; }
"-"                    { return MINUS; }
"*"                    { return TIMES; }
"/"                    { return DIVIDE; }
"("                    { return LPAREN; }
")"                    { return RPAREN; }
"\n"                   { return '\n'; }
[ \t\r]+               ;  // boşlukları yoksay
.                      { printf("Geçersiz karakter: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
