#!/bin/env python

import sys

d = open('input.cluster', 'r')
lines_d = d.readlines()
solute_file, solute_n = lines_d[1].split()
solvent_file, solvent_n = lines_d[2].split()

solute = open(solute_file, 'r')
lines_solute = solute.readlines()
n = lines_solute[0]
solvent = open(solvent_file, 'r')
lines_solvent = solvent.readlines()
m = lines_solvent[0]

solute_atoms = int(n) * int(solute_n)
solvent_atoms = int(m) * int(solvent_n)


files=sys.argv

coord = files[1]
fn = files[2]

print coord, fn
coords = []
c = open(coord, 'r')
lines = c.readlines()
c.close()

for line in lines:
	print line
	coords.append(line.split())


f = open(fn, 'w')
f.write('PM6-D3 BFGS GEO-OK CHARGE=-1\n\n\n')
#f.write('PM7 BFGS INT\n\n\n')
for atom in coords[:solute_atoms]:
	f.write('{0} {1} 1 {2} 1 {3} 1\n'.format(atom[0], atom[1], atom[2], atom[3]))
for atom in coords[solute_atoms:]:
	f.write('{0} {1} 1 {2} 1 {3} 1\n'.format(atom[0], atom[1], atom[2], atom[3]))

f.close()
	

