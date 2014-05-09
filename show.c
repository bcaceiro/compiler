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

    if(currentNode->n_type == NODE_DONTPRINT)
           return;

    /* TODO: falta aqui um tipo acho eu */
    else if(currentNode->n_type == NODE_BOOLLIT || currentNode->n_type == NODE_INTLIT || currentNode->n_type == NODE_ID ) {
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

/* 
    Prints the subtree of a given node
        @Param currentNode root of the subtree
        @Param tabs number of tabs
*/
void printSubTree(Node* currentNode, int tabs) {

    //printTabs(tabs);
    printNode(currentNode, tabs);
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
            if(currentNode->n3 != NULL){
                printSubTree(currentNode->n3, tabs + 1);
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


void printSymbols(Table* table){
    if(table!=NULL){
        if(table->table->n_type == TABLE_CLASS){
            printf("===== Class %s Symbol Table =====\n",table->table->id->id);
            printSymbolsDecl(table->table->next);
        }
        else if(table->table->n_type == TABLE_METHOD){
            printf("\n===== Method %s Symbol Table =====\nreturn\t%s\n",table->table->id->id,SYMBOLS_TYPE_NAMES[table->table->type]);
            printSymbolsDecl(table->table->next);
        }
        printSymbols(table->next);
    }
}
void printSymbolsDecl(TableNode* tableNode){
    if(tableNode!=NULL){
        if(tableNode->n_type == TABLE_METHOD)
            printf("%s\tmethod\n",tableNode->id->id);
        else{
            if(tableNode->isParam)
                printf("%s\t%s\tparam\n",tableNode->id->id,SYMBOLS_TYPE_NAMES[tableNode->type]);
            else
                printf("%s\t%s\n",tableNode->id->id,SYMBOLS_TYPE_NAMES[tableNode->type]);
        }
        printSymbolsDecl(tableNode->next);
    }
}

#endif
