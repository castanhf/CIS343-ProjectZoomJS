%{
	#include <stdio.h>
	int yyerror(const char* err);
%}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%%

program:	list_stmt
       	;

list_stmt:	stmt
	|	stmt list_stmt
	;

stmt:		LINE 
    	|	POINT
	|	CIRCLE
	|	RECTANGLE
	|	SET_COLOR
	|	INT
	|	FLOAT
    	|	END_STATEMENT
    	|	END
    	;

%%

int main(int argc, char** argv){
	yyparse();
}
int yyerror(const char* err){
	printf("%s\n", err);
}
