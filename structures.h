#ifndef _STRUCTURES_
#define _STRUCTURES_

#include "structures.h"

/**is_expression_list* insert_expression_list(is_expression_list*, is_expression*);
is_expression* insert_i_expression(is_infix_expression*);
is_expression* insert_u_expression(is_unary_expression*);
is_expression* insert_NUMBER(int);
is_infix_expression* insert_infix_expression(is_expression*, is_oper, is_expression*);
is_unary_expression* insert_unary_expression(is_expression*);*/


typedef enum {TYPE_VOID, TYPE_INT, TYPE_BOOL, TYPE_INT_ARRAY, TYPE_BOOL_ARRAY, TYPE_STRING_ARRAY} Type;








//Lista de IDs (para multiplas declarações de variaveis)
typedef struct _idList
{
	char* id;
	struct _idList* next;
} listID;

	
//VarDecl(>=2): ( <type> Id {Id} )
typedef struct _varldecl
{
    Type type;
	listID id;
} varDecl;

//MethodBody(>=0): 	( { VarDecl | <statements> } )
typedef struct _methBodydecl
{
    varDecl* 		vars;
	//TODO:: STATEMENTS
} methodBody;

//ParamDeclaration(2):( ( <type> | StringArray ) Id )
typedef struct _paramdecl
{
	Type 			type;
	char*			id;
	struct _paramdecl* next;
} paramDecl;

//MethodParams(>=0): 	( { ParamDeclaration } )
typedef struct _methparamsdecl
{
    Type 			type;
    char* 			id;
	paramDecl* 		params;
	methodBody* 	body;
} methodParams;

//MethodDecl(4): 	( { <type> | Void ) Id MethodParams MethodBody))
typedef struct _methdecl
{
    Type 			type;
    char* 			id;
	methodParams* 	methods;
	methodBody* 	body;
} methodDecl;

//Lista de declaração de variaveis ou de metodos (union permite ser um ou outro)
typedef struct _declList
{
    Type type;
	union
	{
		varDecl* varDecl;
		methodDecl* methodDecl;
	};
    struct _declList* next;
} listDecl;

//Program(>=1): ( Id { VarDecl | MethodDecl} )
typedef struct _class{
	char* id;
	listDecl* decl;
} Class;

#endif




