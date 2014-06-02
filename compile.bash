flex ijparser.l
yacc --defines=y.tab.h ijparser.y -v
gcc -g -o ijparser *.c -ll -ly 
rm ijparser.zip
zip -r ijparser.zip ijparser.l clean.h clean.c ijparser.y show.c show.h structures.h functions.c generateCode.c generateCode.h
