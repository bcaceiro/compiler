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
                 "NODE_ID"
                    };
void printAST(Node* AST);
void printIDs(listID* ids, int tabs);
/*void show_expression(is_expression*);
void show_infix_expression(is_infix_expression*);
void show_unary_expression(is_unary_expression*);
void show_operator(is_oper);
void printSymbols(ClassTable* table);*/
#endif
