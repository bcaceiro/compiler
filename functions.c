#ifndef _FUNCTIONS_
#define _FUNCTIONS_
#include "structures.h"
#include "show.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
Node* nullNode = NULL;
Table* tabelafofinha = NULL;

Node* createNull(){
    if(nullNode == NULL){
        Node* newNull = (Node*) malloc(sizeof(Node));
        if(newNull==NULL){
            if(DEBUG)printf("DEU MERDA malloc insertClass\n");
            assert(newNull!=NULL);
        }

        //set the node type
        newNull->n_type = NODE_NULL;
        newNull->n1 = NULL;
        newNull->n2 = NULL;
        newNull->n3 = NULL;
        newNull->next = NULL;
        nullNode = newNull;
        return newNull;
    }
    return nullNode;
}

Node* setStatic(Node* currentNode){
    if(currentNode==NULL){
        return currentNode;
    }
    currentNode->isStatic = TRUE;
    return currentNode;
}

listID* insertID(Node* currentNode, char* id){
    if(DEBUG)printf("InsertingID\n\n");
    //just to be safe
    if(currentNode==NULL){
        if(DEBUG)printf("NODE NULL insertID\n");
        assert(currentNode!=NULL);
    }
    listID* tmp;
    //create the new Node of the arrayList
    tmp = (listID*) malloc(sizeof(listID));
    if (tmp != NULL){
        //replace the current ID for the nextOne;
        tmp->id  = id;
        tmp->next = currentNode->id;
        currentNode->id = tmp;
    }
    else{
        if(DEBUG)printf("DEU MERDA malloc insertID\n");
        assert(tmp!=NULL);
    }
    return tmp;
}

Node* insertClass(char* id, Node* statements){
    if(DEBUG)printf("Inserting Class (%s) \n\n",id);
    Node* newClass = (Node*) malloc(sizeof(Node));
    if(newClass==NULL){
        if(DEBUG)printf("DEU MERDA malloc insertClass\n");
        assert(newClass!=NULL);
    }

    //set the node type
    newClass->n_type = NODE_PROGRAM;
    newClass->id = insertID(newClass, id);
    newClass->next = statements;
    return newClass;
}

listID* newVarID(char* id, listID* next){
    listID* tmp;
    if(id==NULL){
        if(DEBUG)printf("DEU MERDA malloc newVarID\n");
        assert(id!=NULL);
    }
    tmp = (listID*) malloc(sizeof(listID));
    if (tmp != NULL){
        //replace the current ID for the nextOne;
        tmp->id  = id;
        tmp->next = next;
    }
    else{
        if(DEBUG)printf("DEU MERDA malloc newVarID\n");
        assert(tmp!=NULL);
    }
    return tmp;
}

Node* newVarDecl(int type, char* id, listID* moreIds, Node* next){
    if(DEBUG)printf("Inserting newVarDecl (%s)\n",id);
    Node* newVar = (Node*) malloc(sizeof(Node));
    if(newVar==NULL){
        if(DEBUG)printf("DEU MERDA malloc insertClass\n");
        assert(newVar!=NULL);
    }

    //set the node type
    newVar->n_type = NODE_VARDECL;
    newVar->type = (Type)type;
    newVar->id = newVarID(id, moreIds);
    newVar->next = next;
    return newVar;
}

Node* newParamDecl(int type, char* id, listID* moreIds, Node* next){
    Node* newParam;
    newParam = newVarDecl(type,id,moreIds,next);
    if(DEBUG)printf("Inserting newVarDecl (%s)\n",id);
    newParam->n_type = NODE_PARAMDECL;
    return newParam;
}


