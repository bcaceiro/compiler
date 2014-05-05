%{
#include <stdio.h>
#include <string.h>

#include "show.h"
//#include "show.c"
#include "structures.h"
//#include "functions.c"

void yyerror(char *s);

//Lex variables
extern int column;
extern int yylineno;
extern char* yytext;
extern int yyleng;

//program tree
Node* program = NULL;

//simbol tree
//ClassTable* symbols = NULL;

%}
%union{
    struct _Node* node;
    char* token;
    struct _idList* listId;
    int type; /*enums are a int FIX?*/
}

%type<node> Start
%type<node> field_or_method_declaration
%type<node> FieldDecl
%type<node> MethodDecl
%type<type> method_type_declaration
%type<node> FormalParams
%type<node> several_FormalParams
%type<node> VarDecl
%type<listId> several_var_decl_in_same_instructionOPTIONAL
%type<type> Type
%type<node> statement_declaration_REPETITION
%type<node> Statement
%type<node> several_statement
%type<node> array_indexOPTIONAL
%type<node> return_expression
%type<node> IndexableExpr
%type<node> Expr
%type<token> operations
%type<node> Args_OPTIONAL
%type<node> Args
%type<node> comma_expr


%token <token> INTLIT BOOLLIT INT BOOL NEW IF ELSE WHILE PRINT PARSEINT CLASS PUBLIC STATIC VOID STRING DOTLENGTH RETURN OCURV CCURV OBRACE CBRACE OSQUARE CSQUARE OP1 OP2 OP3 OP4 NOT ASSIGN SEMIC COMMA RESERVED ID


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
%left CBRACE
%left NOT
%left DOTLENGTH
%right OPS_FTW
s
us


%% 

Start :
                CLASS ID OBRACE field_or_method_declaration CBRACE          {printf("New class\n");$$ = insertClass($2,$4);program = $$;}
        ;

field_or_method_declaration :
                FieldDecl field_or_method_declaration               {printf("New variable\n");$$ = setNext($1,$2);}
        | 	MethodDecl field_or_method_declaration              {printf("New Method\n"); $$ = setNext($1,$2);}
        |                                                           {printf("No more stuff\n");$$ = NULL;};

FieldDecl :
                STATIC VarDecl      {printf("static var\n"); $$ = setStatic($2);};

MethodDecl :
                PUBLIC STATIC method_type_declaration ID OCURV FormalParams CCURV OBRACE VarDecl statement_declaration_REPETITION CBRACE        {printf("Create method\n"); $$ = setStatic(newMethod($3,$4,$6,$9,$10));}
        ;

method_type_declaration:
                Type            {$$ = $1;}
        |	VOID            {$$ = TYPE_VOID;};

FormalParams : 
                Type ID several_FormalParams        {printf("FormalParamsOther\n");$$ = newVarDecl($1,$2,NULL,$3);}
        |	STRING OSQUARE CSQUARE ID           {printf("FormalParamsString\n");$$ = newVarDecl(TYPE_STRING_ARRAY,$4,NULL,NULL);}
        |                                           {printf("NoFormalParams\n");$$ = NULL;};

several_FormalParams : 
                COMMA Type ID several_FormalParams      {printf("SeveralFormalParams\n");$$ = newVarDecl($2,$3,NULL,$4);}
        |                                               {printf("No more formal params\n");$$ = NULL;};

VarDecl :
                Type ID several_var_decl_in_same_instructionOPTIONAL SEMIC VarDecl      {printf("new var\n");$$ = newVarDecl($1,$2,$3,$5);}
        |                                                                               {printf("there are no variables\n");$$ = NULL;};

several_var_decl_in_same_instructionOPTIONAL:
                COMMA ID several_var_decl_in_same_instructionOPTIONAL       {printf("several var in same decl ID(%s)\n",$2);$$ = newVarID($2,$3);}
        |                                                                   {$$ = NULL;};

Type :
                INT OSQUARE CSQUARE        {$$ = TYPE_INT_ARRAY;}
       |        BOOL OSQUARE CSQUARE       {$$ = TYPE_BOOL_ARRAY;}
       |        INT                        {$$ = TYPE_INT;}
       |        BOOL                       {$$ = TYPE_BOOL;}
       ;
	




statement_declaration_REPETITION:
                Statement statement_declaration_REPETITION          {$$ = setNext($1,$2);}
        |                                                           {$$ = NULL;}
        ;

Statement : 
                OBRACE several_statement CBRACE                     {}
        |	IF OCURV Expr CCURV Statement %prec IFX             {$$ = insertIf($3,$5,NULL);}
        |	IF OCURV Expr CCURV Statement ELSE Statement        {$$ = insertIf($3, $5, $7);}
        |	WHILE OCURV Expr CCURV Statement                    {}
        |	PRINT OCURV Expr CCURV SEMIC                        {}
        |	ID array_indexOPTIONAL ASSIGN Expr SEMIC            {}
        |	RETURN return_expression SEMIC                      {$$ = setAsReturn($2);}
        ;

several_statement:
                Statement several_statement     {$$ = setNext($1,$2);}
        |                                       {$$ = NULL;}
        ;

array_indexOPTIONAL:
                OSQUARE Expr CSQUARE        {}
        |                                   {$$ = NULL;}
        ;

return_expression : 
                Expr    {}
        |               {$$ = NULL;};

IndexableExpr: 
                ID                                                  {}
        |	INTLIT                                              {}
        |	BOOLLIT                                             {}
        |	ID OCURV Args_OPTIONAL CCURV                        {}
        |	OCURV Expr CCURV                                    {}
        |	Expr DOTLENGTH                                      {}
        |	IndexableExpr OSQUARE Expr CSQUARE                  {}
        |	PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV        {};

Expr : 
                Expr operations Expr %prec OPS_FTW      {}
        |	OP3 Expr %prec OPS_FTW                  {}
        |	NOT Expr %prec OPS_FTW                  {}
        |	NEW INT OSQUARE Expr CSQUARE            {}
        |	NEW BOOL OSQUARE Expr CSQUARE           {}
        |	IndexableExpr                           {};


operations:
                OP1     {}
        |	OP2     {}
        |	OP3     {}
        |	OP4     {};

Args_OPTIONAL:
                Args    {}
        |               {$$ = NULL;};

Args:
                Expr comma_expr     {};

comma_expr: 
                COMMA Expr comma_expr       {}
        |                                   {$$ = NULL;};


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

        if(printTree)
            show_program(program);
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
