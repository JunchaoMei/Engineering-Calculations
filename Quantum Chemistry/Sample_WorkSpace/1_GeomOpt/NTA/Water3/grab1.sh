#! /bin/bash

molecule="NTA"

xyz_found=($(find ${molecule}*.xyz))

for i in ${xyz_found[@]}
do
	i="${i%????}"
	if [ -f "${i}_rst.inp" ]; then
		rm ${i}.out
		if [ -f "${i}_rst_rst.inp" ]; then
			rm ${i}_rst.out
			if [ -f "${i}_rst_rst_rst.inp" ]; then
				rm ${i}_rst_rst.out
				if [ -f "${i}_rst_rst_rst_rst.inp" ]; then
					rm ${i}_rst_rst_rst.out
				fi
			fi
		fi
	fi
done

mkdir out
mv *.out ./out
cp OrcaLibrary.py ./out
cp EQcoords_ORCA.py ./out
cd out

rst_found=($(find ${molecule}*_rst.out))
for r1 in ${rst_found[@]}
do
	r1="${r1%????????}"
	mv ${r1}_rst.out ${r1}.out
done
rst_rst_found=($(find ${molecule}*_rst_rst.out))
for r2 in ${rst_rst_found[@]}
do
	r2="${r2%????????????}"
	mv ${r2}_rst_rst.out ${r2}.out
done
rst_rst_rst_found=($(find ${molecule}*_rst_rst_rst.out))
for r3 in ${rst_rst_rst_found[@]}
do
	r3="${r3%????????????????}"
	mv ${r3}_rst_rst_rst.out ${r3}.out
done
rst_rst_rst_rst_found=($(find ${molecule}*_rst_rst_rst_rst.out))
for r4 in ${rst_rst_rst_rst_found[@]}
do
	r4="${r4%????????????????????}"
	mv ${r4}_rst_rst_rst_rst.out ${r4}.out
done

python EQcoords_ORCA.py ${molecule}*.out
mkdir EQ
mv ${molecule}*EQ.xyz ./EQ

cd ..
mkdir inp
mv *.inp ./inp
mkdir sub
mv *.sub ./sub
mkdir xyz
mv *.xyz ./xyz