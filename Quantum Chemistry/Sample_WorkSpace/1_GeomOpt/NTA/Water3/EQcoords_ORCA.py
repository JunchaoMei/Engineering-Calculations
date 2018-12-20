#!/bin/env python

import sys
import OrcaLibrary as OL

for file in sys.argv[1:]:
	coords = OL.EQcoord(file)
	filename = file.split('.')
	coord_file = open(filename[0] + '_EQ.xyz', 'w')
	numatoms = len(coords)
	coord_file.write('{0}\n\n'.format(numatoms))
	for atom in coords:
		coord_file.write('{0} {1} {2} {3}\n'.format(atom[0], atom[1], atom[2], atom[3]))
	
	coord_file.close()
