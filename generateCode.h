#ifndef _CODE_GEN_
#define _CODE_GEN_
#define DEBUG 0


static const char* SYMBOLS_TYPE_SIZE[] = {     "void",     "i32",     "i1",
"i32*",     "i1*",     "i8*",     "Id",     "i32",
"i1",     "i1*",  };

static const char *CODE_OPERATOR_STRING[] = {"Program",
                 "VarDecl",
                 "MethodDecl",
                 "MethodParams",
                 "MethodBody",
                 "ParamDeclaration",
                 "CompoundStat",
                 "if",
                 "System.out.println",
                 "return",
                 "=",
                 "mul",
                 "sdiv",
                 "%",
                 "!",
                 "sub",
                 "add",
                 ".length",
                 "[",
                 "call",
                 "new int",
                 "new boolean",
                 "Integer.parseInt",
                 "while",
                 "=",
                 "IntLit",
                 "BoolLit",
                 "Id",
                 "&&",
                 "||",
                 "slt",
                 "sgt",
                 "sle",
                 "sge",
                 "ne",
                 "eq",
                 "null",
                 "+",
                 "-"
                 };

char* generateCode(Node* ast,Table* main);

typedef struct _callP{
    Type type;
    char name[100];
    struct _callP* next;
}callParams;

#endif
