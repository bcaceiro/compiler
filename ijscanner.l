%{
int Commentline=0;
int Commentcolumn=0;
int column=1;
%}

%option yylineno

reserved (abstract|assert|break|byte|case|catch|char|const|continue|default|do|double|enum|extends|final|finally|float|for|goto|implements|import|instanceof|interface|long|native|package|private|protected|short|strictfp|super|switch|synchronized|this|throw|throws|transient|try|volatile|null)

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

(([0-9])+|("0x"[0-9a-fA-F]+)) {printf("INTLIT(%s)\n",yytext);column += yyleng;}
"true"|"false" 			{printf("BOOLLIT(%s)\n",yytext);column += yyleng;}
"int" 					{printf("INT\n");column += yyleng;}
"boolean" 				{printf("BOOL\n");column += yyleng;}
"new" 					{printf("NEW\n");column += yyleng;}
"if"					{printf("IF\n");column += yyleng;}
"else"					{printf("ELSE\n");column += yyleng;}
"while"					{printf("WHILE\n");column += yyleng;}
"System.out.println" 	{printf("PRINT\n");column += yyleng;}
"Integer.parseInt" 		{printf("PARSEINT\n");column += yyleng;}
"class" 				{printf("CLASS\n");column += yyleng;}
"public" 				{printf("PUBLIC\n");column += yyleng;}
"static" 				{printf("STATIC\n");column += yyleng;}
"void" 					{printf("VOID\n");column += yyleng;}
"String" 				{printf("STRING\n");column += yyleng;}
".length" 				{printf("DOTLENGTH\n");column += yyleng;}
"return" 				{printf("RETURN\n");column += yyleng;}
"("						{printf("OCURV\n");column += yyleng;}
")"						{printf("CCURV\n");column += yyleng;}
"{"						{printf("OBRACE\n");column += yyleng;}
"}"						{printf("CBRACE\n");column += yyleng;}
"["						{printf("OSQUARE\n");column += yyleng;}
"]"						{printf("CSQUARE\n");column += yyleng;}
("&&"|"||") 			{printf("OP1(%s)\n",yytext);column += yyleng;}
("<"|">"|"=="|"!="|"<="|">=") {printf("OP2(%s)\n",yytext);column += yyleng;}
("+"|"-") {printf("OP3(%s)\n",yytext);column += yyleng;}
("*"|"/"|"%") {printf("OP4(%s)\n",yytext);column += yyleng;}
"!" {printf("NOT\n");column += yyleng;}
"=" {printf("ASSIGN\n");column += yyleng;}
";" {printf("SEMIC\n");column += yyleng;}
"," {printf("COMMA\n");column += yyleng;}
{reserved} {printf("RESERVED(%s)\n",yytext);column += yyleng;}
[a-zA-Z_$]([a-zA-Z_$0-9])* {printf("ID(%s)\n",yytext);column += yyleng;}
. {printf("Line %d, col %d: illegal character ('%s')\n",yylineno,column,yytext);column += yyleng;}


%%

int main()
{
	yylex();
}

int yywrap()
{
return 1;
}
