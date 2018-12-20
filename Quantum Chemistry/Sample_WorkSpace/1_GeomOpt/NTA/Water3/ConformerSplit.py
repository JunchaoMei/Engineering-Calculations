#!/bin/env python

import sys
import os

file1 = sys.argv[1]
file2 = sys.argv[2]

with open(file1, mode='r') as f:
	data = f.read()
	for i,part in enumerate(data.split(file2)):
		with open("Conf_" + str(i+1) + ".xyz", mode="w") as newfile:
			newfile.write("23\n\n")
			newfile.write(file2+part)
			
			

os.remove("Conf_1.xyz")
