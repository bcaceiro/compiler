%{
#include <stdio.h>
#include <string.h>
void yyerror(char *s);

extern int column;
extern int yylineno;
extern char* yytext;
extern int yyleng;

%}
%union{
	char cval;
	int intval;
}


%token INTLIT BOOLLIT INT BOOL NEW IF ELSE WHILE PRINT PARSEINT CLASS PUBLIC STATIC VOID STRING DOTLENGTH RETURN OCURV CCURV OBRACE CBRACE OSQUARE CSQUARE OP1 OP2 OP3 OP4 NOT ASSIGN SEMIC COMMA RESERVED ID

%nonassoc REDUCEEXPRESSON1

%nonassoc IFX
%nonassoc ELSE

%right ASSIGN
%left OP1
%left OP3
%left OP2
%left OP4
%left OSQUARE DOTLENGTH
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

Cenas: 
		Expr operations Expr %prec OPS_FTW
	|	ID
	|	INTLIT
	|	BOOLLIT
	|	not_or_op3 Expr %prec OPS_FTW
	|	OCURV Expr CCURV
	|	Expr DOTLENGTH;
	|	PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV
	|	ID OCURV Args_OPTIONAL CCURV;

Expr : 
		Cenas %prec REDUCEEXPRESSON1
	|	Cenas OSQUARE Cenas CSQUARE
	|	NEW int_or_bool OSQUARE Expr CSQUARE;	



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

int main(){
	yyparse();
	return 0;
}

void yyerror (char *s) {
	printf ("Line %d, col %d: %s: %s\n",yylineno, (int)(column-strlen(yytext)), s, yytext);
}
