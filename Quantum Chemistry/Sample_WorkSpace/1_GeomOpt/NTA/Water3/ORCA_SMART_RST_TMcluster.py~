#!/bni/env python

import sys
import os
import OrcaLibrary as ol

def ErrorCode(file):
	f = open(file)
	lines = f.readlines()
	f.close()
	
	try:
		code = [line.split()[3] for line in lines if 'RETURN CODE' in line][0]
	except IndexError:	
		code = 'NONE'
		
	return code 

def Completed(file):
	f = open(file)
	lines = f.readlines()
	f.close()
	
	try:
		code = [True for line in lines if 'OPTIMIZATION HAS CONVERGED' in line][0]
	except IndexError:	
		code = False
		
	return code 
	
def CONVERGANCE_CRITERIA(file):
	#check the input file to see if/what convergance criteria keywords are already used...
	f = open(file.split('.')[0] + '.inp', 'r')
	lines = f.readlines()
	
	level = 0
	
	if 'SlowConv' in lines[0]:
		level = 1
		
	if 'VerySlowConv' in lines[0]:
		level = 2
	
	if True in [True for line in lines if 'Shift' in line]:
		level = 3
		
	if True in [True for line in lines if 'DIISMaxEq' in line]:
		level = 4
		
	return level
	
	
path = os.getcwd()

if not os.path.isdir(path +'/COMPLETED'):
		os.makedirs(path + '/COMPLETED')
if not os.path.isdir(path +'/INCOMPLETE'):
		os.makedirs(path + '/INCOMPLETE')
if not os.path.isdir(path +'/CRASH'):
		os.makedirs(path + '/CRASH')


rst_counter = 0
files = sys.argv[1:]
for file in files:
	filename = file.split('.')[0]
	step, GEO_last = ol.LAST_GEO(file)
	
	error = ErrorCode(file) #if it crashed, find the error code, else return NONE
	
	COMPLETED, INCOMPLETE, CRASH = [],[],[]
	if Completed(file):
		COMPLETED.append(filename)
		os.system('mv {0}/{1}.* {0}/COMPLETED'.format(path, filename))
		
	elif error in ['-1', 'NONE']:			#create a restart file with same keywords (just too many geo steps...)
		INCOMPLETE.append(filename)
		rst_counter += 1
		inp_file = open(filename + '.inp', 'r')
		rst_file = open(filename + '_rst.inp', 'w')
		
		copy_flag = True
		for line in inp_file:
			if copy_flag == True:
				rst_file.write(line)
			if '* xyz ' in line:
				copy_flag = False
				
		for atom in GEO_last:
			rst_file.write(atom)
		rst_file.write('*')
		rst_file.close()
		
		os.system('mv {0}/{1}.* {0}/INCOMPLETE'.format(path, filename))

	elif error in ['512', '16384', '29440']:		#create a restart file with escalating SCF convergance keywords depending on the issue
		CRASH.append(filename)
		rst_counter += 1
		
		inp_file = open(filename + '.inp', 'r')
		rst_file = open(filename + '_rst.inp', 'w')
				
		level = CONVERGANCE_CRITERIA(file)

		if level == 0:
			lines = inp_file.readlines()
			for item in lines[0].strip().split():
				if 'SlowConv' not in item:
					rst_file.write(item + ' ')
			rst_file.write(' SlowConv\n\n%scf\nMaxIter 300\nend\n\n')
			for line in lines:
				if '* xyz' in line:
					rst_file.write(line)
			for atom in GEO_last:
				rst_file.write(atom)
			rst_file.write('*')
			rst_file.close()
			
		elif level == 1:
			lines = inp_file.readlines()
			for item in lines[0].strip().split():
				if 'SlowConv' not in item:
					rst_file.write(item + ' ')
			rst_file.write(' VerySlowConv\n\n%scf\nMaxIter 500\nend\n\n')
			for line in lines:
				if '* xyz' in line:
					rst_file.write(line)
			for atom in GEO_last:
				rst_file.write(atom)
			rst_file.write('*')
			rst_file.close()
		elif level == 2: 
			lines = inp_file.readlines()
			for item in lines[0].strip().split():
				if 'SlowConv' not in item:
					rst_file.write(item + ' ')
			rst_file.write(' SlowConv\n\n%scf\nShift Shift 0.1 ErrOff 0.1 end\nMaxIter 300\nend\n\n')
			for line in lines:
				if '* xyz' in line:
					rst_file.write(line)
			for atom in GEO_last:
				rst_file.write(atom)
			rst_file.write('*')
			rst_file.close()
		elif level == 3:
			lines = inp_file.readlines()

			for item in lines[0].strip().split():
				if 'SlowConv' not in item:
					rst_file.write(item + ' ')
			rst_file.write(' SlowConv\n\n%scf\nMaxIter 1000\nDIISMaxEq 15\ndirectresetfreq 1\nend\n\n')
			for line in lines:
				if '* xyz' in line:
					rst_file.write(line)
			for atom in GEO_last:
				rst_file.write(atom)
			rst_file.write('*')
			rst_file.close()
		elif level == 4:
			print 'Abandon all hope, ye who enter {0}'.format(filename)
			
		os.system('mv {0}/{1}.* {0}/CRASH'.format(path, filename))

print '{0} jobs restarted'.format(rst_counter)
