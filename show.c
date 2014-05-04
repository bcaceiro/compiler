#ifndef _SHOWF_
#define _SHOWF_
#include "show.h"
#include "structures.h"
#include <stdlib.h>
#include <stdio.h>

void show_program(Node* currentNode)
{
    while(currentNode!=NULL){
        printIDs(currentNode->id);
        currentNode = currentNode->next;
    }
}

void printIDs(listID* ids){
    while(ids!=NULL){
        printf("Id(%s)\n",ids->id);
        ids = ids->next;
    }
}

#endif
