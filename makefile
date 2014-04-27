lexFile=ijparser.l
yaccFile=ijparser.y
outfile=ijparser

make:
	lex $(lexFile)
	yacc --defines=y.tab.h $(yaccFile) -v
	gcc -o $(outfile) y.tab.c lex.yy.c -ll -ly
