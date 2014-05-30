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
char* currentMethod;
int tabs = 0;
int varIndex = 0;
char alreadyOneParam = FALSE;
char returnValue[20];
char value1[20];
char value2[20];

//Check if ID exists and if exists, it returns the type
char checkifIDIsLocal(char* id,char* methodID,Table* main) {

    Table* table = getMethodTable(main, methodID);
    TableNode* local = table->table->next;
    while(local != NULL) {
        if((local->n_type == TABLE_DECL) && strcmp(id,local->id->id) == 0) {
            return TRUE;
        }
        local = local->next;
    }
    return FALSE;
}


char* generateCode(Node* ast,Table* main){
    listID* aux;
    if(ast!=NULL){
        //printf("LOLADA:%s\n",NODE_STRING[ast->n_type]);
        //printf("DEBUG:%s\n\t%s\n",NODE_STRING[ast->n_type],NODE_TYPE_NAMES[ast->type]);
        if(ast->n_type == NODE_PROGRAM){
            printf("declare i32 @printf(i8* noalias nocapture, ...)\n");
            printf("@.printInt = private constant [4 x i8] c\"%%d\\0A\\00\"\n");

            printf("@.true = private constant [6 x i8] c\"true\\0A\\00\"\n");
            printf("@.false = private constant [7 x i8] c\"false\\0A\\00\"\n");
            printf("@.printBool = private constant [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @.false, i32 0, i32 0),i8* getelementptr inbounds ([6 x i8]* @.true, i32 0, i32 0)]\n\n");

        }
        if(ast->n_type == NODE_METHODDECL){
            currentMethod = ast->id->id;
            varIndex = 0;
            insideFunction = TRUE;
            tabs++;
            if(strcmp(ast->id->id,"main")==0){
                printf("\n\ndefine i32 @main(i32 %%argc, i8** %%argv) {\n\n");
                generateCode(ast->n2->n1,main);
                printf("\n");
                generateCode(ast->n3->n1,main);
                printf("\n");
                printf("\tret i32 0\n}\n\n");//\tret i32 0x1\n}\n");
                //printf("\tret i32 0\n}\n");
            }
            else
                if(ast->type == TYPE_VOID){
                    printf("\ndefine %s @%s(",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
                    generateCode(ast->n1->n1,main);
                    alreadyOneParam = FALSE;
                    printf("){\n");
                    generateCode(ast->n2->n1,main);
                    printf("\n");
                    generateCode(ast->n3->n1,main);
                    printf("\n");
                    printf("\tret void\n}\n");
                }
                else{
                    printf("\ndefine %s @%s(",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
                    generateCode(ast->n1->n1,main);
                    alreadyOneParam = FALSE;
                    printf("){\n");
                    generateCode(ast->n2->n1,main);
                    printf("\n");
                    generateCode(ast->n3->n1,main);
                    printf("\n");
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

        else if(ast->n_type == NODE_PLUS || ast->n_type == NODE_MINUS || ast->n_type == NODE_MUL || ast->n_type == NODE_DIV){
            strcpy(value1,generateCode(ast->n1,main));
            strcpy(value2,generateCode(ast->n2,main));
            printTabs(tabs);
            varIndex++;
            printf("%%%d = %s %s %s , %s\n\n",varIndex,CODE_OPERATOR_STRING[ast->n_type],SYMBOLS_TYPE_SIZE[ast->type],value1,value2);   //<result> = add/sub/mul/sdiv <ty> <op1>, <op2>
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
        else if(ast->n_type == NODE_BOOLLIT){
            if(strcmp(ast->value,"true")==0)
                sprintf(returnValue,"%d",1);
            else
                sprintf(returnValue,"%d",0);
            return returnValue;
        }
        else if(ast->n_type == NODE_ID){
            printTabs(tabs);
            varIndex++;
            if(checkifIDIsLocal(ast->value,currentMethod,main)==TRUE){
                printf("%%%d = load %s* %%%s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->value);
            }
            else{
                printf("%%%d = load %s* @%s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->value);
            }
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_STORE){
            printf(";STORE\n");
            strcpy(value1,generateCode(ast->n3,main));
            printTabs(tabs);
            //store i32 3, i32* %ptr
            if(checkifIDIsLocal(ast->n1->value,currentMethod,main)==TRUE){
                printf("store %s %s, %s* %%%s\n\n",SYMBOLS_TYPE_SIZE[ast->n1->type],value1,SYMBOLS_TYPE_SIZE[ast->n1->type],ast->n1->value);
            }
            else{
                printf("store %s %s, %s* @%s\n\n",SYMBOLS_TYPE_SIZE[ast->n1->type],value1,SYMBOLS_TYPE_SIZE[ast->n1->type],ast->n1->value);
            }

        }
        else if(ast->n_type == NODE_PRINT){
            printf(";PRINT\n");
            strcpy(value1,generateCode(ast->n1,main));
            printTabs(tabs);
            varIndex++;
            if(ast->n1->type == TYPE_BOOL){
                //convert to int
                printf("%%%d = zext i1 %s to i32\n", varIndex,value1);
                varIndex++;
                //get the rigth string
                printTabs(tabs);
                printf("%%%d = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %%%d\n", varIndex, varIndex -1);
                varIndex++;
                //load it
                printTabs(tabs);
                printf("%%%d = load i8** %%%d\n", varIndex, varIndex -1);
                printTabs(tabs);
                printf("call i32 (i8*, ...)* @printf(i8* %%%d)\n\n", varIndex);
                varIndex++;
            }else
                printf("call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %s)\n\n",value1);
        }
        else if(ast->n_type == NODE_UNARYMINUS){
            strcpy(value1,generateCode(ast->n1,main));
            printTabs(tabs);

            varIndex++;
            printf("%%%d = mul %s -1 , %s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],value1);
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;

        }

        generateCode(ast->next,main);
    }
    return NULL;

}

#endif
