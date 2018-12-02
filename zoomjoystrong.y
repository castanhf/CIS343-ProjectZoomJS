%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int yyerror(const char* err);
%}

%define parse.error verbose

%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token END_STATEMENT
%token END

%%

program:	{setup()} list_stmt END END_STATEMENT {finish();}
       	;

list_stmt:	stmt
	|	list_stmt stmt
	;

stmt:		LINE INT INT INT INT {line($2, $3, $4, $5);}
    	|	POINT INT INT {point($2, $3);}
	|	CIRCLE INT INT INT {circle($2, $3, $4);}
	|	RECTANGLE INT INT INT INT {rectangle($2, $3, $4, $5);}
	|	SET_COLOR INT INT INT {set_color($2, $3, $4);}
    	;

%%

int main(int argc, char** argv){
	yyparse();
}
int yyerror(const char* err){
	printf("%s\n", err);
}
