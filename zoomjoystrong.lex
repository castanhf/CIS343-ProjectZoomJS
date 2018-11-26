%{
	#include <stdio.h>
	#include <math.h>
	void printLexeme();
%}

INT	[0-9]

%%

end	{
	printf("END\t");
	printLexeme();
	printf("\n");
}

;	{
	printf("END_STATEMENT\t");
	printLexeme();
	printf("\n");
}

"point"	{
	printf("POINT\t");
	printLexeme();
	printf("\n");
}

"line"	{
	printf("LINE\t");
	printLexeme();
	printf("\n");
}

"circle"	{
	printf("CIRCLE\t");
	printLexeme();
	printf("\n");
}

"rectangle"	{
	printf("RECTANGLE\t");
	printLexeme();
	printf("\n");
}

"set color"[s]?	{
	printf("SET_COLOR\t");
	printLexeme();
	printf("\n");
}

{INT}+	{
	printf("INT\t");
	printLexeme();
	printf("\n");
}

{INT}+"."{INT}*	{
	printf("FLOAT\t");
	printLexeme();
	printf("\n");
}

"+"|"-"|"*"|"/"	printf("TERMINAL OPERATOR: %s\n", yytext);

"{"[^}\n]*"}"	/* ignores one-line comments */

[ \t\n]+	/* ignores whitespaces */

.	printf("ERROR on line 1: %s\n", yytext);

%%

void printLexeme() {
	printf("(%s)\n", yytext);
}

int main(int argc, char** argv) {
	yylex();
	return 0;
}