Node* newMethod(int type, char* id, Node* params, Node* varDecl, Node* statements){
    if(DEBUG)printf("Inserting New method(%s)\n",id);
    Node* tmp;
    Node* newMethod = (Node*) malloc(sizeof(Node));
    if(newMethod==NULL){
        if(DEBUG)printf("DEU MERDA malloc insertClass\n");
        assert(newMethod!=NULL);
    }

    //set the node type
    newMethod->n_type = NODE_METHODDECL;
    newMethod->type = type;
    newMethod->id = insertID(newMethod, id);
    //printf("Creating method!!!params : %p\n",params);
    tmp = (Node*) malloc(sizeof(Node));
    assert(tmp!=NULL);
    tmp->n_type = NODE_METHODPARAMS;
    newMethod->n1 = tmp;
    tmp->n1 = params;

    //printf("Creating method!!!vardecl:%p\n",varDecl);
    tmp = (Node*) malloc(sizeof(Node));
    assert(tmp!=NULL);
    tmp->n_type = NODE_METHODBODY;
    newMethod->n2 = tmp;
    tmp->n1 = varDecl;
/*    if(params == NULL)
        newMethod->n1 = createNull();
    if(varDecl == NULL)
        newMethod->n2 = createNull();
    if(statements == NULL)
        newMethod->n3 = createNull();*/
    tmp = (Node*) malloc(sizeof(Node));
    assert(tmp!=NULL);
    tmp->n_type = NODE_DONTPRINT;
    newMethod->n3 = tmp;
    tmp->n1 = statements;

    newMethod->next = NULL;
    return newMethod;
}



Node* setNext(Node* current, Node* next){
    if(current == NULL)
        return next;
    else{
        current->next = next;
        return current;
    }
}

Node* insertIf(Node* expression, Node* statement1, Node* statement2 ) {
    Node* insertIf = (Node*) malloc(sizeof(Node));
    if(insertIf == NULL) {
        if(DEBUG)printf("DEU MERDA MALLOC insertIf\n");
        assert(insertIf != NULL);
    }     

    insertIf->n_type = NODE_IFELSE;
    insertIf->n1     = expression;
    insertIf->n2     = statement1;
    insertIf->n3     = statement2;
    insertIf->next   = NULL;
    if(expression == NULL)
        insertIf->n1 = createNull();
    if(statement1 == NULL)
        insertIf->n2 = createNull();
    if(statement2 == NULL)
        insertIf->n3 = createNull();

    return insertIf;
}

Node* insertCompound(Node* expression){

    if(DEBUG)printf("InsertCompound\n");
    //to check if there is a need for a compound statement
    if(expression == NULL || expression->next == NULL)
        return expression;

    //create a compoundStatement
    Node* newCompound = (Node*) malloc(sizeof(Node));
    if(newCompound==NULL){
        if(DEBUG)printf("DEU MERDA malloc insertCompound\n");
        assert(newCompound!=NULL);
    }
    newCompound->n_type = NODE_COMPOUNDSTAT;
    newCompound->n1 = expression;

    return newCompound;
}

Node* insertWhile(Node* expression, Node* statements){
    Node* newWhile = (Node*) malloc(sizeof(Node));
    if(newWhile==NULL){
        if(DEBUG)printf("DEU MERDA malloc insertCompound\n");
        assert(newWhile!=NULL);
    }

    newWhile->n_type = NODE_WHILE;
    newWhile->n1 = expression;
    newWhile->n2 = statements;
    if(expression == NULL)
        newWhile->n1 = createNull();
    if(statements == NULL)
        newWhile->n2 = createNull();
    newWhile->next   = NULL;

    return newWhile;
}

Node* insertPrint(Node* expression){
    Node* newPrint = (Node*) malloc(sizeof(Node));
    if(newPrint==NULL){
        if(DEBUG)printf("DEU MERDA malloc insertCompound\n");
        assert(newPrint!=NULL);
    }

    newPrint->n_type = NODE_PRINT;
    newPrint->n1 = expression;

    if(expression == NULL)
        newPrint->n1 = createNull();

    newPrint->next   = NULL;

    return newPrint;
}

Node* insertReturn(Node* expression) {
    if(DEBUG)printf("Insert Return\n");
    Node* newReturn = (Node*) malloc(sizeof(Node));

    if(newReturn == NULL){
        if(DEBUG)printf("DEU MERDA malloc insertReturn\n");
        assert(newReturn != NULL);
    }

    newReturn->n_type = NODE_RETURN;

    newReturn->n1 = expression;


    return newReturn;

}

