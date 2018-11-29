%{
	#include <stdio.h>
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

program:	list_stmt END END_STATEMENT
       	;

list_stmt:	stmt
 	|	list_stmt stmt	
	;

stmt:		LINE INT INT INT INT END_STATEMENT
    	|	POINT INT INT END_STATEMENT
	|	CIRCLE INT INT INT END_STATEMENT
	|	RECTANGLE INT INT INT INT END_STATEMENT
	|	SET_COLOR INT INT INT END_STATEMENT
    	;

%%

int main(int argc, char** argv){
	yyparse();
}
int yyerror(const char* err){
	printf("%s\n", err);
}
