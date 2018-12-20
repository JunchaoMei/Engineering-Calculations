#!/bin/env python

import sys

for file in sys.argv[1:]:
	filename = file.split('.')[0]
	#charge = raw_input('Charge: ')
	charge = file.split('_')[1]
	
	coords = []
	coord_file = open(file, 'r')
	lines = coord_file.readlines()
	for line in lines[2:]:
		if len(line.split()) == 4:
			coords.append(line)

	coord_file.close()

	input_file = open(filename + '.inp', 'w')
	#input_file.write('! BP86 def2-SVP OPT D3BJ PAL8\n\n')
	input_file.write('! B3LYP ECP{def2-TZVPP,def2-TZVPP/J} def2-TZVPP def2-TZVPP/J  COSMO(water)\n\n') #use this one for COSMO
	#input_file.write('! BP86 ECP{def2-SVP,def2-SVP/J} def2-SVP def2-SVP/J D3BJ COSMO(water)\n\n')
	#input_file.write('! BP86 ECP{def2-SVP,def2-SVP/J} def2-SVP def2-SVP/J COSMO(water) OPT\n\n')
	#input_file.write('! B3LYP ECP{def2-TZVPP,def2-TZVPP/J} def2-TZVPP def2-TZVPP/J COSMO\n%cosmo\nSMD true\nSolvent "Water"\nend\n\n')  #use this one for SMD
	#input_file.write('! BP86 ECP{def2-SVP,def2-SVP/J} def2-SVP def2-SVP/J COSMO\n%cosmo\nSMD true\nSolvent "Water"\nend\n\n')
	#input_file.write('! BP86 ECP{def2-SVP,def2-SVP/J} def2-SVP def2-SVP/J COSMO OPT\n%cosmo\nSMD true\nSolvent "Water"\nend\n\n')
	#input_file.write('! B3LYP def2-TZVPP freq\n\n')  #use this one for frequency calculation
	input_file.write('* xyz {0} 1\n'.format(charge))
	for atom in coords:
		input_file.write(atom)

	input_file.write('*')
	input_file.close()