Node* insertStore(char* id, Node* arrayIndex, Node* expression){

    Node* thisNode =  (Node*) malloc(sizeof(Node));
    if(thisNode == NULL){
        if(DEBUG)printf("DEU MERDA malloc insertStore\n");
        assert(thisNode == NULL);
    }

    //insertID(thisNode,id);
    //printf("ID Store(%s)\n",thisNode->id->id);

    thisNode->value = NULL;
    thisNode->n1 = createTerminalNode(NODE_ID,id);

    thisNode->n2 = arrayIndex;
    //printf("lolada2:%s\n",NODE_STRING[expression->n_type]);
    if(arrayIndex!=NULL){
        thisNode->n_type = NODE_STOREARRAY;
        if(arrayIndex == NULL)
            thisNode->n2 = createNull();
    }else
        thisNode->n_type = NODE_STORE;

    thisNode->n3 = expression;
    if(expression == NULL)
        thisNode->n3 = createNull();

    thisNode->next = NULL;

    return thisNode;
}

Node* createTerminalNode(int n_type, char* token){
    if(DEBUG)printf("create Terminal\n");

    Node* newTerminal = (Node*) malloc(sizeof(Node));
    if(newTerminal == NULL){
        if(DEBUG)printf("DEU MERDA malloc insertReturn\n");
        assert(newTerminal != NULL);
    }
    newTerminal->n_type = n_type;
    if(n_type == NODE_INTLIT)
        newTerminal->type = TYPE_INT;
    else if(n_type == NODE_BOOLLIT)
        newTerminal->type = TYPE_BOOL;
    //FIXME POR O ID NO CAMPO id?
    newTerminal->value = token;
    //printf("New terminal:%s\n",token);

    return newTerminal;
}

Node* insertDotLength(Node* expression){
    Node* newDotLength = (Node*) malloc(sizeof(Node));
    if(newDotLength == NULL){
        if(DEBUG)printf("DEU MERDA malloc insertDotLength");
        assert(newDotLength != NULL);
    }
    newDotLength->n_type = NODE_LENGTH;
    newDotLength->n1 = expression;
    if(expression == NULL)
        newDotLength->n1 = createNull();

    newDotLength->next = NULL;
    return newDotLength;
}

Node* insertLoadArray(Node* expression, Node* indexExpression){
    Node* newLoadArray = (Node*) malloc(sizeof(Node));
    if(newLoadArray == NULL){
        if(DEBUG)printf("DEU MERDA malloc insertDotLength");
        assert(newLoadArray != NULL);
    }
    newLoadArray->n_type = NODE_LOADARRAY;
    newLoadArray->n1 = expression;
    newLoadArray->n2 = indexExpression;
    if(expression == NULL)
        newLoadArray->n1 = createNull();
    if(indexExpression == NULL)
        newLoadArray->n2 = createNull();;

    newLoadArray->next = NULL;
    return newLoadArray;
}

Node* insertParseInt(char* id, Node* indexExpression){
    Node* newParseInt = (Node*) malloc(sizeof(Node));
    if(newParseInt == NULL){
        if(DEBUG)printf("DEU MERDA malloc insertDotLength");
        assert(newParseInt != NULL);
    }
    newParseInt->n_type = NODE_PARSEARGS;
    //newParseInt->id = insertID(newParseInt,id);

    newParseInt->n1 = createTerminalNode(NODE_ID,id);


    newParseInt->n2 = indexExpression;
    if(indexExpression == NULL)
        newParseInt->n2 = createNull();

    newParseInt->next = NULL;
    return newParseInt;

}

Node * insertNewArray(int type, Node* expression) {
    Node * newArray = (Node*) malloc (sizeof(Node));
    if(newArray == NULL) {
        if(DEBUG)
            printf("newArray: Error Malloc\n");
        assert(newArray != NULL);
    } 

    newArray-> n_type = type;
    newArray->n1 = expression;
    if(expression == NULL)
        newArray->n1 = createNull();
    if(type == NODE_NEWBOOL)
            newArray->type = TYPE_BOOL_ARRAY;
    if(type == NODE_NEWINT)
            newArray->type = TYPE_INT_ARRAY;
    newArray->next = NULL;
    return newArray;
}

Node* createCall(char* id, Node *args){
    Node * newCall = (Node*) malloc (sizeof(Node));
    if(newCall == NULL) {
        if(DEBUG)
            printf("newCall: Error Malloc\n");
        assert(newCall != NULL);
    }

    newCall-> n_type = NODE_CALL;
    insertID(newCall, id);
    newCall->n1 = args;
    newCall->next = NULL;
    return newCall;
}

