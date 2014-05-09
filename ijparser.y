%{
#include <stdio.h>
#include <string.h>

#include "show.h"
//#include "show.c"
#include "structures.h"
//#include "functions.c"

#define DEBUG 0

void yyerror(char *var);

//Lex variables
extern int column;
extern int yylineno;
extern char* yytext;
extern int yyleng;

//program tree
Node* program = NULL;
char Error;

//simbol tree
Table* symbols = NULL;

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
%type<node> Args_OPTIONAL
%type<node> Args
%type<node> comma_expr
%type<node> VarDecl_REPETITION


%token <token> INTLIT BOOLLIT INT BOOL NEW IF ELSE WHILE PRINT PARSEINT CLASS PUBLIC STATIC VOID STRING DOTLENGTH RETURN OCURV CCURV OBRACE CBRACE OSQUARE CSQUARE OP1 OP1OR OP2 OP2EQS OP3 OP4 NOT ASSIGN SEMIC COMMA RESERVED ID



%nonassoc IFX
%nonassoc ELSE


/*
        |       OP1OR   {$$ = $1;   /*||}
        |       OP1     {$$ = $1;   /*&&}
        |       OP2EQS  {$$ = $1;   /*("=="|"!="};
        |	OP2     {$$ = $1;   /*"<"|">"|"<="|">="}
        |	OP3     {$$ = $1;   /*"+"|"-"}
        |	OP4     {$$ = $1;   /*"*"|"/"|"%}
*/

%left OP1OR
%left OP1
%left OP2EQS
%left OP2
%left OP3
%left OP4
%right NOT
%left OSQUARE DOTLENGTH


%% 

Start :
                CLASS ID OBRACE field_or_method_declaration CBRACE          {if(DEBUG)printf("New class\n");$$ = insertClass($2,$4);program = $$;}
        ;

field_or_method_declaration :
                FieldDecl field_or_method_declaration               {if(DEBUG)printf("New variable\n");$$ = setNext($1,$2);}
        | 	MethodDecl field_or_method_declaration              {if(DEBUG)printf("New Method\n"); $$ = setNext($1,$2);}
        |                                                           {if(DEBUG)printf("No more stuff\n");$$ = NULL;};

FieldDecl :
                STATIC VarDecl VarDecl_REPETITION    {if(DEBUG)printf("static var\n"); $$ = setStatic($2);$$ = setNext($2,$3);};

MethodDecl :
                PUBLIC STATIC method_type_declaration ID OCURV FormalParams CCURV OBRACE VarDecl_REPETITION statement_declaration_REPETITION CBRACE        {if(DEBUG)printf("Create method\n"); $$ = setStatic(newMethod($3,$4,$6,$9,$10));}
        ;

method_type_declaration:
                Type            {$$ = $1;}
        |	VOID            {$$ = TYPE_VOID;};

FormalParams : 
                Type ID several_FormalParams        {if(DEBUG)printf("FormalParamsOther\n");$$ = newParamDecl($1,$2,NULL,$3);}
        |	STRING OSQUARE CSQUARE ID           {if(DEBUG)printf("FormalParamsString\n");$$ = newParamDecl(TYPE_STRING_ARRAY,$4,NULL,NULL);}
        |                                           {if(DEBUG)printf("NoFormalParams\n");$$ = NULL;};

several_FormalParams : 
                COMMA Type ID several_FormalParams      {if(DEBUG)printf("SeveralFormalParams\n");$$ = newParamDecl($2,$3,NULL,$4);}
        |                                               {if(DEBUG)printf("No more formal params\n");$$ = NULL;};

VarDecl_REPETITION:
                VarDecl VarDecl_REPETITION      {$$ = setNext($1,$2);}
         |                                      {$$ = NULL;};

VarDecl :
                Type ID several_var_decl_in_same_instructionOPTIONAL SEMIC      {if(DEBUG)printf("new var\n");$$ = newVarDecl($1,$2,$3,NULL);}
        ;

several_var_decl_in_same_instructionOPTIONAL:
                COMMA ID several_var_decl_in_same_instructionOPTIONAL       {if(DEBUG)printf("several var in same decl ID(%s)\n",$2);$$ = newVarID($2,$3);}
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
                OBRACE several_statement CBRACE                     {$$ = insertCompound($2);}
        |	IF OCURV Expr CCURV Statement %prec IFX             {$$ = insertIf($3,$5,NULL);}
        |	IF OCURV Expr CCURV Statement ELSE Statement        {$$ = insertIf($3, $5, $7);}
        |	WHILE OCURV Expr CCURV Statement                    {$$ = insertWhile($3,$5);}
        |	PRINT OCURV Expr CCURV SEMIC                        {$$ = insertPrint($3);}
        |	ID array_indexOPTIONAL ASSIGN Expr SEMIC            {$$ = insertStore($1,$2,$4);}
        |	RETURN return_expression SEMIC                      {$$ = insertReturn($2);}
        ;

several_statement:
                Statement several_statement     {$$ = setNext($1,$2);}
        |                                       {$$ = NULL;}
        ;

array_indexOPTIONAL:
                OSQUARE Expr CSQUARE        {$$ = $2;}
        |                                   {$$ = NULL;}
        ;

return_expression : 
                Expr    {$$ = $1;}
        |               {$$ = NULL;};

IndexableExpr: 
                ID                                                  {$$ = createTerminalNode(NODE_ID,$1);}
        |	INTLIT                                              {$$ = createTerminalNode(NODE_INTLIT,$1);}
        |	BOOLLIT                                             {$$ = createTerminalNode(NODE_BOOLLIT,$1);}
        |	ID OCURV Args_OPTIONAL CCURV                        {$$ = createCall($1,$3);}
        |	OCURV Expr CCURV                                    {$$ = $2;}
        |	Expr DOTLENGTH                                      {$$ = insertDotLength($1);}
        |	IndexableExpr OSQUARE Expr CSQUARE                  {$$ = insertLoadArray($1,$3);}
        |	PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV        {$$ = insertParseInt($3,$5);};

Expr : 
                Expr OP1 Expr %prec OP1                 {$$ = insertDoubleExpression($1,$2,$3);}
        |       Expr OP1OR Expr %prec OP1OR             {$$ = insertDoubleExpression($1,$2,$3);}
        |       Expr OP4 Expr %prec OP4                 {$$ = insertDoubleExpression($1,$2,$3);}
        |       Expr OP3 Expr %prec OP3                 {$$ = insertDoubleExpression($1,$2,$3);}
        |       Expr OP2 Expr %prec OP2                 {$$ = insertDoubleExpression($1,$2,$3);}
        |       Expr OP2EQS Expr %prec OP2EQS           {$$ = insertDoubleExpression($1,$2,$3);}
        |	OP3 Expr %prec NOT                      {$$ = insertExpression($1,$2);}
        |	NOT Expr %prec NOT                      {$$ = insertExpression($1,$2);}
        |	NEW INT OSQUARE Expr CSQUARE            {$$ = insertNewArray(NODE_NEWINT,$4);}
        |	NEW BOOL OSQUARE Expr CSQUARE           {$$ = insertNewArray(NODE_NEWBOOL,$4);}
        |	IndexableExpr                           {$$ = $1;};

Args_OPTIONAL:
                Args    {$$ = $1;}
        |               {$$ = NULL;};

Args:
                Expr comma_expr     {$$ = setNext($1,$2);};

comma_expr: 
                COMMA Expr comma_expr       {$$ = setNext($2,$3);}
        |                                   {$$ = NULL;};

%%

int main(int argc, char *argv[]){
        int i, printTree, pSymbols;
        Error = 0;
        yyparse();

	
        printTree = pSymbols = 0;
	for(i=0; i < argc; i++)
	{
		//caso a flag -s esteja presente
		if(strcmp(argv[i], "-s") == 0)
		{
                        pSymbols = 1;
		}
		//caso a flag -t esteja presente
		else if(strcmp(argv[i], "-t") == 0)
		{
			printTree = 1;
		}
	}
        if(Error)
            return 0;
        if(printTree)
            printAST(program);
        if(pSymbols){
            symbols = createSymbols(program);
            printSymbols(symbols);


        }
	//TODO:LIMPAR MEMÓRIA???
		
    return 0;
}

void yyerror (char *var) {
        printf ("Line %d, col %d: %s: %s\n",yylineno, (int)(column-strlen(yytext)), var, yytext);
        Error = 1;
}
