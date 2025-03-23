%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    double val;
}

%token <val> NUMBER
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN EXP

%left PLUS MINUS
%left TIMES DIVIDE
%right EXP
%precedence UMINUS
%type <val> expr

%%

input:
      /* boş */
    | input '\n'
    | input expr '\n'         { printf("Sonuç: %.2lf\n", $2); }
    | input error '\n'        { yyerror("Geçersiz ifade!"); yyerrok; }
    ;

expr:
      MINUS expr %prec UMINUS   { $$ = -$2; }
    | expr PLUS expr            { $$ = $1 + $3; }
    | expr MINUS expr           { $$ = $1 - $3; }
    | expr TIMES expr           { $$ = $1 * $3; }
    | expr DIVIDE expr          {
                                  if ($3 == 0) {
                                      yyerror("Sıfıra bölme hatası!");
                                      $$ = 0;
                                  } else {
                                      $$ = $1 / $3;
                                  }
                                }
    | expr EXP expr             { $$ = pow($1, $3); }
    | LPAREN expr RPAREN        { $$ = $2; }
    | NUMBER                    { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    if (strcmp(s, "syntax error") == 0)
        fprintf(stderr, "Hata: Geçersiz ifade!\n");
    else
        fprintf(stderr, "Hata: %s\n", s);
}

int main() {
    printf("Hesap makinesi başlatıldı.\n");
    setbuf(stdin, NULL);
    yyparse();
    return 0;
}
