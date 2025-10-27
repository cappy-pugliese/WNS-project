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

hostname
date

## load modules
module load bcftools/1.20

## variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
OUTDIR=/home/FCAM/cpugliese/lab_wns/07_iqtree/01_genWind/02_Cappy-cmds
GENWIND=/home/FCAM/cpugliese/wns/06_iqtree/scripts/genWind_cmds.sh

cd $OUTDIR
bash $GENWIND $INDIR/pd_filtered.vcf.gz 10000
## needs to be run: `bash genWind.sh <yourvcf> <window_size>`

########### script end
