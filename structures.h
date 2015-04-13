#ifndef _STRUCTURES_
#define _STRUCTURES_
#define DEBUG 0

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
              NODE_PARSEARGS,
              NODE_WHILE,
              NODE_STOREARRAY,
              NODE_INTLIT,
              NODE_BOOLLIT,
              NODE_ID,
              NODE_AND,
              NODE_OR,
              NODE_LESS,
              NODE_GREATER,
              NODE_LESSEQUAL,
              NODE_GREATEREQUAL,
              NODE_DIFFERENT,
              NODE_EQUAL,
              NODE_NULL,
              NODE_UNARYPLUS,
              NODE_UNARYMINUS,
              NODE_DONTPRINT
             } NodeType;

typedef enum {TYPE_VOID, TYPE_INT, TYPE_BOOL, TYPE_INT_ARRAY, TYPE_BOOL_ARRAY, TYPE_STRING_ARRAY} Type;

typedef enum {TABLE_CLASS, TABLE_METHOD, TABLE_DECL, TABLE_RETURN} TableType;

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

    //Type of the struct (int, void, string,...)
	Type type;

    //id or list of ids
    listID* id;

    //the tree next nodes (for if and stuff)
    struct _Node* n1;
    struct _Node* n2;
    struct _Node* n3;

    //the next node
    struct _Node* next;

    //for the literals (to store the values)
    char* value;

    char isStatic;
}Node;

typedef struct _TableNode
{
    //Type of the Node (to identify the tipe of the node)
    TableType n_type;
    //Type of the struct (int, void, string,...)
    Type type;
    //id or list of ids
    listID* id;
    //the next node
    struct _TableNode* next;
    //if is a param
    char isParam;
}TableNode;

typedef struct _Table{
    TableNode* table;
    struct _Table* next;
}Table;

listID* insertID(Node* currentNode, char* id);
listID* newVarID(char* id, listID* next);
NodeType getOperatorType(char* op);
Node* createNull();
Node* insertClass(char* id, Node* statements);
Node* newVarDecl(int type, char* id, listID* moreIds, Node* next);
Node* setNext(Node* current, Node* next);
Node* setStatic(Node* currentNode);
Node* newMethod(int type, char* id, Node* params, Node* varDecl, Node* statements);
Node* insertCompound(Node* expression);
Node* insertIf(Node* expression, Node* statement1, Node* statement2);
Node* insertPrint(Node* expression);
Node* insertWhile(Node* expression, Node* statements);
Node* insertReturn(Node* expression);
Node* insertStore(char* id, Node* arrayIndex, Node* expression);
Node* createTerminalNode(int n_type, char* token);
Node* newParamDecl(int type, char* id, listID* moreIds, Node* next);
Node* insertDotLength(Node* expression);
Node* insertLoadArray(Node* expression, Node* indexExpression);
Node* insertParseInt(char* id, Node* indexExpression);
Node* insertNewArray(int type, Node* expression);
Node* createCall(char* id, Node *args);
Node* insertExpression(char* op,Node* exp);
Node* insertDoubleExpression(Node* exp1,char* op,Node* exp2);

TableNode* addNewDeclTable(char isparam, TableNode* symbol, Node* ast,Table* table);
Table* createSymbols(Node* ast);


void checkIfExists(char* id, Table* local);
void checkSemanticErrors(Node* ast, Table* local, Table* main);
void checkErrors(Node* ast, Table* symbols, Table* main);
int checkifIDExists(char* id,TableType type, Table* table, Table* main);
Table* getMethodTable(Table* main, char* methodID);
void validIntLit(char* lit);
void checkTypes(Node* ast,Table* main);
void operatorError2Types(int op,int n1, int n2);
void operatorError1Types(int op,int n1);
void assignmentError(char* var, int n1, int n2);
void assignmentErrorArray(char* var, int n1, int n2);
void setTable(Table * oi);
int getFunctionType();
void statementError(int op, int n1,int n2);
void statementError1oranother(int op, int n1, int n2, int n3);
char* getFunctionName();
void getErrorCall(int i,char* name, int n1, int n2);

#endif




                        \                           |\                                      \\|
