#! /bin/bash

molecule="NTA"
n_water=3

#make directory
cd 7_outputs/${molecule}/Water${n_water}
structure_found=($(find * -maxdepth 0 -type d))
for s in ${structure_found[@]}
do
	cd ${s}
	conf_found=($(find *.xyz))
	for c in ${conf_found[@]}
	do
		c="${c%????}"
		mkdir ${c}
		mv ${c}.xyz ./${c}
		cp ../../../../scripts/* ./${c}
		cd ${c}
		stra="10"
		strb="${n_water}"
		cp input.cluster inputcluster.txt
		sed "s/$stra/$strb/g" inputcluster.txt > input.cluster
		rm inputcluster.txt
		mv ${c}.xyz ion.xyz
		IFS='_' read -r -a arr <<< "${c}"
		charge=${arr[1]}
		str1="CHARGE=-1"
		str2="CHARGE=${charge}"
		cp xyz_mopac_opt.py xyz_mopac_opt.txt
		sed "s/$str1/$str2/g" xyz_mopac_opt.txt > xyz_mopac_opt.py
		rm xyz_mopac_opt.txt
		chmod +x oa
		qsub job.sub
		cd ..
	done
	cd ..
done
cd ../../..