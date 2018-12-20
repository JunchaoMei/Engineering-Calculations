#! /bin/bash

molecule="NTA"
n_conf=5
n_lowest=2

#load modules
module purge
module load openbabel/dev-github
module load mopac

#get all structure names (eg. citrate_-1_0-1_a.xyz)
structures_found=($(find ${molecule}*.xyz))

#make directories
mkdir completed/${molecule}
mkdir completed/${molecule}/Alls #(eg. citrate/Alls)
mkdir completed/${molecule}/Conformers #(eg. citrate/Conformers)
mkdir completed/All_PreOpt/${molecule}

for i in ${structures_found[@]}
do
	#chop it as pure names (eg. citrate_-1_0-1_a)
	i="${i%????}"

	#get charge
	IFS='_' read -r -a arr <<< "$i"
	charge=${arr[1]}

	#generate conformers
	obabel ${i}.xyz -O ${i}_All.xyz --conformer --nconf ${n_conf} --writeconformers

	#get number of lines
	n_atom=$(sed -n '1p' ${i}.xyz) #grab the first paragraph as the atom numer
	n_atom="${n_atom%?}" #remove the last char [?(last) #(first)]
	n_line=$((n_atom+2))

	#split the collectional xyz file
	split -l ${n_line} ${i}_All.xyz ${i}_conf.xyz
	mv ${i}_All.xyz ./completed/${molecule}/Alls


	#rename splited files
	conformers_found=($(find ${i}_conf.xyz*))
	for j in ${conformers_found[@]}
	do
		#rename "citrate_-1_0-1_a_conf.xyzaa" as "citrate_-1_0-1_a_conf_aa.xyz"
		last2=${j: -2}
		j_pure="${j%??????}" #chop it as pure names (eg. citrate_0_0-0_b_conf)
		mv ${j} ./${j_pure}_$last2.xyz

		babel ${j_pure}_$last2.xyz ${j_pure}_$last2.mop

		#replace "PUT KEYWORDS HERE" as "PM6-D3H4 BFGS CHARGE=?"
		cp ${j_pure}_$last2.mop ${j_pure}_$last2.mop~
		str1="PUT KEYWORDS HERE"
		str2="PM6-D3H4 BFGS CHARGE=${charge}"
		sed "s/$str1/$str2/g" ${j_pure}_$last2.mop~ > ${j_pure}_$last2.mop

		mopac ${j_pure}_$last2.mop
	done
	
	#move files
	rm *.mop~
	mkdir completed/${molecule}/Conformers/${i}_conformers
	mkdir completed/${molecule}/Conformers/${i}_conformers/xyz
	mkdir completed/${molecule}/Conformers/${i}_conformers/mop
	mkdir completed/${molecule}/Conformers/${i}_conformers/out
	mkdir completed/${molecule}/Conformers/${i}_conformers/arc
	mv ${i}_conf*.xyz ./completed/${molecule}/Conformers/${i}_conformers/xyz
	mv ${i}_conf*.mop ./completed/${molecule}/Conformers/${i}_conformers/mop
	mv ${i}_conf*.out ./completed/${molecule}/Conformers/${i}_conformers/out
	mv ${i}_conf*.arc ./completed/${molecule}/Conformers/${i}_conformers/arc
	cp EQcoords_mopac.py ./completed/${molecule}/Conformers/${i}_conformers/arc
	cd completed/${molecule}/Conformers/${i}_conformers/arc

	#grep & sort
	grep TOTAL ${i}_conf*.arc > temp0.txt
	sed "s/=/:/g" temp0.txt > temp1.txt #[=] -> [:]
	sed "s/ //g" temp1.txt > temp2.txt #[ ] -> []
	sed "s/EV/:EV/g" temp2.txt > temp3.txt #[EV] -> [:EV]
	sort -nk 3 -t: temp3.txt > temp4.txt
	k=0
	while read line
	do
		if [ "$k" -lt "${n_lowest}" ]; then
			IFS='.' read -r -a arr <<< "$line"
			conformer[k]=${arr[0]} #(eg. citrate_-2_0-2_a_conf_aa)
			conformer_arc[k]=${arr[0]}.arc #(eg. citrate_-2_0-2_a_conf_aa.arc)
			((k++))
		fi
	done < temp4.txt
	rm temp*.txt

	#extract
	python EQcoords_mopac.py ${conformer_arc[@]}

	#re-organize
	mkdir ../../../../All_PreOpt/${molecule}/${i}
	for e in ${conformer[@]}
	do
		mv ${e}_preOpt.xyz ./../../../../All_PreOpt/${molecule}/${i}
	done
	cd ../../../../..
done