Node* insertDoubleExpression(Node* exp1,char* op,Node* exp2){
    Node * newExpression = (Node*) malloc (sizeof(Node));
    if(newExpression == NULL) {
        if(DEBUG)
            printf("newCall: Error Malloc\n");
        assert(newExpression != NULL);
    }

    newExpression-> n_type = getOperatorType(op);
    if(newExpression->n_type == -1 )
        exit(-2);
    newExpression->n1 = exp1;
    newExpression->n2 = exp2;
    if(exp1 == NULL)
        newExpression->n1 = createNull();
    if(exp2 == NULL)
        newExpression->n2 = createNull();

    newExpression->next = NULL;
    return newExpression;

}

Node* insertExpression(char* op,Node* exp){
    Node * newExpression = (Node*) malloc (sizeof(Node));
    if(newExpression == NULL) {
        if(DEBUG)
            printf("newCall: Error Malloc\n");
        assert(newExpression != NULL);
    }
    newExpression->n_type = getOperatorType(op);
    if(newExpression->n_type == -1 )
        exit(-2);

    if(newExpression->n_type == NODE_PLUS)
        newExpression->n_type = NODE_UNARYPLUS;
    if(newExpression->n_type == NODE_MINUS)
        newExpression->n_type = NODE_UNARYMINUS;
    newExpression->n1 = exp;
    if(exp == NULL)
        newExpression->n1 = createNull();

    newExpression->next = NULL;
    return newExpression;

}

NodeType getOperatorType(char* op){
    if(strcmp(op, "&&") == 0)
        return NODE_AND;
    else if(strcmp(op, "||") == 0)
        return NODE_OR;
    else if(strcmp(op, "<") == 0)
        return NODE_LESS;
    else if(strcmp(op, ">") == 0)
        return NODE_GREATER;
    else if(strcmp(op, "<=") == 0)
        return NODE_LESSEQUAL;
    else if(strcmp(op, ">=") == 0)
        return NODE_GREATEREQUAL;
    else if(strcmp(op, "!=") == 0)
        return NODE_DIFFERENT;
    else if(strcmp(op, "==") == 0)
        return NODE_EQUAL;
    else if(strcmp(op, "!") == 0)
        return NODE_NOT;
    else if(strcmp(op, "+") == 0)
        return NODE_PLUS;
    else if(strcmp(op, "-") == 0)
        return NODE_MINUS;
    else if(strcmp(op, "*") == 0)
        return NODE_MUL;
    else if(strcmp(op, "/") == 0)
        return NODE_DIV;
    else if(strcmp(op, "%") == 0)
        return NODE_MOD;

    return -1;
}

Table* createSymbols(Node* ast){

    Table* mainTable = NULL;
    Table* currentTable = NULL;
    Table* tempTable = NULL;
    TableNode* temp = NULL;
    TableNode * symbol = NULL;
    TableNode* auxiliar = NULL;
    Node* aux;

    if(ast!=NULL && ast->n_type == NODE_PROGRAM){
        if(mainTable == NULL){
            //create the table
            mainTable = (Table*) malloc (sizeof(Table));
            assert(mainTable!=NULL);
            //create the TableNode and add it to the table
            temp = (TableNode*) malloc (sizeof(TableNode));
            assert(temp!=NULL);
            temp->n_type = TABLE_CLASS;
            temp->id = ast->id;

            mainTable->table = temp;
            currentTable = mainTable;
            symbol = temp;
        }else{
            assert(mainTable!=NULL);
        }
        ast = ast->next;
    }
    while(ast!=NULL){
        if( ast->n_type == NODE_VARDECL){
            symbol = addNewDeclTable(0, symbol,ast, mainTable);
            ast = ast->next;
        }
        else if( ast->n_type == NODE_METHODDECL){
            //create a local table
            tempTable = (Table*) malloc (sizeof(Table));
            assert(tempTable!=NULL);

            //link it to the old table
            currentTable->next = tempTable;
            currentTable = tempTable;

            checkIfExists(ast->id->id,mainTable);
            //add the method decl to the old table (it must be the mainTable??)
            temp = (TableNode*) malloc (sizeof(TableNode));
            assert(temp!=NULL);
            symbol->next = temp;
            symbol = temp;
            symbol->n_type = TABLE_METHOD;
            symbol->type = ast->type;
            symbol->id = ast->id;
            auxiliar = temp;

            //create the first and the second symbol of the new table
            temp = (TableNode*) malloc (sizeof(TableNode));
            assert(temp!=NULL);
            currentTable->table = temp;
            symbol = temp;
            symbol->n_type = TABLE_METHOD;
            symbol->type = ast->type;
            symbol->id = ast->id;

            //add the params of the method to the method decl
            if(ast->n1->n1!=NULL){
                aux = ast->n1->n1;
                while(aux!=NULL){
                    symbol = addNewDeclTable(1,symbol,aux, currentTable);
                    aux = aux->next;
               }
            }
            //add the decls of the method to the method decl
            if(ast->n2->n1!=NULL){
                aux = ast->n2->n1;
                while(aux!=NULL){
                    symbol = addNewDeclTable(0,symbol,aux, currentTable);
                    aux = aux->next;
                }
            }
            symbol = auxiliar;
            ast = ast->next;
        }
    }
    return mainTable;
}

