#ifndef _FUNCTIONS_
#define _FUNCTIONS_
#include "structures.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

Node* setStatic(Node* currentNode){
    if(currentNode==NULL){
        if(DEBUG)printf("NODE NULL insertID\n");
        assert(currentNode!=NULL);
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
    newMethod->n1 = params;
    newMethod->n2 = varDecl;
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


    return insertIf;
}

Node* insertCompound(Node* expression){
    if(DEBUG)printf("InsertCompound\n");
    if(expression == NULL || expression->next == NULL)
        return expression;

    //create a compoundStatement
    Node* newCompound = (Node*) malloc(sizeof(Node));
    if(newCompound==NULL){
        if(DEBUG)printf("DEU MERDA malloc insertCompound\n");
        assert(newCompound!=NULL);
    }
    newCompound->n_type = NODE_COMPOUNDSTAT;
    newCompound->next = expression;

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

    if(DEBUG)printf("insertStore\n");

    listID* idArray = (listID*) malloc(sizeof(listID));
    Node* thisNode =  (Node*) malloc(sizeof(Node));
    if(thisNode == NULL || idArray == NULL){
        if(DEBUG)printf("DEU MERDA malloc insertStore\n");
        assert(thisNode == NULL || idArray == NULL);
    }

    if(arrayIndex!=NULL)
        thisNode->n_type = NODE_STORE;
    else
        thisNode->n_type = NODE_STOREARRAY;

    idArray->id = id;
    thisNode->value = NULL;

    thisNode->n1 = arrayIndex;
    thisNode->n2 = expression;
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

    return newTerminal;
}

#endif
