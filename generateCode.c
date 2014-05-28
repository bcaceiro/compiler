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
        if(ast->n_type == NODE_PROGRAM){
            printf("declare i32 @printf(i8* noalias nocapture, ...)\n@.printInt = private constant [4 x i8] c\"%%d\\0A\\00\"\n@.printBool = private constant [4 x i8] c\"%%s\\0A\\00\"\n\n");
        }
        if(ast->n_type == NODE_METHODDECL){
            varIndex = 0;
            insideFunction = TRUE;
            tabs++;
            if(strcmp(ast->id->id,"main")==0){
                printf("\ndefine i32 @main(i32 %%argc, i8** %%argv) {\n");
                generateCode(ast->n2->n1);
                generateCode(ast->n3->n1);
                printf("\tret i32 1\n}\n");//\tret i32 0x1\n}\n");
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
                    printf("\tret i1 1\n}\n");
                }
            tabs--;
            insideFunction = FALSE;
        }
        else if(ast->n_type == NODE_VARDECL){
            if(insideFunction == FALSE ){
                aux = ast->id;
                while(aux!=NULL){
                    if(ast->type == TYPE_INT || ast->type == TYPE_BOOL)
                        printf("@%s = global %s 0\n",aux->id,SYMBOLS_TYPE_SIZE[ast->type]);
                    else
                        printf("@%s = global %s null\n",aux->id,SYMBOLS_TYPE_SIZE[ast->type]);
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
            //printf("%s %%%s",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
        }
        else if(ast->n_type == NODE_PLUS || ast->n_type == NODE_MINUS){
            strcpy(value1,generateCode(ast->n1));
            strcpy(value2,generateCode(ast->n2));
            printTabs(tabs);
            varIndex++;
            printf("%%%d = %s %s %s , %s\n",varIndex,CODE_OPERATOR_STRING[ast->n_type],SYMBOLS_TYPE_SIZE[ast->type],value1,value2);   //<result> = add <ty> <op1>, <op2>
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_INTLIT){
            //is a decimal
            if(*(ast->value)!='0'){
                sprintf(returnValue,"%d",atoi(ast->value));
                return returnValue;
            }

            int len = strlen(ast->value);
            //if it is a hexadecimal
            if(len>0 && *(ast->value+1) == 'x'){
                sprintf(returnValue,"%ld",strtol((ast->value+2),NULL,16));
                return returnValue;
            }
            sprintf(returnValue,"%ld",strtol(ast->value,NULL,8));
            return returnValue;
        }
        else if(ast->n_type == NODE_PRINT){
            printTabs(tabs);
            //fazer ifs
            printf("call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %s)\n",generateCode(ast->n1));
        }

        generateCode(ast->next);
    }
    return NULL;

}

            #endif
