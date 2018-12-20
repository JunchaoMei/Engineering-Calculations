#!/bin/env python

import sys

def EQcoord(file):
	output_file = open(file, 'r')
	copy_flag = False
	coords = []
	
	for line in output_file:
		if 'FINAL GEOMETRY OBTAINED' in line:
			copy_flag = True
			
		if copy_flag == True:
			line = line.split()
			if len(line) == 7:
				coords.append(line)
	output_file.close()
				
	return coords

for file in sys.argv[1:]:
	coords = EQcoord(file)
	filename = file.split('.')
	coord_file = open(filename[0] + '_preOpt.xyz', 'w')
	numatoms = len(coords)
	coord_file.write('{0}\n\n'.format(numatoms))
	for atom in coords:
		coord_file.write('{0} {1} {2} {3}\n'.format(atom[0],atom[1],atom[3],atom[5]))
	
	coord_file.close()
