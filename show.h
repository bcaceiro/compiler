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
                 "Sub",
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
                 "Null",
                 "Plus",
                 "Minus"
                 };

static const char* NODE_TYPE_NAMES[] = {     "Void",     "Int",     "Bool",
"IntArray",     "BoolArray",     "StringArray",     "Id",     "IntLit",
"BoolLit",     "BoolArray", };

static const char* SYMBOLS_TYPE_NAMES[] = {     "void",     "int",     "boolean",
"int[]",     "boolean[]",     "String[]",     "Id",     "IntLit",
"BoolLit",     "BoolArray", };

void printAST(Node* AST);
void printIDs(listID* ids,int tabs, int n_type, int type);
void printSubTree(Node* currentNode, int tabs);
void printSymbols(Table* table);
void printSymbolsDecl(TableNode* tableNode);


#endif
