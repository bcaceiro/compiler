#ifndef _GENERATE_CODE_
#define _GENERATE_CODE_
#include "structures.h"
#include "show.h"
#include "generateCode.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

char insideFunction  = FALSE;
int tabs = 0;
int varIndex = 0;
char alreadyOneParam = FALSE;
char returnValue[20];
char value1[20];
char value2[20];

char* generateCode(Node* ast){
    listID* aux;
    if(ast!=NULL){
        //printf("LOLADA:%s\n",NODE_STRING[ast->n_type]);
        //printf("DEBUG:%s\n\t%s\n",NODE_STRING[ast->n_type],NODE_TYPE_NAMES[ast->type]);
        if(ast->n_type == NODE_METHODDECL){
            insideFunction = TRUE;
            tabs++;
            if(strcmp(ast->id->id,"main")==0){
                printf("\ndefine i32 @main(i32 %%argc, i8** %%argv) {\n\tret i32 0x1\n}\n");
                //printf("\tret i32 0\n}\n");
            }
            else
                if(ast->type == TYPE_VOID){
                    printf("\ndefine %s @%s(",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
                    generateCode(ast->n1->n1);
                    alreadyOneParam = FALSE;
                    printf("){\n");
                    generateCode(ast->n2->n1);
                    generateCode(ast->n3->n1);
                    printf("\tret void\n}\n");
                }
                else{
                    printf("\ndefine %s @%s(",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
                    generateCode(ast->n1->n1);
                    alreadyOneParam = FALSE;
                    printf("){\n");
                    generateCode(ast->n2->n1);
                    generateCode(ast->n3->n1);
                    printf("\tret i1 1; MERDAS, POR ISTO BEM SENÃO DÁ MERDA\n}\n");
                }
            tabs--;
            insideFunction = FALSE;
        }
        else if(ast->n_type == NODE_VARDECL){
            if(insideFunction == FALSE ){
                aux = ast->id;
                while(aux!=NULL){
                    printf("@%s = global %s\n",aux->id,SYMBOLS_TYPE_SIZE[ast->type]);
                    aux = aux->next;
                }
            }
            else{
                printTabs(tabs);
                printf("%%%s = alloca %s\n",ast->id->id,SYMBOLS_TYPE_SIZE[ast->type]);
            }
        }
        else if(ast->n_type == NODE_PARAMDECL){
            if(alreadyOneParam == TRUE)
                printf(",");
            alreadyOneParam = TRUE;
            printf("%s %%%s",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
        }
        else if(ast->n_type == NODE_STORE){
            generateCode(ast->n3);
            exit(-1);
            //printf("%s %%%s",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
        }
        else if(ast->n_type == NODE_PLUS){
            strcpy(value1,generateCode(ast->n1));
            strcpy(value2,generateCode(ast->n2));
            printTabs(tabs);
            varIndex++;
            printf("%%%d = add %s %%%s %%%s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],value1,value2);   //<result> = add <ty> <op1>, <op2>
        }
        else if(ast->n_type == NODE_INTLIT){
            printTabs(tabs);
            varIndex++;
            printf("%%%d = add i32 0 %s\n",varIndex,ast->value);
            sprintf(returnValue,"%d",varIndex);
            return returnValue;
        }





        generateCode(ast->next);
    }
    return NULL;

}

#endif
