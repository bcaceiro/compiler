lexFile=ijscanner.l
yaacFile=ijscanner.l
outfile=out

make:
	lex $(lexFile)
	yacc -d $(yaccFile)
	cc -o $(outfile) y.tab.c lex.yy.c -ll -ly
