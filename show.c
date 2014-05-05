#ifndef _SHOWF_
#define _SHOWF_
#include "show.h"
#include "structures.h"
#include <stdlib.h>
#include <stdio.h>


void printTabs(int i){
    while(i>0){
        printf("\t");
        i--;
    }
}

void show_program(Node* currentNode)
{
    int tabs = 0;
    while(currentNode!=NULL){
        printTabs(tabs);
        printf("%s\n",NODE_STRING[currentNode->n_type]);
        //TODO
        if(TRUE)
            tabs++;
        printIDs(currentNode->id,tabs);
        currentNode = currentNode->next;
    }
}

void printIDs(listID* ids,int tabs){
    while(ids!=NULL){
        printTabs(tabs);
        printf("Id(%s)\n",ids->id);
        ids = ids->next;
    }
}


#endif
