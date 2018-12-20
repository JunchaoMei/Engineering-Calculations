#! /bin/bash

molecule="NTA"

#create directory $molecule
if [ ! -d '/${molecule}' ]
	then mkdir ${molecule}
fi

#move files
mv ${molecule}*EQ.* ./${molecule}

grep G-E ./${molecule}/${molecule}*EQ.out > ./results/${molecule}.txt
