flex ijparser.l
yacc --defines=y.tab.h ijparser.y -v
gcc -o ijparser y.tab.c lex.yy.c -ll -ly -g

rm ijparser.zip
zip -r ijparser.zip ijparser.l ijparser.y show.c show.h structures.h functions.c
