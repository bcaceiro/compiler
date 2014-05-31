#ifndef _GENERATE_CODE_
#define _GENERATE_CODE_
#include "structures.h"
#include "show.h"
#include "generateCode.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#define LOCAL 0
#define PARAM 1
#define GLOBAL 2

char insideFunction  = FALSE;
char* currentMethod;
int tabs = 0;
int varIndex = 0;
char alreadyOneParam = FALSE;
char returnValue[100];

//Check if ID is Local
char checkifIDIsLocal(char* id,char* methodID,Table* main) {
    char returnFlag = PARAM;
    Table* table = getMethodTable(main, methodID);
    TableNode* local;
    local = table->table->next;
    while(local != NULL) {
        if(local->isParam == FALSE)
            returnFlag =  LOCAL;
        if((local->n_type == TABLE_DECL) && strcmp(id,local->id->id) == 0) {
            return returnFlag;
        }
        local = local->next;
    }
    return GLOBAL;
}

char* generateCode(Node* ast,Table* main){
    listID* aux;
    char value1[100];
    char value2[100];
    char value3[100];
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
            if(ast->type == TYPE_BOOL){
                printf("\ndefine %s @%s(",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
                generateCode(ast->n1->n1,main);
                alreadyOneParam = FALSE;
                printf("){\n");
                generateCode(ast->n2->n1,main);
                printf("\n");
                generateCode(ast->n3->n1,main);
                printf("\n");
                printf("\tret i1 0}\n");
            }
            else{
                if(strcmp(ast->id->id,"main")==0){
                    printf("\n\ndefine i32 @main(i32 %%argc, i8** %%argv");
                }
                else{
                    printf("\ndefine %s @%s(",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
                    generateCode(ast->n1->n1,main);
                }
                alreadyOneParam = FALSE;
                printf("){\n");
                generateCode(ast->n2->n1,main);
                printf("\n");
                generateCode(ast->n3->n1,main);
                printf("\n");
                printf("\tret i32 0\n}\n");
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
            char result = checkifIDIsLocal(ast->value,currentMethod,main);
            //printf("\n\n;DEBUG:   %s(%s)\n\n",SYMBOLS_TYPE_NAMES[ast->type],ast->value);
            if(result == LOCAL){
                varIndex++;
                printf("%%%d = load %s* %%%s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->value);
            }
            else if (result == PARAM) {
                sprintf(returnValue,"%%%s",ast->value);
                return returnValue;
            }
            else{
                varIndex++;
                printf("%%%d = load %s* @%s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->value);
            }
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_LOADARRAY){

            printf(";LOADARRAY\n");
            strcpy(value1,generateCode(ast->n1,main));
            strcpy(value2,generateCode(ast->n2,main));

            //get the index
            //add 1 because of the size of the array
            varIndex++;
            printTabs(tabs);
            printf("%%%d = add i32 1, %s\n",varIndex,value2);
            sprintf(value2,"%%%d",varIndex);

            //get the final pointer
            varIndex++;
            printTabs(tabs);
            printf("%%%d = getelementptr inbounds %s %s, i32 %s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->n1->type],value1,value2);
            sprintf(value2,"%%%d",varIndex);

            //get the value
            varIndex++;
            printTabs(tabs);
            printf("%%%d = load %s* %s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],value2);

            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;

        }
        else if(ast->n_type == NODE_STORE){
            printf(";STORE\n");
            strcpy(value1,generateCode(ast->n3,main));
            printTabs(tabs);
            //store i32 3, i32* %ptr
            if(checkifIDIsLocal(ast->n1->value,currentMethod,main)!=GLOBAL){
                printf("store %s %s, %s* %%%s\n\n",SYMBOLS_TYPE_SIZE[ast->n1->type],value1,SYMBOLS_TYPE_SIZE[ast->n1->type],ast->n1->value);
            }
            else{
                printf("store %s %s, %s* @%s\n\n",SYMBOLS_TYPE_SIZE[ast->n1->type],value1,SYMBOLS_TYPE_SIZE[ast->n1->type],ast->n1->value);
            }

        }
        else if(ast->n_type == NODE_STOREARRAY){
            printf(";STOREARRAY\n");
            strcpy(value1,generateCode(ast->n1,main));
            strcpy(value2,generateCode(ast->n2,main));
            strcpy(value3,generateCode(ast->n3,main));
            //get the index
            //add 1 because of the size of the array
            varIndex++;
            printTabs(tabs);
            printf("%%%d = add i32 1, %s\n",varIndex,value2);
            sprintf(value2,"%%%d",varIndex);

            //get the final pointer
            varIndex++;
            printTabs(tabs);
            printf("%%%d = getelementptr inbounds %s %s, i32 %s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->n1->type],value1,value2);
            sprintf(value2,"%%%d",varIndex);
            printTabs(tabs);
            printf("store %s %s, %s %s\n\n",SYMBOLS_TYPE_SIZE[ast->n3->type],value3,SYMBOLS_TYPE_SIZE[ast->type],value2);

        }
        else if( ast->n_type == NODE_NEWINT || ast->n_type == NODE_NEWBOOL){
            printf(";NEWINT\n");

            strcpy(value1,generateCode(ast->n1,main));

            printTabs(tabs);
            varIndex++;
            printf("%%%d = add i32 1, %s\n",varIndex,value1);
            sprintf(value1,"%%%d",varIndex);
            printTabs(tabs);
            varIndex++;
            if(ast->type==TYPE_BOOL_ARRAY)
                printf("%%%d = alloca i1, %s %s \n",varIndex,SYMBOLS_TYPE_SIZE[ast->n1->type],value1);
            else
            printf("%%%d = alloca i32, %s %s \n",varIndex,SYMBOLS_TYPE_SIZE[ast->n1->type],value1);
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;

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
            //just multiply by -1
            printf("%%%d = mul %s -1 , %s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],value1);
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;

        }
        else if(ast->n_type == NODE_NOT){
            strcpy(value1,generateCode(ast->n1,main));
            printTabs(tabs);

            varIndex++;
            //MAKING A NOT LIKE A BOSS!
            printf("%%%d = sub i1 1, %s\n",varIndex,value1);
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_GREATER || ast->n_type == NODE_LESS || ast->n_type == NODE_GREATEREQUAL || ast->n_type == NODE_LESSEQUAL || ast->n_type == NODE_EQUAL || ast->n_type == NODE_DIFFERENT){
            strcpy(value1,generateCode(ast->n1,main));
            strcpy(value2,generateCode(ast->n2,main));
            printTabs(tabs);

            varIndex++;
            //MAKING A NOT LIKE A BOSS!
            printf("%%%d = icmp %s i32 %s, %s\n",varIndex,CODE_OPERATOR_STRING[ast->n_type],value1,value2);
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_CALL){

            printTabs(tabs);
            //%retval = call i32 @test(i32 %argc)
            Node* aux;
            char flagzinhafofinha;
            callParams* params = (callParams*)malloc(sizeof(callParams));
            callParams* current = params;

            //UPS!!!!
            assert(params!=NULL);

            //params
            aux = ast->n1;
            while(aux!=NULL){
                current->next = (callParams*)malloc(sizeof(callParams));

                //UPS
                assert(current->next!=NULL);
                current = current->next;
                current->next = NULL;

                strcpy(current->name,generateCode(aux,main));
                current->type = aux->type;

                aux = aux->next;

            }


            varIndex++;
            printf("%%%d = call %s @%s(",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
            flagzinhafofinha = FALSE;
            params = params->next;
            while(params!=NULL){

                if(flagzinhafofinha==TRUE)
                    printf(",");
                else
                    flagzinhafofinha = TRUE;

                printf(" %s %s ",SYMBOLS_TYPE_SIZE[params->type],params->name);
                current = params;
                params = params->next;
                free(current);

            }

            printf(")\n\n");
            sprintf(returnValue,"%%%d",varIndex);
            return returnValue;

        }

        generateCode(ast->next,main);
    }
    return NULL;

}

#endif
