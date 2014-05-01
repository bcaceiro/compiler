%{
#include <stdio.h>
#include <string.h>
#include "show.h"
#include "structures.h"

void yyerror(char *s);

//Lex variables
extern int column;
extern int yylineno;
extern char* yytext;
extern int yyleng;

//program tree
Class* program = NULL;

//simbol tree
//ClassTable* symbols = NULL;

%}
%union{
	char cval;
	int intval;
}


%token INTLIT BOOLLIT INT BOOL NEW IF ELSE WHILE PRINT PARSEINT CLASS PUBLIC STATIC VOID STRING DOTLENGTH RETURN OCURV CCURV OBRACE CBRACE OSQUARE CSQUARE OP1 OP2 OP3 OP4 NOT ASSIGN SEMIC COMMA RESERVED ID

%nonassoc REDUCEEXPRESSON1

%nonassoc IFX
%nonassoc ELSE

%left OP1
%left OP3
%left OP2
%left OP4
%right ASSIGN
%left OSQUARE
%left OBRACE
%left NOT
%left DOTLENGTH
%right OPS_FTW




%% 

Start :
		CLASS ID OBRACE field_or_method_decaration CBRACE;

field_or_method_decaration : 
		FieldDecl field_or_method_decaration 
	| 	MethodDecl field_or_method_decaration
	|	;

FieldDecl :
		STATIC VarDecl;

MethodDecl :
		PUBLIC STATIC method_type_declaration ID OCURV FormalParams CCURV OBRACE VarDecl statement_declaration_REPETITION CBRACE;

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
		COMMA ID several_var_decl_in_same_instructionOPTIONAL
	|	;

Type : 
		int_or_bool square_brackets_OPTIONAL;

square_brackets_OPTIONAL : 
		OSQUARE CSQUARE
	|	;
	
statement_declaration_REPETITION:
		Statement statement_declaration_REPETITION
	|	;

Statement : 
		OBRACE several_statement CBRACE
	|	IF OCURV Expr CCURV Statement %prec IFX
	|	IF OCURV Expr CCURV Statement ELSE Statement
	|	WHILE OCURV Expr CCURV Statement
	|	PRINT OCURV Expr CCURV SEMIC
	|	ID array_indexOPTIONAL ASSIGN Expr SEMIC
	|	RETURN return_expression SEMIC;

several_statement:
		Statement several_statement
	|	;

array_indexOPTIONAL:
		OSQUARE Expr CSQUARE
	|	;

return_expression : 
		Expr
	|	;

IndexableExpr: 
		ID
	|	INTLIT
	|	BOOLLIT
	|	ID OCURV Args_OPTIONAL CCURV
	|	OCURV Expr CCURV
	|	Expr DOTLENGTH
	|	IndexableExpr OSQUARE Expr CSQUARE
	|	PARSEINT OCURV ID OSQUA[RE Expr CSQUARE CCURV;

Expr : 
		Expr operations Expr %prec OPS_FTW
	|	not_or_op3 Expr %prec OPS_FTW
	|	NEW int_or_bool OSQUARE Expr CSQUARE
	|	IndexableExpr;


operations:
		OP1
	|	OP2
	|	OP3
	|	OP4;

int_or_bool:
		INT
	|	BOOL;

not_or_op3:
		OP3
	|	NOT;

Args_OPTIONAL:
		Args
	|	;

Args:
		Expr comma_expr

comma_expr: 
		COMMA Expr comma_expr
	|	;


%%

int main(int argc, char *argv[]){
	int i, printTree, printSymbols;

	yyparse();

	
	printTree = printSymbols = 0;
	for(i=0; i < argc; i++)
	{
		//caso a flag -s esteja presente
		if(strcmp(argv[i], "-s") == 0)
		{
			printSymbols = 1;
			break;
		}
		//caso a flag -t esteja presente
		else if(strcmp(argv[i], "-t") == 0)
		{
			printTree = 1;
			break;
		}
	}

	/*if(printTree)
		show_program(program);*/
	//TODO
	/*if(printSymbols)
		printSymbols(symbols);
	*/
	//TODO:LIMPAR MEMÓRIA???
		
    return 0;
}

void yyerror (char *s) {
	printf ("Line %d, col %d: %s: %s\n",yylineno, (int)(column-strlen(yytext)), s, yytext);
}
