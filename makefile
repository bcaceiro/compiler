lexFile=ijparser.l
yaacFile=ijparser.y
outfile=out

make:
	lex $(lexFile)
	yacc --defines=y.tab.h $(yaacFile)
	cc -o $(outfile) y.tab.c lex.yy.c -ll -ly
