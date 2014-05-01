#include "show.h"
#include "structures.h"
#include <stdlib.h>
#include <stdio.h>

/*void show_program(is_expression_list* iel)
{
	is_expression_list* aux;
	
	for(aux=iel; aux!=NULL; aux=aux->next)
		{
		printf("expression(");
		show_expression(aux->expr);
		printf(")\n");
		}
}

void show_expression(is_expression* ie)
{
	switch(ie->disc_d)
	{
	case d_infix_exp: printf("infix("); 
			  show_infix_expression((is_infix_expression*)ie->data_expression.u_infix_exp); 
			  printf(")");
			  break;
	case d_unary_exp: printf("unary("); 
			  show_unary_expression((is_unary_expression*)ie->data_expression.u_unary_exp); 
			  printf(")");
			  break;
	case d_number:	printf("NUMBER(%d)", ie->data_expression.number);
			break;
	}
}

void show_infix_expression(is_infix_expression* iie)
{
	show_expression(iie->exp1);
	printf(", ");
	show_operator(iie->oper);
	printf(", ");
	show_expression(iie->exp2);
}

void show_unary_expression(is_unary_expression* iue)
{
	show_expression(iue->exp);
}

void show_operator(is_oper oper)
{
	if(oper==is_PLUS)
		printf("+");
	else
		printf("-");
}*/

/*Symbols*/
/*
void printSymbols(ClassTable* table){
    printf("TODO\n");
}*/
