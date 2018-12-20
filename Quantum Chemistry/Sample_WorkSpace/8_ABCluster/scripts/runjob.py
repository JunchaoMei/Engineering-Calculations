#!/bin/python

import sys
import os

#run the job one time
os.system('/ihome/jkeith/mcg64/work/ABCluster/ABCluster-Linux/lego solute.inp > solute.out')
path = os.getcwd()

data = []

for file in os.listdir(path + '/solute-LM'):
	if file.endswith('xyz'):
		data.append(file)

print 'There are {0} geometries'.format(len(data))

while len(data) < 2000:
	print 'Only {0} calcs, resubmitting the ABCluster calculation...'.format(len(data))
	
	if len(data) > 2000:
		break
	
	N = 1
	while os.path.isdir(path + '/solute-LM-{0}'.format(N)):
		N += 1

	os.system('mv solute-LM solute-LM-{0}'.format(N))
	os.system('mv solute.out solute_{0}.out'.format(N))
	os.system('/ihome/jkeith/mcg64/work/ABCluster/ABCluster-Linux/lego solute.inp > solute.out')
	
	for file in os.listdir(path + '/solute-LM'):
		if file.endswith('xyz'):
			data.append(file)
	
	


