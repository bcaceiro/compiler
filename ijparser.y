%{
#include<stdio.h>
%}
%union{
char cval;
int intval;
}
%token <intval> NUMBER

%% 
calc: 		expression 			{printf("%d\n", $1);}

Start :  Program;

Program : CLASS ID OBRACE field_or_method_decaration CBRACE;

field_or_method_decaration : 
		FieldDecl field_or_method_decaration 
	| 	MethodDecl field_or_method_decaration
	|	;


FieldDecl :
		STATIC VarDecl;

MethodDecl :
		PUBLIC STATIC method_type_declaration ID OCURV FormalParams CCURV OBRACE VarDecl { Statement } CBRACE;

method_type_declaration:
		Type
	|	VOID;

FormalParams : 
		Type ID several_FormalParams
	|	STRING OSQUARE CSQUARE ID
	|   ;

several_FormalParams : 
		COMMA Type ID several_FormalParams
	|	;

VarDecl :
		Type ID several_var_decl_in_same_instructionOPTIONAL SEMIC VarDecl
	|	;

several_var_decl_in_same_instructionOPTIONAL:
		COMMA ID
	|	;

Type : 
		INT square_brackets
	| 	BOOL square_brackets;

square_brackets : 
	 OSQUARE CSQUARE;

Statement : 
		OBRACE several_statement CBRACE;
	|	IF OCURV Expr CCURV Statement 
	|	IF OCURV Expr CCURV Statement ELSE Statement;
	|	WHILE OCURV Expr CCURV Statement;
	|	PRINT OCURV Expr CCURV SEMIC;
	|	ID array_index ASSIGN Expr SEMIC;
	|	RETURN return_expression SEMIC;

several_statement:
		Statement
	|	;

array_index:
		OSQUARE Expr CSQUARE
	|	;

return_expression : 
		Expr
	|	;

Expr : 
		Expr ( OP1 | OP2 | OP3 | OP4 ) Expr
	|	Expr OSQUARE Expr CSQUARE;
	|	ID | INTLIT | BOOLLIT;
	|	NEW ( INT | BOOL ) OSQUARE Expr CSQUARE;
	|	OCURV Expr CCURV;
	|	Expr DOTLENGTH | ( OP3 | NOT ) Expr;
	|	PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV;
	|	ID OCURV [ Args ] CCURV;

Args : Expr { COMMA Expr };


%%
void yyerror (char *s) {
	//TODO
	//printf ("Line %d, col %d: %s: %s\n", <num linha>, <numcoluna>, s, yytext);
	printf("%s",s);
}
int main()
{

yyparse();

}
