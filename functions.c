#ifndef _FUNCTIONS_
#define _FUNCTIONS_
#include "structures.h"
#include "show.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
Node* nullNode = NULL;

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
    newMethod->n1 = params;

    //printf("Creating method!!!vardecl:%p\n",varDecl);
    newMethod->n2 = varDecl;
/*    if(params == NULL)
        newMethod->n1 = createNull();
    if(varDecl == NULL)
        newMethod->n2 = createNull();
    if(statements == NULL)
        newMethod->n3 = createNull();*/
    newMethod->n3 = statements;

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

    insertID(thisNode,id);
    //printf("ID Store(%s)\n",thisNode->id->id);

    thisNode->value = NULL;
    thisNode->n1 = arrayIndex;
    //printf("lolada2:%s\n",NODE_STRING[expression->n_type]);
    thisNode->n2 = expression;
    if(arrayIndex!=NULL){
        thisNode->n_type = NODE_STOREARRAY;
        if(arrayIndex == NULL)
            thisNode->n1 = createNull();
    }else
        thisNode->n_type = NODE_STORE;

    if(expression == NULL)
        thisNode->n2 = createNull();

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
    newParseInt->id = insertID(newParseInt,id);
    newParseInt->n1 = indexExpression;

    if(indexExpression == NULL)
        newParseInt->n1 = createNull();

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
#endif
