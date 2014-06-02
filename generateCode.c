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
int function_type;
int counter4jumps;
int pedreiroMaster;

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
            printf("declare noalias i8* @calloc(i32, i32) nounwind\n");
            printf("declare i32 @atoi(i8*) nounwind readonly\n");
            printf("@.printInt = private constant [4 x i8] c\"%%d\\0A\\00\"\n");

            printf("@.true = private constant [6 x i8] c\"true\\0A\\00\"\n");
            printf("@.false = private constant [7 x i8] c\"false\\0A\\00\"\n");
            printf("@.printBool = private constant [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @.false, i32 0, i32 0),i8* getelementptr inbounds ([6 x i8]* @.true, i32 0, i32 0)]\n\n");
            printf("%%.ArrayInt = type { i32, i32* }\n");
            printf("%%.ArrayBool = type { i32, i1* }\n");
            counter4jumps = 0;
        }
        else if(ast->n_type == NODE_METHODDECL){
            currentMethod = ast->id->id;
            varIndex = 0;
            insideFunction = TRUE;
            tabs++;
            if(strcmp(ast->id->id,"main")==0){
                function_type = TYPE_INT;
                //change this to include the name of the variable defined by the user...
                printf("\n\ndefine i32 @main(i32 %%argc, i8** %%%s){\n",ast->n1->n1->id->id);
            }
            else{
                function_type = ast->type;
                printf("\ndefine %s @%s(",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
                generateCode(ast->n1->n1,main);
                if(ast->n1->n1==NULL)
                    printf("){\n");
            }
            alreadyOneParam = FALSE;
            generateCode(ast->n2->n1,main);
            printf("\n");
            generateCode(ast->n3->n1,main);
            printf("\n");
            printTabs(tabs);
            if(function_type == TYPE_INT)
                printf("ret i32 0\n");
            else if(function_type == TYPE_BOOL)
                printf("ret i1 0\n");
            else if(function_type == TYPE_INT_ARRAY)
                printf("ret %%.ArrayInt {i32 0, i32* null}\n");
            else if(function_type == TYPE_BOOL_ARRAY)
                printf("ret %%.ArrayBool {i32 0, i1* null}\n");
            printf("}\n\n");
            tabs--;
            insideFunction = FALSE;
        }
        else if(ast->n_type == NODE_VARDECL){
            if(insideFunction == FALSE ){
                aux = ast->id;
                while(aux!=NULL){
                    if(ast->type == TYPE_INT || ast->type == TYPE_BOOL)
                        printf("@%s = global %s 0\n",aux->id,SYMBOLS_TYPE_SIZE[ast->type]);
                    else{
                        if(ast->type == TYPE_INT_ARRAY)
                            printf("@%s = global %s {i32 0, i32* null}\n",aux->id,SYMBOLS_TYPE_SIZE[ast->type]);
                        else if(ast->type == TYPE_BOOL_ARRAY)
                            printf("@%s = global %s {i32 0, i1* null}\n",aux->id,SYMBOLS_TYPE_SIZE[ast->type]);
                    }
                    aux = aux->next;
                }
            }
            else{
                aux = ast->id;
                while(aux!=NULL){
                    printTabs(tabs);
                    printf("%%%s = alloca %s\n",aux->id,SYMBOLS_TYPE_SIZE[ast->type]);
                    aux = aux->next;
                }
           }
        }
        else if(ast->n_type == NODE_PARAMDECL){
            if(alreadyOneParam == TRUE)
                printf(",");
            alreadyOneParam = TRUE;
            printf("%s %%.%s",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
            generateCode(ast->next,main);
            if(ast->next == NULL)
                printf("){\n");
            printf("%%%s  = alloca %s\n",ast->id->id,SYMBOLS_TYPE_SIZE[ast->type]);
            printf("store %s %%.%s, %s* %%%s",SYMBOLS_TYPE_SIZE[ast->type],ast->id->id,SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
            return returnValue;
        }
        else if(ast->n_type == NODE_PLUS || ast->n_type == NODE_MINUS || ast->n_type == NODE_MUL || ast->n_type == NODE_DIV || ast->n_type == NODE_MOD){
            strcpy(value1,generateCode(ast->n1,main));
            strcpy(value2,generateCode(ast->n2,main));
            printTabs(tabs);
            varIndex++;
            printf("%%t%d = %s %s %s , %s\n\n",varIndex,CODE_OPERATOR_STRING[ast->n_type],SYMBOLS_TYPE_SIZE[ast->type],value1,value2);   //<result> = add/sub/mul/sdiv <ty> <op1>, <op2>
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_AND){
            strcpy(value1,generateCode(ast->n1,main));
            int tmp = counter4jumps;
            int temp2;
            //se 1ºparam é true, executar merdas
            printTabs(tabs);
            varIndex++;
            temp2 = varIndex;
            //alloc temporary space
            printf("%%t%d = alloca i1\n",varIndex);
            //store th 1º value
            printTabs(tabs);
            printf("store i1 %s, i1* %%t%d\n",value1,varIndex);
            //verify if it need to run the second
            printTabs(tabs);
            varIndex++;
            printf("%%t%d = icmp eq i1 1, %s\n", varIndex, value1);
            printTabs(tabs);
            printf("br i1 %%t%d, label %%and.do%d, label %%and.end%d\n",varIndex,tmp,tmp);
            printf("and.do%d:\n",tmp);
            counter4jumps++;
            strcpy(value2,generateCode(ast->n2,main));
            printTabs(tabs);
            printf("store i1 %s, i1* %%t%d\n",value2,temp2);
            printTabs(tabs);
            printf("br label %%and.end%d\n",tmp);
            printf("and.end%d:\n",tmp);
            varIndex++;
            printTabs(tabs);
            printf("%%t%d = load i1* %%t%d\n",varIndex,temp2);
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_OR){
            strcpy(value1,generateCode(ast->n1,main));
            int tmp = counter4jumps;
            int temp2;
            //se 1ºparam é true, executar merdas
            printTabs(tabs);
            varIndex++;
            temp2 = varIndex;
            //alloc temporary space
            printf("%%t%d = alloca i1\n",varIndex);
            //store th 1º value
            printTabs(tabs);
            printf("store i1 %s, i1* %%t%d\n",value1,varIndex);
            //verify if it need to run the second
            printTabs(tabs);
            varIndex++;
            printf("%%t%d = icmp eq i1 0, %s\n", varIndex, value1);
            printTabs(tabs);
            printf("br i1 %%t%d, label %%and.do%d, label %%and.end%d\n",varIndex,tmp,tmp);
            printf("and.do%d:\n",tmp);
            counter4jumps++;
            strcpy(value2,generateCode(ast->n2,main));
            printTabs(tabs);
            printf("store i1 %s, i1* %%t%d\n",value2,temp2);
            printTabs(tabs);
            printf("br label %%and.end%d\n",tmp);
            printf("and.end%d:\n",tmp);
            varIndex++;
            printTabs(tabs);
            printf("%%t%d = load i1* %%t%d\n",varIndex,temp2);
            sprintf(returnValue,"%%t%d",varIndex);
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
        else if(ast->n_type == NODE_UNARYMINUS){
            strcpy(value1,generateCode(ast->n1,main));
            printTabs(tabs);

            varIndex++;
            //just multiply by -1
            printf("%%t%d = mul %s -1 , %s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],value1);
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;

        }
        else if(ast->n_type == NODE_UNARYPLUS){
            //this doesn't do anything
            strcpy(returnValue,generateCode(ast->n1,main));
            return returnValue;

        }
        else if(ast->n_type == NODE_NOT){
            strcpy(value1,generateCode(ast->n1,main));
            printTabs(tabs);

            varIndex++;
            //MAKING A NOT LIKE A BOSS!
            printf("%%t%d = sub i1 1, %s\n",varIndex,value1);
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_GREATER || ast->n_type == NODE_LESS || ast->n_type == NODE_GREATEREQUAL || ast->n_type == NODE_LESSEQUAL || ast->n_type == NODE_EQUAL || ast->n_type == NODE_DIFFERENT){
            strcpy(value1,generateCode(ast->n1,main));
            strcpy(value2,generateCode(ast->n2,main));
            printTabs(tabs);

            varIndex++;
            printf("%%t%d = icmp %s i32 %s, %s\n",varIndex,CODE_OPERATOR_STRING[ast->n_type],value1,value2);
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_ID){

            printTabs(tabs);
            char result = checkifIDIsLocal(ast->value,currentMethod,main);
            //printf("\n\n;DEBUG:   %s(%s)\n\n",SYMBOLS_TYPE_NAMES[ast->type],ast->value);
            if(result != GLOBAL){
                varIndex++;
                printf("%%t%d = load %s* %%%s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->value);
            }
            else{
                varIndex++;
                printf("%%t%d = load %s* @%s\n",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->value);
            }
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;
        }
        else if(ast->n_type == NODE_LOADARRAY){

            printf(";LOADARRAY\n");
            //array
            strcpy(value1,generateCode(ast->n1,main));
            //index
            strcpy(value2,generateCode(ast->n2,main));

            varIndex++;
            printTabs(tabs);
            printf("%%t%d = extractvalue %s %s, 1\n", varIndex,SYMBOLS_TYPE_SIZE[ast->n1->type], value1);
            if(ast->n1->type == TYPE_BOOL_ARRAY){
                varIndex++;
                printTabs(tabs);
                printf("%%t%d = getelementptr i1* %%t%d, i32 %s\n",varIndex,varIndex-1,value2);
                varIndex++;
                printTabs(tabs);
                printf("%%t%d = load i1* %%t%d\n",varIndex,varIndex-1);
            }else if(ast->n1->type == TYPE_INT_ARRAY){

                varIndex++;
                printTabs(tabs);
                printf("%%t%d = getelementptr i32* %%t%d, i32 %s\n",varIndex,varIndex-1,value2);
                varIndex++;
                printTabs(tabs);
                printf("%%t%d = load i32* %%t%d\n",varIndex,varIndex-1);
            }
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;

        }
        else if(ast->n_type == NODE_STORE){
            char tmp;
            printf(";STORE\n");
            strcpy(value1,generateCode(ast->n3,main));
            printTabs(tabs);
            //store i32 3, i32* %ptr
            tmp = checkifIDIsLocal(ast->n1->value,currentMethod,main);
            if(tmp!=GLOBAL){
                printf("store %s %s, %s* %%%s\n\n",SYMBOLS_TYPE_SIZE[ast->n1->type],value1,SYMBOLS_TYPE_SIZE[ast->n1->type],ast->n1->value);
            }
            else{
                printf("store %s %s, %s* @%s\n\n",SYMBOLS_TYPE_SIZE[ast->n1->type],value1,SYMBOLS_TYPE_SIZE[ast->n1->type],ast->n1->value);
            }

        }
        else if(ast->n_type == NODE_STOREARRAY){


            printf(";STOREARRAY\n");
            //array
            strcpy(value1,generateCode(ast->n1,main));
            //index
            strcpy(value2,generateCode(ast->n2,main));
            //value
            strcpy(value3,generateCode(ast->n3,main));


            //varIndex++;
            //printTabs(tabs);
            //printf("%%t%d = load %s* %s%s\n", varNumber++, llvmType1, varDeclSymbol, stmt->id);

            varIndex++;
            printTabs(tabs);
            printf("%%t%d = extractvalue %s %s, 1\n", varIndex, SYMBOLS_TYPE_SIZE[ast->n1->type], value1);
            varIndex++;
            printTabs(tabs);
            printf("%%t%d = getelementptr %s* %%t%d, i32 %s\n", varIndex, SYMBOLS_TYPE_SIZE[ast->n3->type], varIndex -1, value2);
            printTabs(tabs);
            printf("store %s %s, %s* %%t%d\n", SYMBOLS_TYPE_SIZE[ast->n3->type], value3, SYMBOLS_TYPE_SIZE[ast->n3->type], varIndex);


        }
        else if(ast->n_type == NODE_NEWINT){

            printf(";NEWINTARRAY\n");

            strcpy(value1,generateCode(ast->n1,main));
            varIndex++;
            printTabs(tabs);
            //reserve the space
            printf("%%t%d = call noalias i8* @calloc(i32 %s, i32 4) nounwind\n\n", varIndex, value1);
            varIndex++;
            printTabs(tabs);
            //cast to int
            printf("%%t%d = bitcast i8* %%t%d to i32*\n", varIndex, varIndex -1);
            varIndex++;
            printTabs(tabs);
            //insert size
            printf("%%t%d = insertvalue %%.ArrayInt undef, i32 %s, 0\n", varIndex, value1);
            varIndex++;
            printTabs(tabs);
            //insert array
            printf("%%t%d = insertvalue %%.ArrayInt %%t%d, i32* %%t%d, 1\n", varIndex, varIndex -1, varIndex -2);

            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;


       }
        else if(ast->n_type == NODE_NEWBOOL){


            printf(";NEWBOOLARRAY\n");

            strcpy(value1,generateCode(ast->n1,main));
            varIndex++;
            printTabs(tabs);
             //reserve the space
            printf("%%t%d = call noalias i8* @calloc(i32 %s, i32 1) nounwind\n\n", varIndex, value1);
            varIndex++;
            printTabs(tabs);
            //cast to bool
            printf("%%t%d = bitcast i8* %%t%d to i1*\n", varIndex, varIndex -1);
            varIndex++;
            printTabs(tabs);
            //insert size
            printf("%%t%d = insertvalue %%.ArrayBool undef, i32 %s, 0\n", varIndex, value1);
            varIndex++;
            printTabs(tabs);
            //insert array
            printf("%%t%d = insertvalue %%.ArrayBool %%t%d, i1* %%t%d, 1\n", varIndex, varIndex -1, varIndex -2);

            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;

        }
        else if(ast->n_type == NODE_PRINT){
            printf(";PRINT\n");
            strcpy(value1,generateCode(ast->n1,main));
            printTabs(tabs);
            varIndex++;
            if(ast->n1->type == TYPE_BOOL){
                //convert to int
                printf("%%t%d = zext i1 %s to i32\n", varIndex,value1);
                varIndex++;
                //get the rigth string
                printTabs(tabs);
                printf("%%t%d = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %%t%d\n", varIndex, varIndex -1);
                varIndex++;
                //load it
                printTabs(tabs);
                printf("%%t%d = load i8** %%t%d\n", varIndex, varIndex -1);
                printTabs(tabs);
                printf("call i32 (i8*, ...)* @printf(i8* %%t%d)\n\n", varIndex);
                varIndex++;
            }else
                printf("call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %s)\n\n",value1);
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
                current->next = (callParams*)calloc(sizeof(callParams),1);

                //UPS
                assert(current->next!=NULL);
                current = current->next;
                current->next = NULL;

                strcpy(current->name,generateCode(aux,main));
                current->type = aux->type;

                aux = aux->next;

            }


            varIndex++;
            printf("%%t%d = call %s @%s(",varIndex,SYMBOLS_TYPE_SIZE[ast->type],ast->id->id);
            flagzinhafofinha = FALSE;
            current = params;
            params = params->next;
            free(current);
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
            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;

        }
        else if(ast->n_type == NODE_RETURN){
            pedreiroMaster++;
            printf(";RETURN\n");
            if(ast->n1!=NULL){
                strcpy(value1,generateCode(ast->n1,main));
                printTabs(tabs);
                printf("ret %s %s\n",SYMBOLS_TYPE_SIZE[function_type],value1);
            }
            else{
                if(function_type == TYPE_INT)
                    printf("ret i32 0\n");
                else if(function_type == TYPE_BOOL)
                    printf("ret i1 0\n");
                else if(function_type == TYPE_INT_ARRAY)
                    printf("ret %%.ArrayInt {i32 0, i32* null}\n");
                else if(function_type == TYPE_BOOL_ARRAY)
                    printf("ret %%.ArrayBool {i32 0, i1* null}\n");
            }
        }
        else if(ast->n_type == NODE_LENGTH){

            printf(";.LENGTH\n");
            //array
            strcpy(value1,generateCode(ast->n1,main));
              varIndex++;
            printTabs(tabs);
            if(ast->n1->type != TYPE_STRING_ARRAY){
                printf("%%t%d = extractvalue %s %s, 0\n", varIndex,SYMBOLS_TYPE_SIZE[ast->n1->type], value1);
                sprintf(returnValue,"%%t%d",varIndex);
            }
            else{
               printf("%%t%d = sub i32 1, %%argc\n",varIndex);
               sprintf(returnValue,"%%t%d",varIndex);
            }
            return returnValue;
        }
        else if(ast->n_type == NODE_PARSEARGS){
            //array
            strcpy(value2,generateCode(ast->n2,main));

            //get the array Index (+1 because of the program name)
            varIndex++;
            printTabs(tabs);
            printf("%%t%d = add i32 1 , %s\n",varIndex,value2);

            //get the final pointer
            varIndex++;
            printTabs(tabs);
            printf("%%t%d = getelementptr inbounds i8** %%%s, i32 %%t%d\n",varIndex,ast->n1->value,varIndex-1);

            //get the value
            varIndex++;
            printTabs(tabs);
            printf("%%t%d = load i8** %%t%d\n",varIndex,varIndex-1);

            varIndex++;
            printTabs(tabs);
            printf("%%t%d = call i32 @atoi(i8* %%t%d) nounwind readonly\n",varIndex,varIndex-1);

            sprintf(returnValue,"%%t%d",varIndex);
            return returnValue;



        }
        else if(ast->n_type == NODE_COMPOUNDSTAT){
            tabs++;
            generateCode(ast->n1,main);
            tabs--;
        }
        else if(ast->n_type == NODE_IFELSE){
            //check statement
            strcpy(value1,generateCode(ast->n1,main));
            int tmp = counter4jumps;
            counter4jumps++;
            int temp2;
            //se param is true, do stuff
            varIndex++;
            temp2 = varIndex;
            printTabs(tabs);
            printf("%%t%d = icmp eq i1 1, %s\n", varIndex, value1);
            printTabs(tabs);
            //if
            //varIndex++;
            printf("br i1 %%t%d, label %%if.do%d, label %%if.else%d\n",varIndex,tmp,tmp);
            printf("if.do%d:\n",tmp);
                tabs++;
                pedreiroMaster = 0;
                generateCode(ast->n2,main);
                varIndex+=pedreiroMaster;
                printTabs(tabs);
                printf("br label %%if.end%d\n",tmp);
                tabs--;
            //else
            printf("if.else%d:\n",tmp);
                tabs++;
                generateCode(ast->n3,main);
                tabs--;
            printTabs(tabs);
            printf("br label %%if.end%d\n",tmp);
            printf("if.end%d:\n",tmp);
        }
        else if(ast->n_type == NODE_WHILE){
            //check statement
            int tmp = counter4jumps;
            counter4jumps++;
            int temp2;
            printf("br label %%while.do%d\n",tmp);
            printf("while.do%d:\n",tmp);
            strcpy(value1,generateCode(ast->n1,main));
            //se param is true, do stuff
            varIndex++;
            temp2 = varIndex;
            printTabs(tabs);
            printf("%%t%d = icmp eq i1 1, %s\n", varIndex, value1);
            printTabs(tabs);
            //if
            //varIndex++;
            printf("br i1 %%t%d, label %%while.continue%d, label %%while.end%d\n",varIndex,tmp,tmp);
            printf("while.continue%d:\n",tmp);
                tabs++;
                pedreiroMaster = 0;
                generateCode(ast->n2,main);
                varIndex+=pedreiroMaster;
                printTabs(tabs);
                tabs--;
            printTabs(tabs);
            printf("br label %%while.do%d\n",tmp);
            printf("while.end%d:\n",tmp);
        }
        generateCode(ast->next,main);
    }
    return NULL;

}

#endif
