#ifndef _STRUCTURES_
#define _STRUCTURES_

#include "structures.h"

/**is_expression_list* insert_expression_list(is_expression_list*, is_expression*);
is_expression* insert_i_expression(is_infix_expression*);
is_expression* insert_u_expression(is_unary_expression*);
is_expression* insert_NUMBER(int);
is_infix_expression* insert_infix_expression(is_expression*, is_oper, is_expression*);
is_unary_expression* insert_unary_expression(is_expression*);*/

typedef enum {} NodeType;
typedef enum {TYPE_VOID, TYPE_INT, TYPE_BOOL, TYPE_INT_ARRAY, TYPE_BOOL_ARRAY, TYPE_STRING_ARRAY} Type;


//Lista de IDs (para multiplas declarações de variaveis)
typedef struct _idList
{
	char* id;
	struct _idList* next;
} listID;

//General Node
typedef struct _Node
{
	NodeType n_type;
	Type type;
	listID id;
	struct _Node* n1;
	struct _Node* n2;
	struct _Node* n3;

	struct _Node* next;
}Node;

#endif




