%{
	#include <stdio.h>
	#include <math.h>
	#include "zoomjoystrong.tab.h"
	void printLexeme();
%}

INT	[0-9]

%%

end		return END;

;		return END_STATEMENT;

point		return POINT;

line		return LINE;

circle		return CIRCLE;

rectangle	return RECTANGLE;

set_color[s]?	return SET_COLOR;

{INT}+		return INT;

{INT}+"."{INT}*	return FLOAT;

"+"|"-"|"*"|"/"	printf("TERMINAL OPERATOR: %s\n", yytext);

"{"[^}\n]*"}"	;	/* ignores one-line comments */

[ \t\n]+	;	/* ignores whitespaces */

.		printf("ERROR on line 1: %s\n", yytext);

%%

void printLexeme() {
	printf("(%s)\n", yytext);
}

/*
int main(int argc, char** argv) {
	yylex();
	return 0;
}
*/
