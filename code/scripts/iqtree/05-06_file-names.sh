## need to rerun to add .sbatch to the file names
## just gets out the file names which i can then pipe to parallel to run the scripts in parallel

mapfile -t chr < chrs.txt
mapfile -t lengths < lengths.txt
wnd=$2
for k in `seq 1 ${#chr[@]}`; do
        let j=$k-1
        c=${chr[${j}]}
        START=0
        END=${lengths[${j}]}/$wnd+1
        MAX=${lengths[${j}]}
        for ((i=$START;i<$END;i++)); do
                        let start=$i*$wnd+1
                        let end=$((start + wnd))
                        end=$((end<MAX ? end : MAX))
                        echo "${c}_${i}_wnd${wnd}.sbatch"
                done
        done


#!/bin/bash
#SBATCH --job-name=gen_cmds
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=3G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=caprina.pugliese@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

## load modules
module load bcftools/1.20

## variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
GENWIND=/home/FCAM/cpugliese/wns/06_iqtree/scripts/06_genwind2.sh
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/

cd $OUTDIR
bash $GENWIND $INDIR/pd_filtered.vcf.gz 10000
## needs to be run: `bash genWind.sh <yourvcf> <window_size>`