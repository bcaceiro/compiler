#include "structures.h"
#include <stdlib.h>
#include <stdio.h>

void cleanIds(listID* ids){
    listID* aux;
    listID* current;
    aux = ids;
    while(aux!=NULL){
        free(aux->id);
        current = aux;
        aux = aux->next;
        free(current);
    }
}

void cleanNodes(Node* ast){
    if(ast!=NULL){
        if(ast->n_type==NODE_NULL)
            return;
        if(ast->n1 !=NULL){
            cleanNodes(ast->n1);
        }

        if(ast->n2 !=NULL){
            cleanNodes(ast->n2);
        }

        if(ast->n3 !=NULL){
            cleanNodes(ast->n3);
        }

        if(ast->value !=NULL){
            free(ast->value);
        }

        if(ast->id !=NULL){
            cleanIds(ast->id);
        }

        if(ast->next !=NULL){
            cleanNodes(ast->next);
        }

        free(ast);
    }
}
void cleanTableNode(TableNode* tnode){
    TableNode* aux;
    TableNode* current;
    aux = tnode;
    while(aux!=NULL){
        current = aux;
        aux = aux->next;
        free(current);
    }

}

void cleanTable(Table* tbl){
    Table* aux;
    Table* current;
    aux = tbl;
    while(aux!=NULL){
        current = aux;
        aux = aux->next;
        cleanTableNode(current->table);
        free(current);
    }

}
