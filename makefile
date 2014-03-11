infile=projecto.l
outfile=out

make:
	lex $(infile)
	gcc -o $(outfile) lex.yy.c -ll
