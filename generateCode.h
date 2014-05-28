#ifndef _CODE_GEN_
#define _CODE_GEN_
#define DEBUG 0


static const char* SYMBOLS_TYPE_SIZE[] = {     "void",     "i32",     "i1",
"i32*",     "i1*",     "i8*",     "Id",     "i32",
"i1",     "i1*",  };

void generateCode(Node* ast);

#endif
