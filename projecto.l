
reserved (abstract|assert|break|byte|case|catch|char|const|continue|default|do|double|enum|extends|final|finally|float|for|goto|implements|import|instanceof|interface|long|native|package|private|protected|short|strictfp|super|switch|synchronized|this|throw|throws|transient|try|volatile);
invalid ("?"|"!");
%%

"class" {printf("CLASS\n");}
"{" {printf("OBRACE\n");}
"}" {printf("CBRACE\n");}
"(" {printf("OCURV\n");}
")" {printf("CCURV\n");}
"[" {printf("OSQUARE\n");}
"]" {printf("CSQUARE\n");}
("&&"|"||") {printf("OP1");}
("<"|">"|"=="|"!="|"<="|">=") {printf("OP2");}
("+"|"-") {printf("OP3");}
("*"|"/"|"%") {printf("OP4");}
"!" {printf("NOT");}
"=" {printf("ASSIGN");}
";" {printf("SEMIC");}
"," {printf("COMMA");}
"public" {printf("PUBLIC\n");}
"static" {printf("STATIC\n");}
"void" {printf("VOID\n");}
"return" {printf("RETURN\n");}
{reserved} {printf("RESERVED WORD\n");}
[a-z]+([a-z]|[0-9]|"_"|"$")*"{" {printf("ID(%s)\n",yytext);}

%%

int main()
{
	yylex();
}

int yywrap()
{
return 1;
}
