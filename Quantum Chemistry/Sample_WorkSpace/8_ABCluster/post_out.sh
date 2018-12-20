#! /bin/bash

molecule="NTA"
n_water=3

mkdir 8_outputs/${molecule}/Water${n_water}
cd 7_outputs/${molecule}/Water${n_water}
structure_found=($(find * -maxdepth 0 -type d))
for s in ${structure_found[@]}
do
	mkdir ../../../8_outputs/${molecule}/Water${n_water}/${s}
	mkdir ../../../8_outputs/${molecule}/Water${n_water}/${s}/from
	cp ../../../scripts/sort_ABClusterOutput.py ../../../8_outputs/${molecule}/Water${n_water}/${s}
	cd ${s}
	conf_found=($(find * -maxdepth 0 -type d))
	for c in ${conf_found[@]}
	do
		cd ${c}
		IFS='_' read -r -a segC <<< "${c}"
		mkdir SOLUTE
		mv solute-LM solute-LM-0
		LM_found=($(find solute-LM* -maxdepth 0 -type d))
		for lm in ${LM_found[@]}
		do
			cd ${lm}
			IFS='-' read -r -a arr <<< "${lm}"
			i_lm=${arr[2]}
			xyz_found=($(find *.xyz))
			for xyzfile in ${xyz_found[@]}
			do
				pure="${xyzfile%.xyz}"
				mv ${pure}.xyz ${i_lm}-${pure}.xyz
			done
			cd ..
		done
		cp ./solute-LM*/*.xyz ./SOLUTE
		python sort_ABClusterOutput.py ./SOLUTE/*.xyz
		cd BP86-OPTs
		sort_found=($(find *.xyz))
		for sortxyz in ${sort_found[@]}
		do
			puresort="${sortxyz%.xyz}"
			mv ${puresort}.xyz ${segC[0]}_${segC[1]}_${segC[2]}[${segC[3]}]_${segC[4]}[${segC[5]}]_${puresort}.xyz
		done
		cp * ../../../../../../8_outputs/${molecule}/Water${n_water}/${s}/from
		cd ..
		echo finish sort ${c}
		cd ..
	done
	echo FINISH SORT ${s}
	cd ..
done
cd ../../..
cd 8_outputs/${molecule}/Water${n_water}
rm -rf SOLUTE
structure_found=($(find * -maxdepth 0 -type d))
for s in ${structure_found[@]}
do
	cd ${s}
	python sort_ABClusterOutput.py ./from/*.xyz
	cp BP86-OPTs/* ./
	rm -rf from
	rm -rf BP86-OPTs
	rm sort_ABClusterOutput.py
	cd ..
done
cd ../../..