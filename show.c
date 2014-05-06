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
void printNode( Node* currentNode) {
    /* TODO: falta aqui um tipo acho eu */

    if(currentNode->n_type == NODE_BOOLLIT || currentNode->n_type == NODE_INTLIT)
        printf("%s(%s)\n",NODE_STRING[currentNode->n_type], currentNode->value);

    else {
        printf("%s\n",NODE_STRING[currentNode->n_type]);
    }
}

/* 
    Prints the subtree of a given node
        @Param currentNode root of the subtree
        @Param tabs number of tabs
*/
void printSubTree(Node* currentNode, int tabs) {

    printTabs(tabs);
    printNode(currentNode);

    if(currentNode->n1 != NULL)
        printSubTree(currentNode->n1, tabs + 1);

    if(currentNode->n2 != NULL)
        printSubTree(currentNode->n2, tabs + 1);

    if(currentNode->n3 != NULL)
        printSubTree(currentNode->n3, tabs + 1);

    if(currentNode->next != NULL)
        printSubTree(currentNode->next, tabs);
    
}

void printIDs(listID* ids,int tabs) {
    while(ids!=NULL){
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
    printSubTree(AST,0);
}


#endif
