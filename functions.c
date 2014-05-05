#ifndef _FUNCTIONS_
#define _FUNCTIONS_
#include "structures.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

Node* setStatic(Node* currentNode){
    if(currentNode==NULL){
        printf("NODE NULL insertID\n");
        assert(currentNode!=NULL);
    }
    currentNode->isStatic = TRUE;
    return currentNode;
}

listID* insertID(Node* currentNode, char* id){
    printf("InsertingID\n\n");
    //just to be safe
    if(currentNode==NULL){
        printf("NODE NULL insertID\n");
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
        printf("DEU MERDA MALLOC insertID\n");
        assert(tmp!=NULL);
    }
    return tmp;
}

Node* insertClass(char* id, Node* statements){
    printf("Inserting Class (%s) \n\n",id);
    Node* newClass = (Node*) malloc(sizeof(Node));
    if(newClass==NULL){
        printf("DEU MERDA MALLOC insertClass\n");
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
        printf("DEU MERDA MALLOC newVarID\n");
        assert(id!=NULL);
    }
    tmp = (listID*) malloc(sizeof(listID));
    if (tmp != NULL){
        //replace the current ID for the nextOne;
        tmp->id  = id;
        tmp->next = next;
    }
    else{
        printf("DEU MERDA MALLOC newVarID\n");
        assert(tmp!=NULL);
    }
    return tmp;
}

Node* newVarDecl(int type, char* id, listID* moreIds, Node* next){
    printf("Inserting newVarDecl (%s)\n",id);
    Node* newVar = (Node*) malloc(sizeof(Node));
    if(newVar==NULL){
        printf("DEU MERDA MALLOC insertClass\n");
        assert(newVar!=NULL);
    }

    //set the node type
    newVar->n_type = NODE_VARDECL;
    newVar->type = (Type)type;
    newVar->id = newVarID(id, moreIds);
    newVar->next = next;
    return newVar;
}

Node* newMethod(int type, char* id, Node* params, Node* varDecl, Node* statements){
    printf("Inserting New method(%s)\n",id);
    Node* newMethod = (Node*) malloc(sizeof(Node));
    if(newMethod==NULL){
        printf("DEU MERDA MALLOC insertClass\n");
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
    current->next = next;
    return current;
}

#endif
