#!/bin/bash
bash compile.bash

NUM_TESTS=18

for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijparser < tests/test$i.txt
done