TableNode* addNewDeclTable(char isparam, TableNode* symbol, Node* ast,Table* table){
    TableNode* temp;
    listID* aux;
    checkIfExists(ast->id->id,table);
    temp = (TableNode*) malloc (sizeof(TableNode));
    assert(temp!=NULL);
    symbol->next = temp;
    symbol = temp;
    symbol->n_type = TABLE_DECL;
    symbol->type = ast->type;
    symbol->id = ast->id;
    symbol->isParam = isparam;
    //if more than a id has been        if() declared in the same line
    if(symbol->id->next!=NULL){
        aux = symbol->id->next;
        while(aux!=NULL){
            checkIfExists(aux->id,table);
            temp = (TableNode*) malloc (sizeof(TableNode));
            assert(temp!=NULL);
            symbol->next = temp;
            symbol = temp;
            symbol->n_type = TABLE_DECL;
            symbol->type = ast->type;
            symbol->id = aux;
            aux = aux->next;
        }
    }
    return temp;
}
//variaveis globais mesmo nome que métodos não pode ter
void checkIfExists(char* id, Table* table){
    //printf("checking %s(where = %s)\n",id,table->table->id->id);
    //
    TableNode* local = table->table->next;
    while(local!=NULL){
        if((local->n_type == TABLE_DECL || local->n_type == TABLE_METHOD) && strcmp(id,local->id->id)==0){
            printf("Symbol %s already defined\n",id);
            exit(0);
        }
        local = local->next;
    }
}

void checkSemanticErrors(Node* ast, Table* local, Table* main){

    if(ast->n_type == NODE_METHODDECL){
        local = getMethodTable(main,ast->id->id);
        setTable(local);
    }

    //ISTO PARECE DEMASIADO PREDREIRO!!!ISTO FUNCIONA SEQUER?
    /*if(ast->n_type == NODE_STORE || ast->n_type == NODE_STOREARRAY)
        checkErrors(ast,local,main);
    */
    if(ast->n1 != NULL){
        checkSemanticErrors(ast->n1, local, main);
    }
    //NODE_2
    if(ast->n2 != NULL){
        checkSemanticErrors(ast->n2, local, main);
    }
    //NODE_3
    if(ast->n3 != NULL){
        checkSemanticErrors(ast->n3, local, main);
    }

    checkErrors(ast,local,main);

    //next Node
    if(ast->next != NULL)
        checkSemanticErrors(ast->next, local, main);

    //ISTO PARECE DEMASIADO PREDREIRO!!!ISTO FUNCIONA SEQUER?
    //if(ast->n_type != NODE_STORE && ast->n_type != NODE_STOREARRAY)

    return;
}

void checkErrors(Node* ast, Table* symbols, Table* main){
    /*if(ast->n_type == NODE_STORE || ast->n_type == NODE_STOREARRAY){
        ast->type = checkifIDExists(ast->n1->value,TABLE_DECL,symbols,main);
    }
    else */
    if(ast->n_type == NODE_CALL){
        ast->type = checkifIDExists(ast->id->id,TABLE_METHOD,symbols,main);
    }
    else if(ast->n_type == NODE_ID){
        ast->type = checkifIDExists(ast->value,TABLE_DECL,symbols,main);
        //printf("dfsdf : %s,%s\n",ast->value,SYMBOLS_TYPE_NAMES[ast->type]);
    }
    /*else if(ast->n_type == NODE_PARSEARGS){
        ast->type = checkifIDExists(ast->id->id,TABLE_DECL,symbols,main);
    }*/
    else if(ast->n_type == NODE_INTLIT){
        validIntLit(ast->value);
    }
    checkTypes(ast,main);

}

