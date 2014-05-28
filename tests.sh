#!/bin/bash
bash compile.bash

NUM_TESTS=34
echo "Running test.java ( enunciado )"
./ijparser < tests/test.java  > out.ll
llc out.ll
gcc -o out out.s
./out;
echo $?
#for i in $(eval echo "{1..$NUM_TESTS}") ; do
#    echo "Running test $i"
#    ./ijparser < tests/test$i.txt
#done
