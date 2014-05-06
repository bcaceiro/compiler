#ifndef _SHOW_
#define _SHOW_
#include "structures.h"

static const char *NODE_STRING[] = {
                 "Program",
                 "VarDecl",
                 "MethodDecl",
                 "NODE_METHODPARAMS",
                 "NODE_METHODBODY",
                 "NODE_PARAMDECL",
                 "NODE_COMPOUNDSTAT",
                 "NODE_IFELSE",
                 "NODE_PRINT",
                 "NODE_RETURN",
                 "Store",
                 "NODE_MUL",
                 "NODE_DIV",
                 "NODE_MOD",
                 "NODE_NOT",
                 "NODE_MINUS",
                 "NODE_PLUS",
                 "NODE_LENGTH",
                 "NODE_LOADARRAY",
                 "NODE_CALL",
                 "NODE_NEWINT",
                 "NODE_NEWBOOL",
                 "NODE_PARSEARGS",
                 "NODE_WHILE"
};
void show_program(Node*);
void printIDs(listID* ids, int tabs);
/*void show_expression(is_expression*);
void show_infix_expression(is_infix_expression*);
void show_unary_expression(is_unary_expression*);
void show_operator(is_oper);
void printSymbols(ClassTable* table);*/
#endif
