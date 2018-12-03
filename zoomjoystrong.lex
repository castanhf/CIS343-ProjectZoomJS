%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "zoomjoystrong.tab.h"
	void printLexeme();
	void yyerror(char*);
	int fileno(FILE *stream);
%}

INT	[0-9]

%%

end		{return END;}

;		{return END_STATEMENT;}

point		{return POINT;}

line		{return LINE;}

circle		{return CIRCLE;}

rectangle	{return RECTANGLE;}

set_color	{return SET_COLOR;}

{INT}+		{
			yylval.iVal = atoi(yytext);
			return INT;}

{INT}+"."{INT}*	{
			yylval.fVal = atof(yytext);
			return FLOAT;}

"+"|"-"|"*"|"/"	printf("TERMINAL OPERATOR: %s\n", yytext);

"{"[^}\n]*"}"	;	/* ignores one-line comments */

[ \t\n]+	;	/* ignores whitespaces */

.		{
			printf("ERROR on line 1: %s\n", yytext);
			yyerror("This is an invalid character");}

%%

void printLexeme() {
	printf("(%s)\n", yytext);
}
