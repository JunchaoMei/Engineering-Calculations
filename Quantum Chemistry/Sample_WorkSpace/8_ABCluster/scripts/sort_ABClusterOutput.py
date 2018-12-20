#!/bin/python

import sys
import os

data = []

for file in sys.argv[1:]:
	f = open(file, 'r')
	lines = f.readlines()
	f.close()
	
	data.append((file, float(lines[1].split()[2])))

d = [b for a,b in sorted((tup[1], tup) for tup in data)]

os.system('mkdir BP86-OPTs')

print 'There are {0} geometries'.format(len(d))

for item in d[:2]:
	#print item[1]
	os.system('cp {0} BP86-OPTs'.format(item[0]))



