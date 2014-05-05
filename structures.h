#ifndef _STRUCTURES_
#define _STRUCTURES_


#define FALSE 0
#define TRUE !FALSE

typedef enum {NODE_PROGRAM,
             NODE_VARDECL,
             NODE_METHODDECL,
             NODE_METHODPARAMS,
             NODE_METHODBODY,
             NODE_PARAMDECL,
             NODE_COMPOUNDSTAT,
             NODE_IFELSE,
             NODE_PRINT,
             NODE_RETURN,
             NODE_STORE,
             NODE_MUL,
             NODE_DIV,
             NODE_MOD,
             NODE_NOT,
             NODE_MINUS,
             NODE_PLUS,
             NODE_LENGTH,
             NODE_LOADARRAY,
             NODE_CALL,
             NODE_NEWINT,
             NODE_NEWBOOL,
             NODE_PARSEARGS} NodeType;

typedef enum {TYPE_VOID, TYPE_INT, TYPE_BOOL, TYPE_INT_ARRAY, TYPE_BOOL_ARRAY, TYPE_STRING_ARRAY} Type;


//LinkList de IDs (para multiplas declarações de variaveis)
typedef struct _idList
{
	char* id;
	struct _idList* next;
} listID;

//General Node
typedef struct _Node
{
    //Type of the Node (to identify the tipe of the node)
	NodeType n_type;

    //Type of the struct (int, void, string)
	Type type;

    //id or list of ids
    listID* id;

    //the tree next nodes (for if and stuff)
    struct _Node* n1;
	struct _Node* n2;
	struct _Node* n3;

    //the next node
	struct _Node* next;
    char isStatic;
}Node;

listID* insertID(Node* currentNode, char* id);
Node* insertClass(char* id, Node* statements);
listID* newVarID(char* id, listID* next);
Node* newVarDecl(int type, char* id, listID* moreIds, Node* next);
Node* setNext(Node* current, Node* next);
Node* setStatic(Node* currentNode);
Node* newMethod(int type, char* id, Node* params, Node* varDecl, Node* statements);
Node* insertIf(Node* expression, Node* statement1, Node* statement2);
#endif