//chech it it exists and if exists, it returns the type
int checkifIDExists(char* id,TableType type, Table* table, Table* main){
    TableNode* local = table->table->next;
    while(local!=NULL){
        //printf("ID:%s\n",local->id->id);
        if((local->n_type == type) && strcmp(id,local->id->id)==0){
            return local->type;
        }
        local = local->next;
    }
    local = main->table->next;
    while(local!=NULL){
        //printf("ID:%s\n",local->id->id);
        if((local->n_type == type) && strcmp(id,local->id->id)==0){
            return local->type;
        }
        local = local->next;
    }

    printf("Cannot find symbol %s\n",id);
    exit(0);
}

Table* getMethodTable(Table* main, char* methodID){
    while(main!=NULL){
        if(main->table->n_type == TABLE_METHOD && strcmp(methodID,main->table->id->id)==0)
            return main;
        else
            main = main->next;
   }
   //assert(NULL!=NULL);
   return main;
}

void validIntLit(char* lit){

    //printf("Verify IntLit %s\n",lit);
    int len = strlen(lit);

    //is a decimal
    if(lit[0]!='0')
        return;

    //if it is a hexadecimal
    if(len>0 && lit[1] == 'x')
        return;

    //it is octal
    while(len>0){
        if(lit[len] > '7'){
            printf("Invalid literal %s\n",lit);
            exit(0);
        }
        len--;
    }
    return;
}


