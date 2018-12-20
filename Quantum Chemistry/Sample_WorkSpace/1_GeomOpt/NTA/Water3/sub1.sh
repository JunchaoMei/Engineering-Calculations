#! /bin/bash

molecule="NTA"

#create string xyzs (*.xyz)
xyz_found=($(find ${molecule}*.xyz))
for i in ${xyz_found[@]}
do xyzs="$xyzs$i "
done

#create *.inp files
python xyz_ORCA_1.py $xyzs

#create string inps (*.inp)
inp_found=($(find ${molecule}*.inp))
for j in ${inp_found[@]}
do inps="$inps$j "
done

#submit jobs (edit ~~~ / 10:00:00)
python subORCA_shared.py 10:00:00 $inps