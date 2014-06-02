#!/bin/bash
bash compile.bash

NUM_TESTS=1
#for i in $(eval echo "{1..$NUM_TESTS}") ; do
#    echo "Running test $i"
#    ./ijparser < tests/test$i.java  > out.ll
#	llc out.ll
#	gcc -o out out.s
#	./out 0 0 1 1 1 0 0 0 0 0 > outs/outs$i.java
#done

echo "Running final test"
    valgrind --track-origins=yes -v --show-reachable=yes --leak-check=full ./ijparser < tests/test34.java > out.ll
	#llc out.ll
	#gcc -g -o out out.s
	#./out 0 0 1 1 1 0 0 0 0 0
