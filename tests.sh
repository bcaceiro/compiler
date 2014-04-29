#!/bin/bash
bash compile.bash

NUM_TESTS=18
echo "Running test.java ( enunciado )"
./ijparser < tests/test$i.txt
for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijparser < tests/test$i.txt
done