void checkTypes(Node* ast, Table *main){

    if(ast->n_type == NODE_GREATER || ast->n_type == NODE_LESS || ast->n_type == NODE_GREATEREQUAL || ast->n_type == NODE_LESSEQUAL ){
        //printf("Cenas:%s(%s) %s(%s)\n",NODE_STRING[ast->n1->n_type],SYMBOLS_TYPE_NAMES[ast->n1->type],NODE_STRING[ast->n2->n_type],SYMBOLS_TYPE_NAMES[ast->n2->type]);
        if(ast->n1->type != TYPE_INT || ast->n2->type != TYPE_INT){
            operatorError2Types(ast->n_type,ast->n1->type,ast->n2->type);
        }
        ast->type = TYPE_BOOL;
    }
    else if(ast->n_type == NODE_PLUS || ast->n_type == NODE_MINUS || ast->n_type == NODE_DIV || ast->n_type == NODE_MUL || ast->n_type == NODE_MOD){
        //printf("Cenas:%s(%s) %s(%s)\n",NODE_STRING[ast->n1->n_type],SYMBOLS_TYPE_NAMES[ast->n1->type],NODE_STRING[ast->n2->n_type],SYMBOLS_TYPE_NAMES[ast->n2->type]);
        if(ast->n1->type != TYPE_INT || ast->n2->type != TYPE_INT){
            operatorError2Types(ast->n_type,ast->n1->type,ast->n2->type);
        }
        ast->type = TYPE_INT;
    }
    else if(ast->n_type == NODE_EQUAL || ast->n_type == NODE_DIFFERENT){
        //printf("Cenas:%s(%s) %s(%s)\n",NODE_STRING[ast->n1->n_type],SYMBOLS_TYPE_NAMES[ast->n1->type],NODE_STRING[ast->n2->n_type],SYMBOLS_TYPE_NAMES[ast->n2->type]);
        if(ast->n1->type != ast->n2->type){
            operatorError2Types(ast->n_type,ast->n1->type,ast->n2->type);
        }
        ast->type = TYPE_BOOL;
    }
    else if(ast->n_type == NODE_AND || ast->n_type == NODE_OR){
        //printf("Cenas:%s(%s) %s(%s)\n",NODE_STRING[ast->n1->n_type],SYMBOLS_TYPE_NAMES[ast->n1->type],NODE_STRING[ast->n2->n_type],SYMBOLS_TYPE_NAMES[ast->n2->type]);
        if(ast->n1->type != TYPE_BOOL || ast->n2->type != TYPE_BOOL){
            operatorError2Types(ast->n_type,ast->n1->type,ast->n2->type);
        }
        ast->type = TYPE_BOOL;
    }
    else if(ast->n_type == NODE_LOADARRAY ){
        //printf("LOADARRAY:%s(%s) %s(%s)\n",NODE_STRING[ast->n1->n_type],SYMBOLS_TYPE_NAMES[ast->n1->type],NODE_STRING[ast->n2->n_type],SYMBOLS_TYPE_NAMES[ast->n2->type]);
        if(ast->n2->type != TYPE_INT || (ast->n1->type != TYPE_BOOL_ARRAY && ast->n1->type != TYPE_INT_ARRAY)){
            operatorError2Types(ast->n_type,ast->n1->type,ast->n2->type);
        }
        if(ast->n1->type == TYPE_INT_ARRAY)
            ast->type = TYPE_INT;
        else if(ast->n1->type == TYPE_BOOL_ARRAY)
            ast->type = TYPE_BOOL;
        else{
            //printf("hsdfsdfsdfsd\n");
            ast->type = ast->n1->type;
        }
    }
    else if( ast->n_type == NODE_NEWINT || ast->n_type == NODE_NEWBOOL ){
        assert(ast->n1!=NULL);
        if(ast->n1->type != TYPE_INT){
            operatorError1Types(ast->n_type,ast->n1->type);
        }
        if(ast->n_type == NODE_NEWINT)
            ast->type = TYPE_INT_ARRAY;
        else
            ast->type = TYPE_BOOL_ARRAY;
    }
    else if( ast->n_type == NODE_LENGTH){
        if((ast->n1->type != TYPE_BOOL_ARRAY && ast->n1->type != TYPE_INT_ARRAY && ast->n1->type != TYPE_STRING_ARRAY)){
            //printf("SOMETHING\n");
            operatorError1Types(ast->n_type,ast->n1->type);
        }
        ast->type = TYPE_INT;
    }
    else if( ast->n_type == NODE_UNARYPLUS || ast->n_type == NODE_UNARYMINUS){
        if((ast->n1->type != TYPE_INT)){
            //printf("SOMETHING\n");
            operatorError1Types(ast->n_type,ast->n1->type);
        }
        ast->type = TYPE_INT;
    }
    else if(ast->n_type == NODE_NOT){
        if((ast->n1->type != TYPE_BOOL)){
            //printf("SOMETHING\n");
            operatorError1Types(ast->n_type,ast->n1->type);
        }
        ast->type = TYPE_BOOL;
    }
    else if( ast->n_type == NODE_PARSEARGS){
        if((ast->n1->type != TYPE_STRING_ARRAY || ast->n2->type != TYPE_INT)){
            //printf("SOMETHING\n");
            operatorError2Types(ast->n_type,ast->n1->type,ast->n2->type);
        }
        ast->type = TYPE_INT;
    }
    else if (ast->n_type == NODE_CALL){
        int i = 0;
        Type astType, tableType;
        //assert(ast->id->id!=NULL);
        char* id = ast->id->id;
        Table* aux= getMethodTable(main, id);
        TableNode* table;
        /*if(aux!=NULL)
            if(aux->table!=NULL)*/
        table = aux->table->next;

        ast->type = aux->table->type;
        ast = ast->n1;
        while(ast!=NULL || table!=NULL){
            astType = TYPE_VOID;
            tableType = TYPE_VOID;

            if(ast!=NULL){
                //assert(ast!=NULL);
                astType = ast->type;
                ast = ast->next;
            }

            if(table!=NULL){
                //if is a param
                //assert(table!=NULL);
                if(table->isParam == 1){
                    //assert(table!=NULL);
                    tableType = table->type;
                    table = table->next;
                }else{
                    table = NULL;
                }
            }

            if(astType != tableType){
                getErrorCall(i,id, astType, tableType);
            }
            i++;
        }

    }
    //statements
    else if( ast->n_type == NODE_IFELSE || ast->n_type == NODE_WHILE){
        if((ast->n1->type != TYPE_BOOL)){
            //printf("SOMETHING\n");
            statementError(ast->n_type,ast->n1->type,TYPE_BOOL);
        }
    }
    else if( ast->n_type == NODE_PRINT){
        if((ast->n1->type != TYPE_BOOL && ast->n1->type != TYPE_INT)){
            //printf("SOMETHING\n");
            statementError1oranother(ast->n_type,ast->n1->type,TYPE_BOOL,TYPE_INT);
        }
        ast->type = TYPE_INT;
    }else if(ast->n_type == NODE_COMPOUNDSTAT){
        ast->type = ast->n1->type;
    }
    else if(ast->n_type == NODE_STORE || ast->n_type == NODE_STOREARRAY){
        //printf("hasddghasjfdghsdgfhjaskfhasdfkjhasdfjasdhfuj:%s(%s) %s(%s)\n",NODE_STRING[ast->n1->n_type],SYMBOLS_TYPE_NAMES[ast->n1->type],NODE_STRING[ast->n2->n_type],SYMBOLS_TYPE_NAMES[ast->n2->type]);

        //if has index (se é STORE ARRAY)
        if(ast->n2!=NULL){
            if(ast->n2->type != TYPE_INT || (ast->n1->type != TYPE_BOOL_ARRAY && ast->n1->type != TYPE_INT_ARRAY)){
                operatorError2Types(NODE_LOADARRAY,ast->n1->type,ast->n2->type);
                //assignmentErrorArray(ast->n1->value,ast->n1->type,ast->n2->type);
            }

            if(ast->n1->type == TYPE_INT_ARRAY)
                ast->n1->type = TYPE_INT;
            else if(ast->n1->type == TYPE_BOOL_ARRAY)
                ast->n1->type = TYPE_BOOL;
        }
        //se o id é igual à expressao
        if(ast->n1->type != ast->n3->type){
            //printf("SOMETHING\n");
            if(ast->n_type == NODE_STORE)
                assignmentError(ast->n1->value,ast->n3->type,ast->n1->type);
            else
                assignmentErrorArray(ast->n1->value,ast->n3->type,ast->n1->type);
        }
        ast->type = ast->n1->type;
    }

    else if( ast->n_type == NODE_RETURN){
        if(ast->n1!=NULL){
            if((ast->n1->type != getFunctionType())){
                //printf("SOMETHING\n");
                statementError(ast->n_type,ast->n1->type,getFunctionType());
            }
        }else if(getFunctionType()!=TYPE_VOID){
            statementError(ast->n_type,TYPE_VOID,getFunctionType());
        }
    }
}
void statementError(int op, int n1,int n2){
     printf("Incompatible type in %s statement (got %s, required %s)\n",OPERATOR_STRING[op],SYMBOLS_TYPE_NAMES[n1],SYMBOLS_TYPE_NAMES[n2]);
     exit(0);
}
void statementError1oranother(int op, int n1, int n2, int n3){
    printf("Incompatible type in %s statement (got %s, required %s or %s)\n",OPERATOR_STRING[op],SYMBOLS_TYPE_NAMES[n1],SYMBOLS_TYPE_NAMES[n2],SYMBOLS_TYPE_NAMES[n3]);
     exit(0);
}

