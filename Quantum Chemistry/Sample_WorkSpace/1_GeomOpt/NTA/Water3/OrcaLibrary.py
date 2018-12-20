#!/bin/env python

def EQcoord(file):
	output_file = open(file, 'r')
	EQ_flag = False
	coord_flag = False
	copy_flag = False
	coords = []
	
	for line in output_file:
		if 'THE OPTIMIZATION HAS CONVERGED' in line:
			EQ_flag = True
			coord_flag = False
			copy_flag = True
		if 'CARTESIAN COORDINATES (ANGSTROEM)' in line:
			coord_flag = True
		if 'CARTESIAN COORDINATES (A.U.)' in line:
			coord_flag = False
			copy_flag = False
			
		if EQ_flag == True and coord_flag == True and copy_flag == True:
			line = line.split()
			if len(line) == 4:
				coords.append(line)
	output_file.close()
				
	return coords
	
def last_coords(file):
	output_file = open(file, 'r')
	coord_flag = False
	coords = []
	
	for line in output_file:
		if 'CARTESIAN COORDINATES (ANGSTROEM)' in line:
			coords = []
			coord_flag = True
		if 'CARTESIAN COORDINATES (A.U.)' in line:
			coord_flag = False
			copy_flag = False
			
		if  coord_flag == True:
			line = line.split()
			if len(line) == 4:
				coords.append(line)
	output_file.close()
				
	return coords
def FREQUread(file):
	output_file = open(file, 'r')
	FREQU_flag = False
	Frequ = []
	
	for line in output_file:
		
		
		if 'VIBRATIONAL FREQUENCIES' in line:
			FREQU_flag = True
			Frequ = []
		if 'NORMAL MODES' in line:
			FREQU_flag = False
		
		if FREQU_flag == True:
			line = line.split()
			if len(line) > 2:
				if line[2] == 'cm**-1':
					Frequ.append((line[0][:-1], line[1]))
	output_file.close()
				
	return Frequ
		
def FREQvec(file, numatoms, mode):
	#have this ask for a specific vector, and return only that one...
	output_file = open(file, 'r')
	MODE_flag = False
	vec = []
	save = []

	for line in output_file:
		if 'NORMAL MODES' in line:
			MODE_flag = True
			vec = []
			save = []
		if 'IR SPECTRUM' in line:
			MODE_flag = False
		
		if MODE_flag == True:
			save.append(line)
	counter=0		
	
	for line in save[(int(mode/6)*(numatoms * 3 + 1) + 8): ((int(mode/6)+1)*(numatoms * 3) + 8 + int(mode/6))]:
		vec.append(line.split()[int(mode - int(mode/6)*6 + 1)])
	
	return vec
	
	
def INP_XYZ(file):
	filename = file.split('.')[0]
	inputfile = open(filename + '.inp', 'r')
	coord_flag = False
	coords = []
	for line in inputfile:
		if coord_flag == True:
			if len(line.split()) == 4:
				coords.append(line.split())	
		if '* xyz' in line:
			coord_flag = True

	return coords

	
def LAST_GEO(file):
#returns the final set of coordinates from a geometry optimization.
	coord_file = open(file, 'r')
	GEO = []
	step = 0
	coord_flag = False
	for line in coord_file:
		if 'CARTESIAN COORDINATES' in line:
			coord_flag = False
		if 'CARTESIAN COORDINATES (ANGSTROEM)' in line:
			coord_flag = True
			GEO = []
		if coord_flag == True:
			if len(line.split()) == 4:
				GEO.append(line)
		if 'GEOMETRY OPTIMIZATION CYCLE' in line:
			step = line.split()[4]
	return step, GEO
		
	
