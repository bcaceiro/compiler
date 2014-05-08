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
                 "Add",
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
                 "Id",
                 "And",
                 "Or",
                 "Lt",
                 "Gt",
                 "Leq",
                 "Geq",
                 "Neq",
                 "Eq",
                 "Null"
                    };

static const char* NODE_TYPE_NAMES[] = {     "Void",     "Int",     "Bool",
"IntArray",     "BoolArray",     "StringArray",     "Id",     "IntLit",
"BoolLit",     "BoolArray", };

void printStore ( Node* currentNode , int tabs);
void printAST(Node* AST);
void printIDs(listID* ids,int tabs, int n_type, int type);
void printSubTree(Node* currentNode, int tabs);

#endif
