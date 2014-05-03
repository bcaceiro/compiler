%{
#include <string.h>
#include "y.tab.h"
#define DEBUG 0

extern int yyval;

int Commentline=0;
int Commentcolumn=0;
int column=1;
%}

%option yylineno

reserved (abstract|assert|break|byte|case|catch|char|const|continue|default|do|double|enum|extends|final|finally|float|for|goto|implements|import|instanceof|interface|long|native|package|private|protected|short|strictfp|super|switch|synchronized|this|throw|throws|transient|try|volatile|null|"++"|"--")

%X COMMENT

%%
<COMMENT><<EOF>> {BEGIN 0;printf("Line %d, col %d: unterminated comment\n",Commentline,Commentcolumn);}
<COMMENT>"*/" {BEGIN 0;column += yyleng;}
<COMMENT>"\n" {column = 1;}
<COMMENT>. {column += yyleng;}
"/*"	{BEGIN COMMENT;Commentcolumn=column;column += yyleng;Commentline = yylineno;}
"//".* {column=1;}

" "|"\t" 				{column  +=  yyleng;}
"\n" 					{column = 1;}

(([0-9])+|("0x"[0-9a-fA-F]+)) {if(DEBUG)if(DEBUG)printf("INTLIT(%s)\n",yytext);column += yyleng;/*yylval = atoi(yytext);*/return INTLIT;}
"true"|"false" 			{if(DEBUG)if(DEBUG)printf("BOOLLIT(%s)\n",yytext);column += yyleng;return BOOLLIT;}
"int" 					{if(DEBUG)printf("INT\n");column += yyleng;return INT;}
"boolean" 				{if(DEBUG)printf("BOOL\n");column += yyleng;return BOOL;}
"new" 					{if(DEBUG)printf("NEW\n");column += yyleng;return NEW;}
"if"					{if(DEBUG)printf("IF\n");column += yyleng;return IF;}
"else"					{if(DEBUG)printf("ELSE\n");column += yyleng;return ELSE;}
"while"					{if(DEBUG)printf("WHILE\n");column += yyleng;return WHILE;}
"System.out.println" 	{if(DEBUG)printf("PRINT\n");column += yyleng;return PRINT;}
"Integer.parseInt" 		{if(DEBUG)printf("PARSEINT\n");column += yyleng;return PARSEINT;}
"class" 				{if(DEBUG)printf("CLASS\n");column += yyleng;return CLASS;}
"public" 				{if(DEBUG)printf("PUBLIC\n");column += yyleng;return PUBLIC;}
"static" 				{if(DEBUG)printf("STATIC\n");column += yyleng;return STATIC;}
"void" 					{if(DEBUG)printf("VOID\n");column += yyleng;return VOID;}
"String" 				{if(DEBUG)printf("STRING\n");column += yyleng;return STRING;}
".length" 				{if(DEBUG)printf("DOTLENGTH\n");column += yyleng;return DOTLENGTH;}
"return" 				{if(DEBUG)printf("RETURN\n");column += yyleng;return RETURN;}
"("						{if(DEBUG)printf("OCURV\n");column += yyleng;return OCURV;}
")"						{if(DEBUG)printf("CCURV\n");column += yyleng;return CCURV;}
"{"						{if(DEBUG)printf("OBRACE\n");column += yyleng;return OBRACE;}
"}"						{if(DEBUG)printf("CBRACE\n");column += yyleng;return CBRACE;}
"["						{if(DEBUG)printf("OSQUARE\n");column += yyleng;return OSQUARE;}
"]"						{if(DEBUG)printf("CSQUARE\n");column += yyleng;return CSQUARE;}
("&&"|"||") 			{if(DEBUG)printf("OP1(%s)\n",yytext);column += yyleng;return OP1;}
("<"|">"|"=="|"!="|"<="|">=") {if(DEBUG)printf("OP2(%s)\n",yytext);column += yyleng;return OP2;}
("+"|"-") {if(DEBUG)printf("OP3(%s)\n",yytext);column += yyleng;return OP3;}
("*"|"/"|"%") {if(DEBUG)printf("OP4(%s)\n",yytext);column += yyleng;return OP4;}
"!" {if(DEBUG)printf("NOT\n");column += yyleng;return NOT;}
"=" {if(DEBUG)printf("ASSIGN\n");column += yyleng;return ASSIGN;}
";" {if(DEBUG)printf("SEMIC\n");column += yyleng;return SEMIC;}
"," {if(DEBUG)printf("COMMA\n");column += yyleng;return COMMA;}
{reserved} {if(DEBUG)printf("RESERVED(%s)\n",yytext);column += yyleng;return RESERVED;}
[a-zA-Z_$]([a-zA-Z_$0-9])* {if(DEBUG)printf("ID(%s)\n",yytext);column += yyleng;yylval.token = strdup(yytext);return ID;}
. {printf("Line %d, col %d: illegal character ('%s')\n",yylineno,column,yytext);column += yyleng;}


%%

int yywrap()
{
return 1;
}
