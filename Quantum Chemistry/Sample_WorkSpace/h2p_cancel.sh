#! /bin/bash

for ((i=912000; i<=912010; i ++))
do
	scancel -M smp ${i}
done