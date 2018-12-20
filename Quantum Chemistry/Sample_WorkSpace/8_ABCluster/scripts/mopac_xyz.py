#!/bin/env python

import sys

files = sys.argv[1:]

for file in files:
	filename = file[:-4]
	if file[-4:] == '.out':
		geo = []

		Geo_flag = False
		n=0	
		output_file = open(file, 'r')
		for line in output_file:
			if ('CARTESIAN COORDINATES' in line) == True:
				Geo_flag = True
				n += 1
			if 'Empirical' in line:
				Geo_flag = False
			if (Geo_flag == True) and n > 1:
				if len(line.split()) == 5:
					item = line.split()
					geo.append([item[1], item[2], item[3], item[4]])
		
		output_file.close()
		
		coord_file = open(filename + '.xyz', 'w')
		coord_file.write(str(len(geo)) + '\n\n')
		for line in geo:
			coord_file.write(line[0] + ' ' + line[1] + ' ' + line[2] + ' ' + line[3] + '\n')
		coord_file.close()
		
