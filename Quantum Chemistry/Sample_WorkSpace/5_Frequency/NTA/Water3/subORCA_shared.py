#!/bin/env python

import sys
import os

file  = sys.argv[2:]

nodes = '1'#raw_input('Nodes requested: ')
ppn   =	'8' #raw_input('PPN: ')
Walltime = sys.argv[1] #raw_input('Walltime (hr:min:sec): ')

for item in file:
	if item[-3:]=='inp':
		filename=item.split('.')
		if filename[0]+'.sub' in file:
			print 'Submissionfile already exists for '+filename[0]
		else:
			subfile=open(item[:-3]+'sub','w')
			
			subfile.write('#!/usr/bin/env bash\n')

			subfile.write('#SBATCH --time=0-{0}\n'.format(Walltime))
			subfile.write('#SBATCH --job-name={0}\n'.format(filename[0]))
			subfile.write('#SBATCH --output={0}.out\n'.format(filename[0]))
			subfile.write('#SBATCH --nodes=1\n')
		        subfile.write('#SBATCH --ntasks-per-node=12\n')
                        subfile.write('#SBATCH --cluster=smp\n')
                        
			
			subfile.write('module purge\n')
			subfile.write('module load orca/3.0.3\n')

			subfile.write('files=(\n')
			subfile.write('{0}.inp\n'.format(filename[0]))
			subfile.write(')\n')
			subfile.write('for i in ${files[@]}; do\n')
			subfile.write('sbcast $SLURM_SUBMIT_DIR/$i $SLURM_SCRATCH/$i\n')
			subfile.write('done\n')
			
			subfile.write('export LD_LIBRARY_PATH=/usr/lib64/openmpi-1.10/lib: $LD_LIBRARY_PATH\n')
			subfile.write('export PATH=/usr/lib64/openmpi-1.10/bin:$PATH\n')
			
			subfile.write('cd $SLURM_SCRATCH\n')
			subfile.write('$(which orca) {0}.inp\n'.format(filename[0]))
			subfile.write('cp $SLURM_SCRATCG/*.{gbw,prop,out} $SLURM_SUBMIT_DIR\n')
			

			
			subfile.close()

			print('item has been submitted as: ')	
			os.system('sbatch '+item[:-3]+'sub')


