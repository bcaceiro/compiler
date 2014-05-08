#ifndef _SHOWF_
#define _SHOWF_
#include "show.h"
#include "structures.h"
#include <stdlib.h>
#include <stdio.h>

/* 
    Prints tabs for the AST 
        @Param i -> Number of Tabs to be print  
*/
void printTabs(int i) {
    while(i > 0) {
        printf("  ");
        i--;
    }
}

/*
    Prints a Node type
        @Param node Node to be print
*/
void printNode( Node* currentNode, int tabs) {


    /* TODO: falta aqui um tipo acho eu */
    if(currentNode->n_type == NODE_BOOLLIT || currentNode->n_type == NODE_INTLIT) {
        printTabs(tabs);
        printf("%s(%s)\n",NODE_STRING[currentNode->n_type], currentNode->value);
    }
    else {
        printTabs(tabs);
        printf("%s\n", NODE_STRING[currentNode->n_type]);
        if(currentNode->n_type == NODE_VARDECL || currentNode->n_type == NODE_PARAMDECL || currentNode->n_type == NODE_METHODDECL){
            printTabs(tabs + 1);
            printf("%s\n",NODE_TYPE_NAMES[currentNode->type]);
        }
        printIDs(currentNode->id,tabs+1, currentNode->n_type, currentNode->type);
    }
        
}

void printStore ( Node* currentNode , int tabs){
    //print a Store, what do we have to do???

    //print the Node_type
    //print the ID
    //if storeArray print the index expression (n1????);
    //print the expression (n2????)
    //go to next?
    printTabs(tabs + 1);
    //NODE_1
    if(currentNode->n1 != NULL){
        printSubTree(currentNode->n1, tabs + 2);
    }
    //NODE_2
    printTabs(tabs + 1);
    if(currentNode->n2 != NULL){
        printSubTree(currentNode->n2, tabs + 2);
    }
    if(currentNode->n3 != NULL){
        printSubTree(currentNode->n3, tabs + 2);
    }
}

/* 
    Prints the subtree of a given node
        @Param currentNode root of the subtree
        @Param tabs number of tabs
*/
void printSubTree(Node* currentNode, int tabs) {

    //printTabs(tabs);
    printNode(currentNode, tabs);


    switch (currentNode->n_type) {

        /*case NODE_STOREARRAY:
            //exit(-1);
            break;*/
        case NODE_METHODDECL:
            printTabs(tabs + 1);
            printf("%s\n",NODE_STRING[NODE_METHODPARAMS]);
            //NODE_1
            if(currentNode->n1 != NULL){
                printSubTree(currentNode->n1, tabs + 2);
            }
            //NODE_2
            printTabs(tabs + 1);
            printf("%s\n",NODE_STRING[NODE_METHODBODY]);
            if(currentNode->n2 != NULL){
                printSubTree(currentNode->n2, tabs + 2);
            }
            if(currentNode->n3 != NULL){
                printSubTree(currentNode->n3, tabs + 2);
            }
            break;

        default:
            /*if(currentNode->n_type == NODE_STORE){
                printf("Store:%p %p\n",currentNode->n1,currentNode->n2);
            }*/
            //NODE_1
            if(currentNode->n1 != NULL){
                printSubTree(currentNode->n1, tabs + 1);
            }
            //NODE_2
            if(currentNode->n2 != NULL){
                //printf("lolada:%s\n",NODE_STRING[currentNode->n2->n_type]);
                printSubTree(currentNode->n2, tabs + 1);
            }
            //NODE_3
            if(currentNode->n3 != NULL)
                printSubTree(currentNode->n3, tabs + 1);
            break;
        }

    //next Node
    //printf("print next(%s)\n",NODE_STRING[currentNode->n_type]);
    if(currentNode->next != NULL)
        printSubTree(currentNode->next, tabs);
    
}

void printIDs(listID* ids,int tabs, int n_type, int type) {
    while(ids != NULL) {
        printTabs(tabs);
        printf("Id(%s)\n",ids->id);
        ids = ids->next;
    }
}






/*
    Prints the AST
        @Param AST Root of the AST
*/
void printAST(Node* AST) {
    /*printNode(AST, 0);*/
    if(AST != NULL) {
        printf("%s\n", NODE_STRING[AST->n_type]);  
        printTabs(1);
        printf("Id(%s)\n", AST->id->id);   
    }
    
    if(AST->next != NULL)
        printSubTree(AST->next,1);
}


#endif
