#ifndef _SHOW_
#define _SHOW_
#include "structures.h"




static const char *NODE_STRING[] = {"Program",
                 "VarDecl",
                 "MethodDecl",
                 "MethodParams",
                 "MethodBody",
                 "ParamDeclaration",
                 "CompoundStat",
                 "IfElse",
                 "Print",
                 "Return",
                 "Store",
                 "Mul",
                 "Div",
                 "Mod",
                 "Not",
                 "Minus",
                 "Plus",
                 "Length",
                 "LoadArray",
                 "Call",
                 "NewInt",
                 "NewBool",
                 "ParseArgs",
                 "While",
                 "StoreArray",
                 "IntLit",
                 "BoolLit",
                 "NODE_ID",
                 "NODE_AND",
                 "NODE_OR",
                 "NODE_LESS",
                 "NODE_GREATER",
                 "NODE_LESSEQUAL",
                 "NODE_GREATEREQUAL",
                 "NODE_DIFFERENT",
                 "NODE_EQUAL"
                    };

static const char* NODE_TYPE_NAMES[] = {     "Void",     "Int",     "Bool",
"IntArray",     "BoolArray",     "StringArray",     "Id",     "IntLit",
"BoolLit",     "BoolArray", };

void printStore ( Node* currentNode , int tabs);
void printAST(Node* AST);
void printIDs(listID* ids,int tabs, int n_type, int type);
void printSubTree(Node* currentNode, int tabs);

#endif
