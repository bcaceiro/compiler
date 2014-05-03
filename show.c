#ifndef _SHOWF_
#define _SHOWF_
#include "show.h"
#include "structures.h"
#include <stdlib.h>
#include <stdio.h>

void show_program(Node* currentNode)
{
    printf("printstuff\n\n\n\n\n\n");
    printf("CLASS\n\tID(%s)\n",currentNode->id->id);
}
void printIDs(listID* ids){
    while(ids!=NULL){
        printf("%s\n",ids->id);
        ids = ids->next;
    }
}

#endif
