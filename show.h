#ifndef _SHOW_
#define _SHOW_
#include "structures.h"

/* Falta o StoreArray e While a seguir ao Store */
static const char *NODE_STRING[] = {
                 "Program",
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
                 "ParseArgs"
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
