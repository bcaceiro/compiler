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

/* Method to create an Id (a) */
listID* insertID(Node* currentNode, char* id);
/* Method to create a new VarId (int a,b,c (to link a to b to c)) */
listID* newVarID(char* id, listID* next);
/* Method to get an operator type (NODE_PLUS; NODE_NOT,...) */
NodeType getOperatorType(char* op);
/* Method to create a Null Node, used for mandatory child Nodes */
Node* createNull();
/* Method to create the Program itself (class gcd) */
Node* insertClass(char* id, Node* statements);
/* Method to create a new VarDecl (int a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r;)*/
Node* newVarDecl(int type, char* id, listID* moreIds, Node* next);
/* Method to link nodes */
Node* setNext(Node* current, Node* next);
/* Method to set a Node static */
Node* setStatic(Node* currentNode);
/* Creates a New Method Declaration Node:
    public static void cenas(){statement1; statement2;return;} */
Node* newMethod(int type, char* id, Node* params, Node* varDecl, Node* statements);
/* Creates a Compound Node ({ expression1;expression2}) */
Node* insertCompound(Node* expression);
/* Creates an If node (if(true)) */
Node* insertIf(Node* expression, Node* statement1, Node* statement2);
/* Creates a Print Node (System.out.println("blica"))*/
Node* insertPrint(Node* expression);
/* Creates a While Node (while(true)) */
Node* insertWhile(Node* expression, Node* statements);
/* Creates a Return Node (return;  return true;)*/
Node* insertReturn(Node* expression);
/* Creates a Store Node (a = 5, b[5] = true) */
Node* insertStore(char* id, Node* arrayIndex, Node* expression);
/* Creates a Terminal Node (a, 5, true, false) */
Node* createTerminalNode(int n_type, char* token);
/* Creates a New Param Declaration Node (String[] argv, int a) */
Node* newParamDecl(int type, char* id, listID* moreIds, Node* next);
/* Creates a .length Node (argv.length) */
Node* insertDotLength(Node* expression);
/* Creates a Load Array Node (c[1]) */
Node* insertLoadArray(Node* expression, Node* indexExpression);
/* Creates a parse int Node (Integer.parseInt(argv[1])) */
Node* insertParseInt(char* id, Node* indexExpression);
/* Creates a new array Node (new int[1]) */
Node* insertNewArray(int type, Node* expression);
/* Creates a Method Call (teste(a,b)) */
Node* createCall(char* id, Node *args);
/* Creates an unary expression ( !true; -1;...)*/
Node* insertExpression(char* op,Node* exp);
/* Creates an binary expression  ( 1 + 1; true != false; a < b) */
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