void operatorError2Types(int op,int n1, int n2){
    printf("Operator %s cannot be applied to types %s, %s\n",OPERATOR_STRING[op],SYMBOLS_TYPE_NAMES[n1],SYMBOLS_TYPE_NAMES[n2]);
    exit(0);
}

void operatorError1Types(int op,int n1){
    printf("Operator %s cannot be applied to type %s\n",OPERATOR_STRING[op],SYMBOLS_TYPE_NAMES[n1]);
    exit(0);
}
void assignmentError(char* var, int n1, int n2){
    printf("Incompatible type in assignment to %s (got %s, required %s)\n",var,SYMBOLS_TYPE_NAMES[n1],SYMBOLS_TYPE_NAMES[n2]);
    exit(0);
}
void assignmentErrorArray(char* var, int n1, int n2){
    printf("Incompatible type in assignment to %s[] (got %s, required %s)\n",var,SYMBOLS_TYPE_NAMES[n1],SYMBOLS_TYPE_NAMES[n2]);
    exit(0);
}
void getErrorCall(int i,char* name, int n1, int n2){
    printf("Incompatible type of argument %d in call to method %s (got %s, required %s)\n",i,name,SYMBOLS_TYPE_NAMES[n1],SYMBOLS_TYPE_NAMES[n2]);
    exit(0);
}

int getFunctionType(){
    return tabelafofinha->table->type;
}
char* getFunctionName(){
    return tabelafofinha->table->id->id;
}
void setTable(Table * oi){
    tabelafofinha = oi;
}

#endif
