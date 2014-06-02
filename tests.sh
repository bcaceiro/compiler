#!/bin/bash
bash compile.bash

NUM_TESTS=34
for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijparser < tests/test$i.java  > out.ll
	llc out.ll
	gcc -o out out.s
	./out > outs/outs$i.java
done

echo "Running final test"
   ./ijparser < tests/test.java  > out.ll
	llc out.ll
	gcc -o out out.s
	./out
