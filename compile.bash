flex ijparser.l
yacc --defines=y.tab.h ijparser.y -v
gcc *.c *.h -ll -ly -g -o ijparser 
rm ijparser.zip
zip -r ijparser.zip ijparser.l ijparser.y show.c show.h structures.h functions.c
