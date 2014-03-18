%{
int line=1;
int column=1;
%}
%x COMMENT
reserved (abstract|assert|break|byte|case|catch|char|const|continue|default|do|double|enum|extends|final|finally|float|for|goto|implements|import|instanceof|interface|long|native|package|private|protected|short|strictfp|super|switch|synchronized|this|throw|throws|transient|try|volatile)
%%
<COMMENT>

"true"|"false" {printf("BOOLLIT\n");column+=yyleng;}
"int" {printf("INT\n");column+=yyleng;}
"boolean" {printf("BOOL\n");column+=yyleng;}
"new" {printf("NEW\n");column+=yyleng};
"if" {printf("IF\n");column+=yyleng};
"else" {printf("ELSE\n");column+=yyleng};
"while" {printf("WHILE\n");column+=yyleng};
"System.out.println" {printf("PRINT\n");column+=yyleng};
"class" {printf("CLASS\n");column+=yyleng;}
"{" {printf("OBRACE\n");column+=yyleng;}
"}" {printf("CBRACE\n");column+=yyleng;}
"(" {printf("OCURV\n");column+=yyleng;}
")" {printf("CCURV\n");column+=yyleng;}
"[" {printf("OSQUARE\n");column+=yyleng;}
"]" {printf("CSQUARE\n");column+=yyleng;}
("&&"|"||") {printf("OP1\n");column+=yyleng;}
("<"|">"|"=="|"!="|"<="|">=") {printf("OP2\n");column+=yyleng;}
("+"|"-") {printf("OP3\n");column+=yyleng;}
("*"|"/"|"%") {printf("OP4\n");column+=yyleng;}
"!" {printf("NOT\n");column+=yyleng;}
"=" {printf("ASSIGN\n");column+=yyleng;}
";" {printf("SEMIC\n");column+=yyleng;}
"," {printf("COMMA\n");column+=yyleng;}
"public" {printf("PUBLIC\n");column+=yyleng;}
"static" {printf("STATIC\n");column+=yyleng;}
"void" {printf("VOID\n");column+=yyleng;}
"return" {printf("RETURN\n");column+=yyleng;}
{reserved} {printf("RESERVED\n");column+=yyleng;}
[A-z]+([A-z]|[0-9]|"_"|"$")* {printf("ID(%s)\n",yytext);column+=yyleng;}
" "|"\t" {column+=yyleng;}
"\n" {line++;column = 0;}


%%

int main()
{
	yylex();
}

int yywrap()
{
return 1;
}
