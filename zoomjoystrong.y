%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "zoomjoystrong.h"
	int yyerror(const char* err);
	int yylex();
%}

%define parse.error verbose

%start program

%union		{
			int iVal;
			int fVal;
		}
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token END_STATEMENT
%token END
%type<iVal> INT
%type<fVal> FLOAT

%%

program:	list_stmt END END_STATEMENT
       	;
list_stmt:	stmt
	|	stmt list_stmt
	;
stmt:		line
    	|	point
	|	circle
	|	rectangle
	|	set_color
    	;
line:		LINE INT INT INT INT END_STATEMENT
    			{	if($2 >= 0 &&
				   $3 >= 0 && 
				   $2 <= WIDTH &&
				   $3 <= HEIGHT &&
				   $4 >= 0 &&
				   $5 >= 0 &&
				   $4 <= WIDTH &&
				   $5 <= HEIGHT)
					{line($2, $3, $4, $5);}
				else
					{printf("Line %i, %i, %i, %i", $2, $3, $4, $5);
					yyerror("Line error: out of bound");}
			}
point:		POINT INT INT END_STATEMENT
     			{	if($2 >= 0 &&
				   $3 >= 0 &&
				   $2 <= WIDTH &&
				   $3 <= HEIGHT)
					{point($2, $3);}
				else
					{printf("Point %i, %i", $2, $3);
					yyerror("Point error: out of bound");}
			}
circle:		CIRCLE INT INT INT END_STATEMENT
      			{	if($2 - $2 >= 0 &&
				   $3 - $4 >= 0 &&
				   $2 + $4 <= WIDTH &&
				   $3 + $4 <= HEIGHT)
					{circle($2, $3, $4);}
				else
					{printf("Circle %i, %i, %i", $2, $3, $4);
					yyerror("Circle error: out of bounds");}
			}
rectangle:	RECTANGLE INT INT INT INT END_STATEMENT
	 		{	if($2 >= 0 &&
				   $3 >= 0 &&
				   $2 <= WIDTH &&
				   $3 <= HEIGHT &&
				   $2 + $4 <= WIDTH &&
				   $3 + $5 <= HEIGHT)
					{rectangle($2, $3, $4, $5);}
				else
				   	{printf("rectangle %i, %i, %i, %i", $2, $3, $4, $5);
					yyerror("Rectangle error: out of bounds");}
			}
set_color:	SET_COLOR INT INT INT END_STATEMENT
	 		{	if($2 >= 0 &&
				   $2 <= 255 &&
				   $3 >= 0 &&
				   $3 <= 255 &&
				   $4 >= 0 &&
				   $4 <= 255)
					{set_color($2, $3, $4);}
				else
				   	{printf("set_color %i, %i, %i", $2, $3, $4);
					yyerror("Invalid color");}
			}
%%

int main(int argc, char** argv){
	char option;
	setup();
	yyparse();
	finish();
}
int yyerror(const char* err){
	printf("%s\n", err);
}
